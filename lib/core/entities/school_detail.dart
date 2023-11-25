enum SchoolLevel {
  sd,
  smp,
  sma,
  smk;

  @override
  String toString() {
    switch (this) {
      case SchoolLevel.sd:
        return 'SD';
      case SchoolLevel.smp:
        return 'SMP';
      case SchoolLevel.sma:
        return 'SMA';
      case SchoolLevel.smk:
        return 'SMK';
      default:
        throw TypeError();
    }
  }
}

class SchoolDetail {
  SchoolDetail(this.grade, {bool isSpecializedSchool = false})
      : assert(grade >= 1 && grade <= 12, 'Grade must be 1 to 12 only') {
    switch (grade) {
      case 1:
      case 2:
      case 3:
      case 4:
      case 5:
      case 6:
        schoolLevel = SchoolLevel.sd;
        break;
      case 7:
      case 8:
      case 9:
        schoolLevel = SchoolLevel.smp;
        break;
      case 10:
      case 11:
      case 12:
        if (isSpecializedSchool) {
          schoolLevel = SchoolLevel.smk;
          break;
        }
        schoolLevel = SchoolLevel.smp;
        break;
      default:
        throw RangeError.range(
          grade,
          1,
          12,
          'Grade Range',
          'Grade must be 1 to 12 only',
        );
    }
  }

  final int grade;
  late final SchoolLevel schoolLevel;
}
