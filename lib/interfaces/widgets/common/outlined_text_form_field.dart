import 'package:flutter/material.dart';

import 'outlined_text_field.dart';

/// {@template edspert_fl_adv.interfaces.widgets.outlined_text_form_field}
/// [TextFormField] with border.
///
/// See also:
///
///  * [OutlinedTextField], a [TextField] with border.
/// {@endtemplate}
class OutlinedTextFormField extends StatelessWidget {
  /// {@macro edspert_fl_adv.interfaces.widgets.outlined_text_form_field}
  const OutlinedTextFormField({
    super.key,
    this.controller,
    this.enabled,
    this.decoration = const InputDecoration(),
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.onEditingComplete,
    this.autovalidateMode,
    this.validator,
  });

  /// {@macro edspert_fl_adv.interfaces.widgets.outlined_text_field.controller}
  final TextEditingController? controller;

  /// {@macro edspert_fl_adv.interfaces.widgets.outlined_text_field.enabled}
  final bool? enabled;

  /// {@macro edspert_fl_adv.interfaces.widgets.outlined_text_field.decoration}
  final InputDecoration decoration;

  /// {@macro flutter.widgets.editableText.keyboardType}
  final TextInputType? keyboardType;

  /// The type of action button to use for the keyboard.
  ///
  /// Defaults to [TextInputAction.newline] if [keyboardType] is
  /// [TextInputType.multiline] and [TextInputAction.done] otherwise.
  final TextInputAction? textInputAction;

  /// {@macro flutter.widgets.editableText.obscureText}
  final bool obscureText;

  /// {@macro flutter.widgets.editableText.onEditingComplete}
  final VoidCallback? onEditingComplete;

  final AutovalidateMode? autovalidateMode;

  /// {@template edspert_fl_adv.interfaces.widgets.outlined_text_form_field.validator}
  /// Returns an error string to display if the input is invalid, or null otherwise.
  ///
  /// If this is null, then no validator will be called on [Form].
  /// {@endtemplate}
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      decoration: decoration.copyWith(border: const OutlineInputBorder()),
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      onEditingComplete: onEditingComplete,
      autovalidateMode: autovalidateMode,
      validator: validator,
    );
  }
}
