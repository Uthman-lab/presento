part of '../attendance_management.ui.dart';

abstract class AttendanceManagementEvent extends Equatable {
  const AttendanceManagementEvent();

  @override
  List<Object?> get props => [];
}

class LoadAttendanceForDate extends AttendanceManagementEvent {
  final String institutionId;
  final String classId;
  final DateTime date;

  const LoadAttendanceForDate({
    required this.institutionId,
    required this.classId,
    required this.date,
  });

  @override
  List<Object> get props => [institutionId, classId, date];
}

class LoadAttendanceHistory extends AttendanceManagementEvent {
  final String institutionId;
  final String classId;
  final DateTime startDate;
  final DateTime endDate;

  const LoadAttendanceHistory({
    required this.institutionId,
    required this.classId,
    required this.startDate,
    required this.endDate,
  });

  @override
  List<Object> get props => [institutionId, classId, startDate, endDate];
}

class MarkStudentAttendance extends AttendanceManagementEvent {
  final String institutionId;
  final String attendanceId;
  final String studentId;
  final AttendanceStatus status;
  final String? notes;
  final String markedBy;

  const MarkStudentAttendance({
    required this.institutionId,
    required this.attendanceId,
    required this.studentId,
    required this.status,
    this.notes,
    required this.markedBy,
  });

  @override
  List<Object?> get props =>
      [institutionId, attendanceId, studentId, status, notes, markedBy];
}

class BulkMarkAttendance extends AttendanceManagementEvent {
  final String institutionId;
  final String attendanceId;
  final List<String> studentIds;
  final AttendanceStatus status;
  final String markedBy;

  const BulkMarkAttendance({
    required this.institutionId,
    required this.attendanceId,
    required this.studentIds,
    required this.status,
    required this.markedBy,
  });

  @override
  List<Object> get props =>
      [institutionId, attendanceId, studentIds, status, markedBy];
}

class SubmitAttendance extends AttendanceManagementEvent {
  final String institutionId;
  final String attendanceId;

  const SubmitAttendance({
    required this.institutionId,
    required this.attendanceId,
  });

  @override
  List<Object> get props => [institutionId, attendanceId];
}

class UpdateAttendanceRecord extends AttendanceManagementEvent {
  final String institutionId;
  final String attendanceId;
  final String studentId;
  final AttendanceStatus status;
  final String? notes;
  final String markedBy;

  const UpdateAttendanceRecord({
    required this.institutionId,
    required this.attendanceId,
    required this.studentId,
    required this.status,
    this.notes,
    required this.markedBy,
  });

  @override
  List<Object?> get props =>
      [institutionId, attendanceId, studentId, status, notes, markedBy];
}

class DeleteAttendance extends AttendanceManagementEvent {
  final String institutionId;
  final String attendanceId;

  const DeleteAttendance({
    required this.institutionId,
    required this.attendanceId,
  });

  @override
  List<Object> get props => [institutionId, attendanceId];
}

class LoadAttendanceRecords extends AttendanceManagementEvent {
  final String institutionId;
  final String attendanceId;

  const LoadAttendanceRecords({
    required this.institutionId,
    required this.attendanceId,
  });

  @override
  List<Object> get props => [institutionId, attendanceId];
}

