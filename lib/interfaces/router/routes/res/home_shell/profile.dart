part of '../../routes.dart';

/// {@template lib.interfaces.router.routes.profile_route}
/// `/profile` route.
/// {@endtemplate}
class ProfileRoute extends GoRouteData {
  /// {@macro lib.interfaces.router.routes.profile_route}
  const ProfileRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ProfileView();
  }
}

/// {@template lib.interfaces.router.routes.edit_profile_dialog_route}
/// `/profile/edit` route with queries.
///
/// Queries:
/// - `email`: [String] **required**
/// - `oldName`: [String] **required**
/// - `oldGender`: [Gender.toString] **required**
/// - `oldSchoolGrade`: [SchoolDetail.toString] **required**
/// - `oldSchoolName`: [String] **required**
/// {@endtemplate}
class EditProfileDialogRoute extends GoRouteData {
  /// {@macro lib.interfaces.router.routes.edit_profile_dialog_route}
  const EditProfileDialogRoute({
    required this.email,
    required this.oldName,
    required this.oldGender,
    required this.oldSchoolGrade,
    required this.oldSchoolName,
  });

  final String email;
  final String oldName;

  /// Please provide [Gender.toString].
  final String oldGender;

  /// Please provide [SchoolDetail.toString].
  final String oldSchoolGrade;
  final String oldSchoolName;

  static final GlobalKey<NavigatorState> $parentNavigatorKey = routerNavKey;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    final oldUser = EditableUser(
      name: oldName,
      gender: Gender.fromString(oldGender),
      schoolDetail: SchoolDetail.fromString(oldSchoolGrade),
      schoolName: oldSchoolName,
      photoUrl: 'null',
    );

    return DialogPage(
      barrierDismissible: false,
      builder: (_) => EditProfileDialogView(
        email: email,
        editableUser: oldUser,
      ),
    );
  }
}
