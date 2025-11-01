part of '../core.dart';

const String superAdminRole = 'super_admin';
const String adminRole = 'admin';
const String teacherRole = 'teacher';
const String studentRole = 'student';
const String classRepresentativeRole = 'class_rep';
const String stakeholderRole = 'stakeholder';

enum UserRole {
  superAdmin,
  admin,
  teacher,
  student,
  classRepresentative,
  stakeholder;

  // Convert from string (from Firestore)
  static UserRole? fromString(String? roleString) {
    switch (roleString) {
      case superAdminRole:
        return UserRole.superAdmin;
      case adminRole:
        return UserRole.admin;
      case teacherRole:
        return UserRole.teacher;
      case studentRole:
        return UserRole.student;
      case classRepresentativeRole:
        return UserRole.classRepresentative;
      case stakeholderRole:
        return UserRole.stakeholder;
      default:
        return null;
    }
  }

  // Convert to string (for Firestore)
  String toFirestoreString() {
    switch (this) {
      case UserRole.superAdmin:
        return superAdminRole;
      case UserRole.admin:
        return adminRole;
      case UserRole.teacher:
        return teacherRole;
      case UserRole.student:
        return studentRole;
      case UserRole.classRepresentative:
        return classRepresentativeRole;
      case UserRole.stakeholder:
        return stakeholderRole;
    }
  }
}

// Extension for display properties
extension UserRoleDisplay on UserRole {
  String get displayName {
    switch (this) {
      case UserRole.superAdmin:
        return 'Super Administrator';
      case UserRole.admin:
        return 'Institution Administrator';
      case UserRole.teacher:
        return 'Teacher';
      case UserRole.student:
        return 'Student';
      case UserRole.classRepresentative:
        return 'Class Representative';
      case UserRole.stakeholder:
        return 'Stakeholder';
    }
  }

  IconData get icon {
    switch (this) {
      case UserRole.superAdmin:
        return Icons.admin_panel_settings;
      case UserRole.admin:
        return Icons.school;
      case UserRole.teacher:
        return Icons.person;
      case UserRole.student:
        return Icons.school;
      case UserRole.classRepresentative:
        return Icons.groups;
      case UserRole.stakeholder:
        return Icons.family_restroom;
    }
  }

  Color get color {
    switch (this) {
      case UserRole.superAdmin:
        return Colors.red;
      case UserRole.admin:
        return Colors.blue;
      case UserRole.teacher:
        return Colors.green;
      case UserRole.student:
        return Colors.orange;
      case UserRole.classRepresentative:
        return Colors.purple;
      case UserRole.stakeholder:
        return Colors.teal;
    }
  }
}
