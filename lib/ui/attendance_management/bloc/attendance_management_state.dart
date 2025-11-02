part of '../attendance_management.ui.dart';

abstract class AttendanceManagementState extends Equatable {
  const AttendanceManagementState();

  @override
  List<Object?> get props => [];
}

class AttendanceInitial extends AttendanceManagementState {
  const AttendanceInitial();
}

class AttendanceLoading extends AttendanceManagementState {
  const AttendanceLoading();
}

class AttendanceLoaded extends AttendanceManagementState {
  final AttendanceEntity attendance;
  final List<AttendanceRecordEntity> records;
  final List<StudentEntity> students;

  const AttendanceLoaded({
    required this.attendance,
    required this.records,
    required this.students,
  });

  @override
  List<Object> get props => [attendance, records, students];

  Map<String, AttendanceRecordEntity> get recordsMap {
    return {for (var r in records) r.studentId: r};
  }

  AttendanceRecordEntity? getRecordForStudent(String studentId) {
    return recordsMap[studentId];
  }
}

class AttendanceHistoryLoaded extends AttendanceManagementState {
  final List<AttendanceEntity> attendanceList;

  const AttendanceHistoryLoaded({required this.attendanceList});

  @override
  List<Object> get props => [attendanceList];
}

class AttendanceMarked extends AttendanceManagementState {
  final AttendanceEntity attendance;
  final List<AttendanceRecordEntity> records;

  const AttendanceMarked({
    required this.attendance,
    required this.records,
  });

  @override
  List<Object> get props => [attendance, records];
}

class AttendanceSubmitted extends AttendanceManagementState {
  final AttendanceEntity attendance;

  const AttendanceSubmitted({required this.attendance});

  @override
  List<Object> get props => [attendance];
}

class AttendanceDeleted extends AttendanceManagementState {
  const AttendanceDeleted();
}

class AttendanceManagementError extends AttendanceManagementState {
  final String message;

  const AttendanceManagementError({required this.message});

  @override
  List<Object> get props => [message];
}

