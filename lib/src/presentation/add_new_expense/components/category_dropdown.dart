import 'package:flutter/material.dart';

import 'package:expense_tracker/src/constants.dart';

class CategoryDropdown extends StatelessWidget {
  const CategoryDropdown(
      {super.key, required this.selectedCategory, required this.onChanged});

  final Category selectedCategory;
  final void Function(Category? value) onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        value: selectedCategory,
        items: Category.values
            .map(
              (e) => DropdownMenuItem(
                value: e,
                child: Text(
                  e.name.toUpperCase(),
                ),
              ),
            )
            .toList(),
        onChanged: onChanged);
  }
}
