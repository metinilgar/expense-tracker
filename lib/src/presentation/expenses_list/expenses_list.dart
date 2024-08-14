import 'package:flutter/material.dart';

import 'package:expense_tracker/src/presentation/expenses_list/expense_item.dart';
import 'package:expense_tracker/src/models/expense.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expensesList,
    required this.onRemoveExpense,
  });

  final List<Expense> expensesList;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expensesList.length,
      itemBuilder: (context, index) => Dismissible(
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(.80),
          margin: EdgeInsets.symmetric(
              horizontal: Theme.of(context).cardTheme.margin!.horizontal),
        ),
        key: ValueKey(expensesList[index]),
        onDismissed: (direction) => onRemoveExpense(expensesList[index]),
        child: ExpenseItem(expensesList[index]),
      ),
    );
  }
}
