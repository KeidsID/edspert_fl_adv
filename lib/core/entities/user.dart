import 'package:edspert_fl_adv/core/entities/school_detail.dart';

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
  final String schoolName;
  final SchoolDetail schoolDetail;
  final DateTime createDate;
  final Gender gender;
  final String status;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.photoUrl,
    required this.schoolName,
    required this.schoolDetail,
    required this.createDate,
    required this.gender,
    required this.status,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      photoUrl: json['photoUrl'],
      schoolName: json['schoolName'],
      schoolDetail: SchoolDetail(
        json['schoolGrade'],
        isSpecializedSchool: json['isSpecializedSchool'],
      ),
      createDate: DateTime.parse(json['createDate']),
      gender: Gender.fromString(json['gender']),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'schoolName': schoolName,
      'schoolGrade': schoolDetail.grade,
      'isSpecializedSchool': '${schoolDetail.schoolLevel}'.endsWith('K'),
      'createDate': createDate.toIso8601String(),
      'gender': '$gender',
      'status': status,
    };
  }
}
