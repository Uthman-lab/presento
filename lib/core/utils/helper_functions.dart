  import '../../imports.dart';

DateTime parseDateTime(dynamic value) {
    if (value is Timestamp) {
      return value.toDate();
    } else if (value is String) {
      return DateTime.parse(value);
    } else if (value is Map) {
      // Handle serialized Firestore timestamp from Cloud Functions
      final seconds = value['_seconds'] as int?;
      final nanoseconds = value['_nanoseconds'] as int?;
      if (seconds != null) {
        // Convert seconds to milliseconds and add nanoseconds as milliseconds
        final milliseconds = (seconds * 1000) + ((nanoseconds ?? 0) ~/ 1000000);
        return DateTime.fromMillisecondsSinceEpoch(milliseconds, isUtc: true);
      }
    }
    throw ArgumentError('Invalid datetime value: $value');
  }

/// Recursively converts Map<Object?, Object?> to Map<String, dynamic>
/// Handles nested maps and lists
dynamic convertMapRecursively(dynamic value) {
  if (value is Map) {
    final result = <String, dynamic>{};
    for (final entry in value.entries) {
      final key = entry.key.toString();
      result[key] = convertMapRecursively(entry.value);
    }
    return result;
  } else if (value is List) {
    return value.map((item) => convertMapRecursively(item)).toList();
  } else {
    return value;
  }
}