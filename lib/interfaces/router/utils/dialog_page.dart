import 'package:flutter/material.dart';

class DialogPage extends Page<void> {
  /// A page to display a dialog.
  const DialogPage({
    super.key,
    required this.builder,
    this.anchorPoint,
    this.barrierColor = Colors.black54,
    this.barrierDismissible = true,
    this.barrierLabel,
    this.traversalEdgeBehavior,
    this.useSafeArea = true,
  });

  final WidgetBuilder builder;

  /// {@macro flutter.widgets.DisplayFeatureSubScreen.anchorPoint}
  final Offset? anchorPoint;

  /// {@macro flutter.widgets.ModalRoute.barrierColor}
  final Color? barrierColor;

  /// {@macro flutter.widgets.ModalRoute.barrierDismissible}
  final bool barrierDismissible;

  /// {@macro flutter.widgets.ModalRoute.barrierLabel}
  final String? barrierLabel;

  /// Wrap the dialog within a [SafeArea] if true.
  final bool useSafeArea;

  /// Controls the transfer of focus beyond the first and the last items of a
  /// [FocusScopeNode].
  ///
  /// If set to null, [Navigator.routeTraversalEdgeBehavior] is used.
  final TraversalEdgeBehavior? traversalEdgeBehavior;

  @override
  Route<void> createRoute(BuildContext context) {
    return DialogRoute<void>(
      context: context,
      builder: builder,
      settings: this,
      anchorPoint: anchorPoint,
      barrierColor: barrierColor,
      barrierDismissible: barrierDismissible,
      barrierLabel: barrierLabel,
      traversalEdgeBehavior: traversalEdgeBehavior,
      useSafeArea: useSafeArea,
    );
  }
}
