import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show LinearProgressIndicator;

final class Exercise extends Equatable {
  final String id;
  final String title;
  final bool isFree;
  final String iconUrl;
  final int count;
  final int completedCount;

  /// Returns the progress of this course based on [completedCount].
  ///
  /// Suitable for [LinearProgressIndicator] widget.
  double get progress {
    return (count == 0) ? 1 : completedCount / count;
  }

  bool get isDone => progress == 1;

  const Exercise({
    required this.id,
    required this.title,
    required this.isFree,
    required this.iconUrl,
    required this.count,
    required this.completedCount,
  });

  @override
  List<Object> get props => [id];
}
