part of '../core.dart';

extension DateTimeExtensions on DateTime {
  bool get isSessionExpired {
    final now = DateTime.now();
    final difference = now.difference(this);
    return difference.inDays >= 7;
  }

  String get formattedDate {
    return DateFormat('yyyy-MM-dd').format(this);
  }

  String get formattedDateTime {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(this);
  }
}

extension StringExtensions on String {
  bool get isValidEmail {
    const emailRegex = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    return RegExp(emailRegex).hasMatch(this);
  }

  bool get isValidPassword {
    return length >= 6;
  }

  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
}

extension DynamicDateTimeExtension on dynamic {
  /// Parses a datetime value from Firestore or JSON
  /// Handles both Firestore Timestamp objects and ISO 8601 strings
  DateTime toDateTime() {
    if (this is Timestamp) {
      return (this as Timestamp).toDate();
    } else if (this is String) {
      return DateTime.parse(this as String);
    } else if (this is DateTime) {
      return this as DateTime;
    } else {
      throw FormatException('Invalid datetime format: $this');
    }
  }
}
