import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart' as str_validator;

import 'package:edspert_fl_adv/core/entities/auth/school_detail.dart';
import 'package:edspert_fl_adv/core/entities/auth/user.dart';

/// Contains common form validators used in the application.
abstract final class AppFormValidators {
  static FormFieldValidator<String> get email {
    return (value) {
      if (value == null || value.isEmpty) return 'Tidak boleh kosong';

      if (!str_validator.isEmail(value)) return 'Email tidak valid';

      return null;
    };
  }

  static FormFieldValidator<String> get fullname {
    return (value) {
      if (value == null || value.isEmpty) return 'Tidak boleh kosong';

      final trimmedVal = value.trim().replaceAll(' ', '');

      if (!str_validator.isAlpha(trimmedVal)) {
        return 'Tidak boleh mengandung simbol';
      }

      return null;
    };
  }

  static FormFieldValidator<Gender> get gender {
    return (value) {
      if (value == null) return 'Pilih jenis kelamin';

      return null;
    };
  }

  static FormFieldValidator<SchoolDetail> get schoolGrade {
    return (value) {
      if (value == null) return 'Pilih kelas';

      return null;
    };
  }

  static FormFieldValidator<String> schoolName(SchoolDetail? schoolDetail) {
    return (value) {
      if (value == null || value.isEmpty) return 'Tidak boleh kosong';

      if (schoolDetail == null) return 'Anda belum menentukan kelas';

      final trimmedVal = value.trim().replaceAll(' ', '');
      final schoolLevelStr = schoolDetail.schoolLevel.toString();

      if (!trimmedVal.startsWith(schoolLevelStr)) {
        return 'Tidak sesuai dengan kelas (tidak diawali "$schoolLevelStr")';
      }

      /// Modified alpha numberic regex (allow "-", and ".").
      final modifiedAlphaNumRegex = RegExp(r'^[a-zA-Z0-9\-.]+$');

      if (!modifiedAlphaNumRegex.hasMatch(trimmedVal)) {
        return 'Tidak boleh mengandung simbol';
      }

      return null;
    };
  }
}
