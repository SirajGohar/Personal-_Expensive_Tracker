import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/expense_model.dart';
import '../widgets/expense_tile.dart';
import 'add_expense_page.dart';
import 'stats_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final expenseBox = Hive.box<Expense>('expenses');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.pie_chart),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const StatsPage()),
            ),
          )
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: expenseBox.listenable(),
        builder: (context, Box<Expense> box, _) {
          if (box.values.isEmpty) {
            return const Center(child: Text("No expenses yet."));
          }
          return ListView.builder(
            itemCount: box.values.length,
            itemBuilder: (context, index) {
              Expense expense = box.getAt(index)!;
              return ExpenseTile(
                expense: expense,
                onDelete: () => expense.delete(),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AddExpensePage()),
        ),
      ),
    );
  }
}
