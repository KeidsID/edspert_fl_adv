import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

final class Course extends Equatable {
  final String id;
  final SchoolMajor major;

  /// The category of the course is exercise.
  final bool isExecise;
  final String name;
  final String coverImageUrl;
  final int studiesCount;
  final int completedStudiesCount;

  /// Returns the progress of this course based on [completedStudiesCount].
  ///
  /// Suitable for [LinearProgressIndicator] widget.
  double get progress {
    return (studiesCount == 0) ? 1 : completedStudiesCount / studiesCount;
  }

  bool get isDone => progress == 1;

  const Course({
    required this.id,
    required this.major,
    required this.isExecise,
    required this.name,
    required this.coverImageUrl,
    required this.studiesCount,
    required this.completedStudiesCount,
  });

  @override
  List<Object> get props => [id];
}

enum SchoolMajor {
  ipa,
  ips;

  @override
  String toString() {
    switch (this) {
      case SchoolMajor.ipa:
        return 'IPA';
      case SchoolMajor.ips:
        return 'IPS';
      default:
        throw TypeError();
    }
  }

  static SchoolMajor fromString(String value) {
    switch (value) {
      case 'IPA':
        return SchoolMajor.ipa;
      case 'IPS':
        return SchoolMajor.ips;
      default:
        throw TypeError();
    }
  }
}
