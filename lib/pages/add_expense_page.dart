import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/expense_model.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({super.key});

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  double amount = 0.0;
  String category = 'General';
  final List<String> categories = ['Food', 'Transport', 'Shopping', 'Bills', 'Other'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Expense")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: "Title"),
                onSaved: (val) => title = val!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Amount"),
                keyboardType: TextInputType.number,
                onSaved: (val) => amount = double.parse(val!),
              ),
              DropdownButtonFormField(
                decoration: const InputDecoration(labelText: "Category"),
                items: categories.map((cat) {
                  return DropdownMenuItem(value: cat, child: Text(cat));
                }).toList(),
                onChanged: (val) => category = val!,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _formKey.currentState!.save();
                  final expense = Expense(
                    title: title,
                    amount: amount,
                    date: DateTime.now(),
                    category: category,
                  );
                  Hive.box<Expense>('expenses').add(expense);
                  Navigator.pop(context);
                },
                child: const Text("Save"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
