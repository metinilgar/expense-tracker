import 'package:flutter/material.dart';

class AmountTextField extends StatelessWidget {
  const AmountTextField({super.key, required this.amountController});

  final TextEditingController amountController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: amountController,
      keyboardType: TextInputType.number,
      decoration:
          const InputDecoration(label: Text('Amount'), prefixText: '\$ '),
    );
  }
}
