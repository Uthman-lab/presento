part of '../attendance_management.ui.dart';

class AttendanceSessionDetailScreen extends StatelessWidget {
  final String institutionId;
  final String attendanceId;

  const AttendanceSessionDetailScreen({
    super.key,
    required this.institutionId,
    required this.attendanceId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttendanceManagementBloc, AttendanceManagementState>(
      builder: (context, state) {
        // This screen should be navigated to from history screen
        // For now, return a placeholder
        return Scaffold(
          appBar: AppBar(
            title: const Text('Attendance Details'),
          ),
          body: const Center(
            child: Text('Attendance detail view - to be implemented'),
          ),
        );
      },
    );
  }
}

