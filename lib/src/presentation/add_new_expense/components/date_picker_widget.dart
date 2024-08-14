import 'package:flutter/material.dart';

import 'package:expense_tracker/src/constants.dart';

class DatePickerWidget extends StatelessWidget {
  const DatePickerWidget(
      {super.key, required this.presentDatePicker, this.selectedDate});

  final void Function() presentDatePicker;
  final DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(selectedDate == null
              ? 'No date selected'
              : formatter.format(selectedDate!)),
          IconButton(
              onPressed: presentDatePicker,
              icon: const Icon(Icons.calendar_month))
        ],
      ),
    );
  }
}
