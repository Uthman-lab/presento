import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/error/failures.dart';
import '../../../modules/attendance/domain/entities/attendance.dart';
import '../../../modules/student/domain/entities/student.dart';
import '../../../modules/attendance/domain/usecases/get_attendance.dart';

part 'attendance_report_bloc.freezed.dart';
part 'attendance_report_event.dart';
part 'attendance_report_state.dart';

class AttendanceReportBloc
    extends Bloc<AttendanceReportEvent, AttendanceReportState> {
  final GetAttendance _getAttendance;

  AttendanceReportBloc({required GetAttendance getAttendance})
    : _getAttendance = getAttendance,
      super(const AttendanceReportState.initial()) {
    on<AttendanceReportLoadReport>(_onLoadReport);
    on<AttendanceReportFilterByDateRange>(_onFilterByDateRange);
    on<AttendanceReportFilterByStudent>(_onFilterByStudent);
    on<AttendanceReportClearFilters>(_onClearFilters);
  }

  Future<void> _onLoadReport(
    AttendanceReportLoadReport event,
    Emitter<AttendanceReportState> emit,
  ) async {
    emit(const AttendanceReportState.loading());

    final result = await _getAttendance(
      event.institutionId,
      event.classId,
      event.date,
    );

    result.fold((failure) => emit(AttendanceReportState.error(failure)), (
      attendanceRecords,
    ) {
      // For now, we'll use placeholder student data
      // In a real implementation, this would fetch students from the student repository
      final students = [
        Student(
          id: 'student1',
          studentId: 'STU001',
          name: 'John Doe',
          institutionId: 'institution_placeholder',
          classId: 'class_placeholder',
          email: 'john.doe@example.com',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        Student(
          id: 'student2',
          studentId: 'STU002',
          name: 'Jane Smith',
          institutionId: 'institution_placeholder',
          classId: 'class_placeholder',
          email: 'jane.smith@example.com',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        Student(
          id: 'student3',
          studentId: 'STU003',
          name: 'Mike Johnson',
          institutionId: 'institution_placeholder',
          classId: 'class_placeholder',
          email: 'mike.johnson@example.com',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      ];

      // Merge attendance records with student data
      final reportData = students.map((student) {
        final attendanceRecord = attendanceRecords.firstWhere(
          (record) => record.studentId == student.id,
          orElse: () => Attendance(
            id: '${event.date.toIso8601String()}_${student.id}',
            studentId: student.id,
            classId: event.classId,
            institutionId: event.institutionId,
            date: event.date,
            status: AttendanceStatus.absent,
            markedBy: 'unknown',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        );

        return AttendanceReportItem(
          student: student,
          attendance: attendanceRecord,
        );
      }).toList();

      // Calculate statistics
      final totalStudents = reportData.length;
      final presentCount = reportData
          .where((item) => item.attendance.status == AttendanceStatus.present)
          .length;
      final absentCount = reportData
          .where((item) => item.attendance.status == AttendanceStatus.absent)
          .length;
      final lateCount = reportData
          .where((item) => item.attendance.status == AttendanceStatus.late)
          .length;
      final excusedCount = reportData
          .where((item) => item.attendance.status == AttendanceStatus.excused)
          .length;

      final statistics = AttendanceStatistics(
        totalStudents: totalStudents,
        presentCount: presentCount,
        absentCount: absentCount,
        lateCount: lateCount,
        excusedCount: excusedCount,
        presentPercentage: totalStudents > 0
            ? (presentCount / totalStudents) * 100
            : 0,
        absentPercentage: totalStudents > 0
            ? (absentCount / totalStudents) * 100
            : 0,
        latePercentage: totalStudents > 0
            ? (lateCount / totalStudents) * 100
            : 0,
        excusedPercentage: totalStudents > 0
            ? (excusedCount / totalStudents) * 100
            : 0,
      );

      emit(
        AttendanceReportState.reportLoaded(
          reportData: reportData,
          statistics: statistics,
          date: event.date,
        ),
      );
    });
  }

  void _onFilterByDateRange(
    AttendanceReportFilterByDateRange event,
    Emitter<AttendanceReportState> emit,
  ) {
    // Implementation for date range filtering
    // This would filter the loaded report data by date range
  }

  void _onFilterByStudent(
    AttendanceReportFilterByStudent event,
    Emitter<AttendanceReportState> emit,
  ) {
    // Implementation for student filtering
    // This would filter the loaded report data by student
  }

  void _onClearFilters(
    AttendanceReportClearFilters event,
    Emitter<AttendanceReportState> emit,
  ) {
    // Implementation for clearing filters
    // This would reset all filters and show all data
  }
}

class AttendanceReportItem {
  final Student student;
  final Attendance attendance;

  AttendanceReportItem({required this.student, required this.attendance});
}

class AttendanceStatistics {
  final int totalStudents;
  final int presentCount;
  final int absentCount;
  final int lateCount;
  final int excusedCount;
  final double presentPercentage;
  final double absentPercentage;
  final double latePercentage;
  final double excusedPercentage;

  AttendanceStatistics({
    required this.totalStudents,
    required this.presentCount,
    required this.absentCount,
    required this.lateCount,
    required this.excusedCount,
    required this.presentPercentage,
    required this.absentPercentage,
    required this.latePercentage,
    required this.excusedPercentage,
  });
}
