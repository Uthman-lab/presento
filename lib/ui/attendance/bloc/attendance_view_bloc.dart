import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/error/failures.dart';
import '../../../modules/attendance/domain/entities/attendance.dart';
import '../../../modules/student/domain/entities/student.dart';
import '../../../modules/attendance/domain/usecases/get_attendance_by_date_range.dart';

part 'attendance_view_bloc.freezed.dart';
part 'attendance_view_event.dart';
part 'attendance_view_state.dart';

class AttendanceViewBloc
    extends Bloc<AttendanceViewEvent, AttendanceViewState> {
  final GetAttendanceByDateRange _getAttendanceByDateRange;

  AttendanceViewBloc({
    required GetAttendanceByDateRange getAttendanceByDateRange,
  }) : _getAttendanceByDateRange = getAttendanceByDateRange,
       super(const AttendanceViewState.initial()) {
    on<AttendanceViewLoadAttendance>(_onLoadAttendance);
    on<AttendanceViewFilterByDateRange>(_onFilterByDateRange);
    on<AttendanceViewFilterByStudent>(_onFilterByStudent);
    on<AttendanceViewClearFilters>(_onClearFilters);
  }

  Future<void> _onLoadAttendance(
    AttendanceViewLoadAttendance event,
    Emitter<AttendanceViewState> emit,
  ) async {
    emit(const AttendanceViewState.loading());

    final result = await _getAttendanceByDateRange(
      GetAttendanceByDateRangeParams(
        institutionId: event.institutionId,
        classId: event.classId,
        startDate: event.startDate,
        endDate: event.endDate,
      ),
    );

    result.fold((failure) => emit(AttendanceViewState.error(failure)), (
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
      final viewData = students.map((student) {
        final studentAttendance = attendanceRecords
            .where((record) => record.studentId == student.id)
            .toList();

        return AttendanceViewItem(
          student: student,
          attendanceRecords: studentAttendance,
        );
      }).toList();

      // Calculate statistics
      final totalStudents = viewData.length;
      final totalAttendanceRecords = attendanceRecords.length;
      final presentCount = attendanceRecords
          .where((record) => record.status == AttendanceStatus.present)
          .length;
      final absentCount = attendanceRecords
          .where((record) => record.status == AttendanceStatus.absent)
          .length;
      final lateCount = attendanceRecords
          .where((record) => record.status == AttendanceStatus.late)
          .length;
      final excusedCount = attendanceRecords
          .where((record) => record.status == AttendanceStatus.excused)
          .length;

      final statistics = AttendanceViewStatistics(
        totalStudents: totalStudents,
        totalAttendanceRecords: totalAttendanceRecords,
        presentCount: presentCount,
        absentCount: absentCount,
        lateCount: lateCount,
        excusedCount: excusedCount,
        presentPercentage: totalAttendanceRecords > 0
            ? (presentCount / totalAttendanceRecords) * 100
            : 0,
        absentPercentage: totalAttendanceRecords > 0
            ? (absentCount / totalAttendanceRecords) * 100
            : 0,
        latePercentage: totalAttendanceRecords > 0
            ? (lateCount / totalAttendanceRecords) * 100
            : 0,
        excusedPercentage: totalAttendanceRecords > 0
            ? (excusedCount / totalAttendanceRecords) * 100
            : 0,
      );

      emit(
        AttendanceViewState.attendanceLoaded(
          viewData: viewData,
          statistics: statistics,
          startDate: event.startDate,
          endDate: event.endDate,
        ),
      );
    });
  }

  void _onFilterByDateRange(
    AttendanceViewFilterByDateRange event,
    Emitter<AttendanceViewState> emit,
  ) {
    // Implementation for date range filtering
    // This would filter the loaded attendance data by date range
  }

  void _onFilterByStudent(
    AttendanceViewFilterByStudent event,
    Emitter<AttendanceViewState> emit,
  ) {
    // Implementation for student filtering
    // This would filter the loaded attendance data by student
  }

  void _onClearFilters(
    AttendanceViewClearFilters event,
    Emitter<AttendanceViewState> emit,
  ) {
    // Implementation for clearing filters
    // This would reset all filters and show all data
  }
}

class AttendanceViewItem {
  final Student student;
  final List<Attendance> attendanceRecords;

  AttendanceViewItem({required this.student, required this.attendanceRecords});
}

class AttendanceViewStatistics {
  final int totalStudents;
  final int totalAttendanceRecords;
  final int presentCount;
  final int absentCount;
  final int lateCount;
  final int excusedCount;
  final double presentPercentage;
  final double absentPercentage;
  final double latePercentage;
  final double excusedPercentage;

  AttendanceViewStatistics({
    required this.totalStudents,
    required this.totalAttendanceRecords,
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
