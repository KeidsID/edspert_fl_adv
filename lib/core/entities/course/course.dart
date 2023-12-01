import 'package:equatable/equatable.dart';

final class Course extends Equatable {
  final String id;
  final SchoolMajor major;
  final String category;
  final String name;
  final String coverImageUrl;
  final int studiesCount;
  final int completedStudiesCount;
  final double progress;

  const Course({
    required this.id,
    required this.major,
    required this.category,
    required this.name,
    required this.coverImageUrl,
    required this.studiesCount,
    required this.completedStudiesCount,
    required this.progress,
  });

  @override
  List<Object?> get props {
    return [
      id,
      major,
      category,
      name,
      coverImageUrl,
      studiesCount,
      completedStudiesCount,
      progress,
    ];
  }
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
