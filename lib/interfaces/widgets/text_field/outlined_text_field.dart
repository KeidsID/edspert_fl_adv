import 'package:flutter/material.dart';

import 'outlined_text_form_field.dart';

/// {@template edspert_fl_adv.interfaces.widgets.outlined_text_field}
/// [TextField] with border.
///
/// See also:
///
///  * [OutlinedTextFormField], a [TextFormField] with border.
/// {@endtemplate}
class OutlinedTextField extends StatelessWidget {
  /// {@macro edspert_fl_adv.interfaces.widgets.outlined_text_field}
  const OutlinedTextField({
    super.key,
    this.controller,
    this.enabled,
    this.decoration = const InputDecoration(),
    this.keyboardType,
    this.obscureText = false,
  });

  /// {@template edspert_fl_adv.interfaces.widgets.outlined_text_field.controller}
  /// Controls the text being edited.
  ///
  /// If null, this widget will create its own [TextEditingController].
  /// {@endtemplate}
  final TextEditingController? controller;

  /// {@template edspert_fl_adv.interfaces.widgets.outlined_text_field.enabled}
  /// If false the text field is "disabled": it ignores taps and its
  /// [decoration] is rendered in grey.
  ///
  /// If non-null this property overrides the [decoration]'s
  /// [InputDecoration.enabled] property.
  /// {@endtemplate}
  final bool? enabled;

  /// {@template edspert_fl_adv.interfaces.widgets.outlined_text_field.decoration}
  /// The decoration to show around the text field.
  ///
  /// By default, draws a line around the text field but can be
  /// configured to show an icon, label, hint text, and error text.
  ///
  /// If this set the [InputDecoration.border], it will be overrides by this
  /// widget.
  /// {@endtemplate}
  final InputDecoration decoration;

  /// {@macro flutter.widgets.editableText.keyboardType}
  final TextInputType? keyboardType;

  /// {@macro flutter.widgets.editableText.obscureText}
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enabled: enabled,
      decoration: decoration.copyWith(border: const OutlineInputBorder()),
      keyboardType: keyboardType,
      obscureText: obscureText,
    );
  }
}
