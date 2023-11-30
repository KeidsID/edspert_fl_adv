import 'package:equatable/equatable.dart';

import 'school_detail.dart';
import 'user.dart';

/// Model class for editable data/props on [User] entity. Usefull for edit
/// profile api.
class EditableUser extends Equatable {
  final String name;
  final Gender gender;
  final SchoolDetail schoolDetail;
  final String schoolName;
  final String photoUrl;

  const EditableUser({
    required this.name,
    required this.gender,
    required this.schoolDetail,
    required this.schoolName,
    required this.photoUrl,
  });

  @override
  List<Object> get props {
    return [
      name,
      gender,
      schoolDetail,
      schoolName,
      photoUrl,
    ];
  }
}
