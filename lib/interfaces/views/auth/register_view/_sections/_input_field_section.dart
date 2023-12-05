part of '../register_view.dart';

class _InputFieldSection extends StatelessWidget {
  const _InputFieldSection({
    this.title = 'Text Field Label',
    this.inputField = const OutlinedTextFormField(),
  });

  final String title;
  final Widget inputField;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: textTheme.titleLarge),
        const SizedBox(height: 8.0),
        inputField,
      ],
    );
  }
}
