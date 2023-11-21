import 'package:flutter/material.dart';

class OutlinedTextField extends StatelessWidget {
  const OutlinedTextField({
    super.key,
    this.controller,
    this.decoration = const InputDecoration(),
    this.keyboardType,
    this.obscureText = false,
  });

  final TextEditingController? controller;
  final InputDecoration decoration;
  final TextInputType? keyboardType;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: decoration.copyWith(border: const OutlineInputBorder()),
      keyboardType: keyboardType,
      obscureText: obscureText,
    );
  }
}
