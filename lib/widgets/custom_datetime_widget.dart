import 'package:flutter/material.dart';

class CustomDateTimeWidget extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onPressed;
  const CustomDateTimeWidget(
      {super.key, required this.controller, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      controller: controller,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      onTap: onPressed,
      decoration: const InputDecoration(
        labelText: 'date of birth',
        border: OutlineInputBorder(),
      ),
    );
  }
}
