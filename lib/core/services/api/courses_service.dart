import 'package:edspert_fl_adv/core/entities/course/course.dart';

abstract interface class CoursesService {
  Future<List<Course>> getCoursesByMajor(
    String email, {
    SchoolMajor major = SchoolMajor.ipa,
  });
}
