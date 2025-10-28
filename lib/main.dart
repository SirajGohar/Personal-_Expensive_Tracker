import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/expense_model.dart';
import 'pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ExpenseAdapter() as TypeAdapter);
  await Hive.openBox<Expense>('expenses');
  runApp(const ExpenseTrackerApp());
}

class ExpenseAdapter {
}

class ExpenseTrackerApp extends StatelessWidget {
  const ExpenseTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
