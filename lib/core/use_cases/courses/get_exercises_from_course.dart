part of '../../use_cases.dart';

class GetExercisesFromCourse {
  final CoursesService _coursesService;

  const GetExercisesFromCourse({required CoursesService coursesService})
      : _coursesService = coursesService;

  Future<List<Exercise>> execute({
    required String courseId,
    required String email,
  }) =>
      _coursesService.getExercisesFromCourse(courseId: courseId, email: email);
}
