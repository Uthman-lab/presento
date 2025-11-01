part of '../core.dart';

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
      case 'super_admin':
        return UserRole.superAdmin;
      case 'admin':
        return UserRole.admin;
      case 'teacher':
        return UserRole.teacher;
      case 'student':
        return UserRole.student;
      case 'class_rep':
        return UserRole.classRepresentative;
      case 'stakeholder':
        return UserRole.stakeholder;
      default:
        return null;
    }
  }

  // Convert to string (for Firestore)
  String toFirestoreString() {
    switch (this) {
      case UserRole.superAdmin:
        return 'super_admin';
      case UserRole.admin:
        return 'admin';
      case UserRole.teacher:
        return 'teacher';
      case UserRole.student:
        return 'student';
      case UserRole.classRepresentative:
        return 'class_rep';
      case UserRole.stakeholder:
        return 'stakeholder';
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
