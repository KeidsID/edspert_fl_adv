import 'package:root_lib/core/entities/course/course.dart';
import 'package:root_lib/core/entities/course/exercise.dart';

abstract interface class CoursesService {
  Future<List<Course>> getCoursesByMajor(
    String email, {
    SchoolMajor major = SchoolMajor.ipa,
  });

  Future<List<Exercise>> getExercisesFromCourse({
    required String courseId,
    required String email,
  });
}
