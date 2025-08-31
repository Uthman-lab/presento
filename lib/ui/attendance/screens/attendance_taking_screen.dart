import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../bloc/attendance_bloc.dart';
import '../../../modules/attendance/domain/entities/attendance.dart';
import '../../../modules/student/domain/entities/student.dart';

class AttendanceTakingScreen extends StatefulWidget {
  final String institutionId;
  final String classId;
  const AttendanceTakingScreen({
    super.key,
    required this.institutionId,
    required this.classId,
  });

  @override
  State<AttendanceTakingScreen> createState() => _AttendanceTakingScreenState();
}

class _AttendanceTakingScreenState extends State<AttendanceTakingScreen> {
  DateTime selectedDate = DateTime.now();
  final TextEditingController _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadRoster();
  }

  void _loadRoster() {
    context.read<AttendanceBloc>().add(
      AttendanceEvent.loadRoster(
        widget.institutionId,
        widget.classId,
        selectedDate,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Take Attendance'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: _selectDate,
          ),
          BlocBuilder<AttendanceBloc, AttendanceState>(
            builder: (context, state) {
              return state.maybeWhen(
                rosterLoaded: (students, attendanceRecords, date, isSubmitted) {
                  return IconButton(
                    icon: Icon(
                      isSubmitted ? Icons.check_circle : Icons.check,
                      color: isSubmitted ? Colors.green : null,
                    ),
                    onPressed: isSubmitted ? null : _submitAttendance,
                    tooltip: isSubmitted
                        ? 'Already Submitted'
                        : 'Submit Attendance',
                  );
                },
                orElse: () =>
                    IconButton(icon: const Icon(Icons.check), onPressed: null),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildDateSelector(),
          _buildNotesField(),
          Expanded(
            child: BlocConsumer<AttendanceBloc, AttendanceState>(
              listener: (context, state) {
                state.maybeWhen(
                  submitted: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Attendance submitted successfully!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  error: (failure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error: ${failure.message}'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  },
                  orElse: () {},
                );
              },
              builder: (context, state) {
                return state.maybeWhen(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  rosterLoaded:
                      (students, attendanceRecords, date, isSubmitted) {
                        return _buildStudentList(
                          students,
                          attendanceRecords,
                          isSubmitted,
                        );
                      },
                  orElse: () => const Center(
                    child: Text('Select a date to load the roster'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSelector() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'Date: ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                DateFormat('MMM dd, yyyy').format(selectedDate),
                style: const TextStyle(fontSize: 16),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: _selectDate,
                child: const Text('Change Date'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          BlocBuilder<AttendanceBloc, AttendanceState>(
            builder: (context, state) {
              return state.maybeWhen(
                rosterLoaded: (students, attendanceRecords, date, isSubmitted) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: isSubmitted
                          ? Colors.green[100]
                          : Colors.orange[100],
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSubmitted ? Colors.green : Colors.orange,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isSubmitted ? Icons.check_circle : Icons.schedule,
                          size: 16,
                          color: isSubmitted ? Colors.green : Colors.orange,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          isSubmitted
                              ? 'Attendance Submitted'
                              : 'Attendance Pending',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: isSubmitted ? Colors.green : Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                orElse: () => const SizedBox.shrink(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNotesField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        controller: _notesController,
        decoration: const InputDecoration(
          labelText: 'General Notes (Optional)',
          border: OutlineInputBorder(),
        ),
        maxLines: 2,
      ),
    );
  }

  Widget _buildStudentList(
    List<Student> students,
    List<Attendance> attendanceRecords,
    bool isSubmitted,
  ) {
    return ListView.builder(
      itemCount: students.length,
      itemBuilder: (context, index) {
        final student = students[index];
        final attendanceRecord = attendanceRecords.firstWhere(
          (record) => record.studentId == student.id,
          orElse: () => Attendance(
            id: '${selectedDate.toIso8601String()}_${student.id}',
            studentId: student.id,
            classId: widget.classId,
            institutionId: widget.institutionId,
            date: selectedDate,
            status: AttendanceStatus.present,
            markedBy: 'current_user_id',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        );

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          child: ListTile(
            leading: CircleAvatar(child: Text(student.name[0].toUpperCase())),
            title: Text(student.name),
            subtitle: Text('ID: ${student.studentId}'),
            trailing: _buildAttendanceButtons(attendanceRecord, isSubmitted),
          ),
        );
      },
    );
  }

  Widget _buildAttendanceButtons(
    Attendance attendanceRecord,
    bool isSubmitted,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildAttendanceButton(
          attendanceRecord,
          AttendanceStatus.present,
          'Present',
          Colors.green,
          Icons.check_circle,
          isSubmitted,
        ),
        const SizedBox(width: 4),
        _buildAttendanceButton(
          attendanceRecord,
          AttendanceStatus.absent,
          'Absent',
          Colors.red,
          Icons.cancel,
          isSubmitted,
        ),
        const SizedBox(width: 4),
        _buildAttendanceButton(
          attendanceRecord,
          AttendanceStatus.late,
          'Late',
          Colors.orange,
          Icons.schedule,
          isSubmitted,
        ),
      ],
    );
  }

  Widget _buildAttendanceButton(
    Attendance attendanceRecord,
    AttendanceStatus status,
    String label,
    Color color,
    IconData icon,
    bool isSubmitted,
  ) {
    final isSelected = attendanceRecord.status == status;

    return GestureDetector(
      onTap: () {
        if (!isSubmitted) {
          context.read<AttendanceBloc>().add(
            AttendanceEvent.markStudentAttendance(
              attendanceRecord.studentId,
              status,
              _notesController.text.isNotEmpty ? _notesController.text : null,
            ),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.grey[200],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? color : Colors.grey[400]!,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? Colors.white : Colors.grey[600],
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? Colors.white : Colors.grey[600],
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      _loadRoster();
    }
  }

  void _submitAttendance() {
    context.read<AttendanceBloc>().state.maybeWhen(
      rosterLoaded: (students, attendanceRecords, date, isSubmitted) {
        if (!isSubmitted) {
          context.read<AttendanceBloc>().add(
            AttendanceEvent.submitAttendance(
              widget.institutionId,
              widget.classId,
              date,
              attendanceRecords,
            ),
          );
        }
      },
      orElse: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please load a roster first'),
            backgroundColor: Colors.orange,
          ),
        );
      },
    );
  }
}
