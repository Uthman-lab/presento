  import '../../imports.dart';

DateTime parseDateTime(dynamic value) {
    if (value is Timestamp) {
      return value.toDate();
    } else if (value is String) {
      return DateTime.parse(value);
    }
    throw ArgumentError('Invalid datetime value: $value');
  }