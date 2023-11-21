import 'package:flutter/material.dart';

import 'package:edspert_fl_adv/interfaces/widgets/text_field/outlined_text_field.dart';
import 'package:edspert_fl_adv/interfaces/widgets/text_field/password_text_field.dart';

class LoginDialog extends StatelessWidget {
  const LoginDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Login'),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OutlinedTextField(
            decoration: InputDecoration(labelText: 'Email'),
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 16.0),
          PasswordTextField(
            decoration: InputDecoration(labelText: 'Password'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Masuk'),
        ),
      ],
    );
  }
}
