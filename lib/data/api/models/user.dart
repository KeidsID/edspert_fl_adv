import 'school_detail.dart';

enum Gender {
  male,
  female;

  static Gender fromString(String value) {
    if (value == 'Laki-laki') return Gender.male;

    return Gender.female;
  }

  @override
  String toString() {
    if (this == Gender.male) return 'Laki-laki';

    return 'Perempuan';
  }
}

class User {
  final String id;
  final String name;
  final String email;
  final String photoUrl;
  final SchoolDetail schoolDetail;
  final DateTime createDate;
  final Gender gender;
  final String status;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.photoUrl,
    required this.schoolDetail,
    required this.createDate,
    required this.gender,
    required this.status,
  });
}
