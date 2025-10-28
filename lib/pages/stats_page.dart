import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/expense_model.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final expenses = Hive.box<Expense>('expenses').values.toList();
    final categoryTotals = <String, double>{};

    for (var exp in expenses) {
      categoryTotals[exp.category] = (categoryTotals[exp.category] ?? 0) + exp.amount;
    }

    final pieData = categoryTotals.entries.map((e) {
      return PieChartSectionData(
        title: e.key,
        value: e.value,
        radius: 80,
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text("Expense Statistics")),
      body: Center(
        child: expenses.isEmpty
            ? const Text("No data to show.")
            : PieChart(PieChartData(sections: pieData)),
      ),
    );
  }
}
