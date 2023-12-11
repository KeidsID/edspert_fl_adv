import 'package:flutter/material.dart';
import 'package:root_lib/common/constants.dart';

import 'package:root_lib/infrastructures/services/remote/api/errors/common_response_exception.dart';

/// {@template lib.interfaces.widgets.common.common_error_widget}
/// Simple widget to display error message for the user.
/// {@endtemplate}
class CommonErrorWidget extends SizedBox {
  /// {@macro lib.interfaces.widgets.common.common_error_widget}
  CommonErrorWidget(
    this.error, {
    super.key,
    super.width,
    super.height,
    this.action,
  }) : super(child: _build(error, action: action));

  /// {@macro lib.interfaces.widgets.common.common_error_widget}
  ///
  /// This constructor using [SizedBox.expand].
  CommonErrorWidget.expand(this.error, {super.key, this.action})
      : super(
          width: double.infinity,
          height: double.infinity,
          child: _build(error, action: action),
        );

  /// {@macro lib.interfaces.widgets.common.common_error_widget}
  ///
  /// This constructor using [SizedBox.shrink].
  CommonErrorWidget.shrink(this.error, {super.key, this.action})
      : super(
          width: 0.0,
          height: 0.0,
          child: _build(error, action: action),
        );

  /// {@macro lib.interfaces.widgets.common.common_error_widget}
  ///
  /// This constructor using [SizedBox.fromSize].
  CommonErrorWidget.fromSize(this.error, {super.key, Size? size, this.action})
      : super(
          width: size?.width,
          height: size?.height,
          child: _build(error, action: action),
        );

  /// {@macro lib.interfaces.widgets.common.common_error_widget}
  ///
  /// This constructor using [SizedBox.square].
  CommonErrorWidget.square(
    this.error, {
    super.key,
    double? dimension,
    this.action,
  }) : super(
          width: dimension,
          height: dimension,
          child: _build(error, action: action),
        );

  final Object error;

  /// Will be shown at the bottom.
  ///
  /// Typically an [ElevatedButton].
  final Widget? action;

  static Widget _build(Object error, {Widget? action}) {
    return Builder(
      builder: (context) {
        if (error is CommonResponseException) {
          return _layout(
            context,
            action: action,
            children: [Text(error.message)],
          );
        }

        kLogger.f('CommonErrorWidget', error: error);

        return _layout(
          context,
          action: action,
          children: [const Text('Terjadi kesalahan')],
        );
      },
    );
  }

  static Widget _layout(
    BuildContext context, {
    Widget? action,
    List<Widget> children = const [],
  }) {
    final isEmpty = children.isEmpty;

    final textTheme = Theme.of(context).textTheme;

    return DefaultTextStyle.merge(
      style: textTheme.titleMedium,
      textAlign: TextAlign.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...children,
          isEmpty
              ? const SizedBox.shrink()
              : const SizedBox(height: kSpacerValue / 2),
          action ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}
