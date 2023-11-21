import 'package:flutter/material.dart';

import 'outlined_text_field.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    super.key,
    this.controller,
    this.decoration = const InputDecoration(),
  });

  final TextEditingController? controller;
  final InputDecoration decoration;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return OutlinedTextField(
      controller: widget.controller,
      decoration: widget.decoration.copyWith(
        suffixIcon: IconButton(
          onPressed: () => setState(() => isVisible = !isVisible),
          icon: isVisible
              ? const Icon(Icons.visibility)
              : const Icon(Icons.visibility_off),
        ),
      ),
      obscureText: !isVisible,
    );
  }
}
