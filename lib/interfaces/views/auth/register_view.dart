import 'package:edspert_fl_adv/interfaces/router/routes.dart';
import 'package:flutter/material.dart';

import 'package:edspert_fl_adv/interfaces/widgets/text_field/outlined_text_field.dart';
import 'package:edspert_fl_adv/interfaces/widgets/text_field/password_text_field.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  bool? isMan;

  String? selectedClass;

  @override
  Widget build(BuildContext context) {
    const classes = [
      'X - IPA',
      'X - IPS',
      'XI - IPA',
      'XI - IPS',
      'XII - IPA',
      'XII - IPS',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Yuk isi data diri')),
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0).copyWith(bottom: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ..._inputFieldSection(
                      context,
                      title: 'Email',
                      inputField: const OutlinedTextField(
                        decoration: InputDecoration(
                          hintText: 'username@example.com',
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    ..._inputFieldSection(
                      context,
                      title: 'Password',
                      inputField: const PasswordTextField(),
                    ),
                    const SizedBox(height: 16.0),
                    ..._inputFieldSection(
                      context,
                      title: 'Jenis Kelamin',
                      inputField: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InputChip(
                            label: const Text('Laki-laki'),
                            selected: isMan ?? false,
                            isEnabled: !(isMan ?? false),
                            onSelected: (value) {
                              setState(() => isMan = value);
                            },
                          ),
                          InputChip(
                            label: const Text('Perempuan'),
                            selected: !(isMan ?? true),
                            isEnabled: isMan ?? true,
                            onSelected: (value) {
                              setState(() => isMan = !value);
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    ..._inputFieldSection(
                      context,
                      title: 'Kelas',
                      inputField: DropdownButtonFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        isExpanded: true,
                        hint: const Text('Pilih kelas'),
                        value: selectedClass,
                        onChanged: (value) {
                          setState(() => selectedClass = value);
                        },
                        items: classes
                            .map((e) =>
                                DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    ..._inputFieldSection(
                      context,
                      title: 'Nama Sekolah',
                      inputField: const OutlinedTextField(
                        decoration: InputDecoration(
                          hintText: 'SMA Negeri 123 Makassar',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: FilledButton(
                onPressed: () => const HomeRoute().go(context),
                child: const Text('Daftar'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _inputFieldSection(
    BuildContext context, {
    String title = 'Text Field Label',
    Widget inputField = const OutlinedTextField(),
  }) {
    final textTheme = Theme.of(context).textTheme;

    return [
      Text(title, style: textTheme.titleLarge),
      const SizedBox(height: 8.0),
      inputField,
    ];
  }
}
