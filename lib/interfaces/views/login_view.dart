import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('displayMedium', style: textTheme.displayMedium),
              Text('headlineMedium', style: textTheme.headlineMedium),
              Text('titleMedium', style: textTheme.titleMedium),
              Text('bodyMedium', style: textTheme.bodyMedium),
              Text('labelMedium', style: textTheme.labelMedium),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
