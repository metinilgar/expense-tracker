import 'package:flutter/material.dart';

import 'package:expense_tracker/src/constants.dart';
import 'package:expense_tracker/src/presentation/add_new_expense/components/amount_text_field.dart';
import 'package:expense_tracker/src/presentation/add_new_expense/components/category_dropdown.dart';
import 'package:expense_tracker/src/presentation/add_new_expense/components/date_picker_widget.dart';
import 'package:expense_tracker/src/presentation/add_new_expense/components/title_text_field.dart';
import 'package:expense_tracker/src/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
              'Please make sure a valid title, amount, date and category was entered'),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Okay'))
          ],
        ),
      );
      return;
    }
    widget.onAddExpense(Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory));
    Navigator.pop(context);
  }

  void dropdownButtonOnChanged(Category? value) {
    if (value == null) {
      return;
    }
    setState(() {
      _selectedCategory = value;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    final Widget cancelButton = TextButton(
      onPressed: () => Navigator.pop(context),
      child: const Text('Cancel'),
    );

    final Widget saveButton = ElevatedButton(
        onPressed: () => _submitExpenseData(),
        child: const Text('Save Expense'));

    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;

      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
          child: Column(
            children: [
              if (width >= 600)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TitleTextField(titleController: _titleController),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child:
                          AmountTextField(amountController: _amountController),
                    ),
                  ],
                )
              else
                TitleTextField(titleController: _titleController),
              if (width >= 600)
                Row(children: [
                  CategoryDropdown(
                      selectedCategory: _selectedCategory,
                      onChanged: dropdownButtonOnChanged),
                  DatePickerWidget(
                    presentDatePicker: _presentDatePicker,
                    selectedDate: _selectedDate,
                  )
                ])
              else
                Row(
                  children: [
                    Expanded(
                      child:
                          AmountTextField(amountController: _amountController),
                    ),
                    const SizedBox(width: 16),
                    DatePickerWidget(
                      presentDatePicker: _presentDatePicker,
                      selectedDate: _selectedDate,
                    ),
                  ],
                ),
              const SizedBox(height: 16),
              if (width >= 600)
                Row(children: [const Spacer(), cancelButton, saveButton])
              else
                Row(
                  children: [
                    CategoryDropdown(
                        selectedCategory: _selectedCategory,
                        onChanged: dropdownButtonOnChanged),
                    const Spacer(),
                    cancelButton,
                    saveButton,
                  ],
                )
            ],
          ),
        ),
      );
    });
  }
}
