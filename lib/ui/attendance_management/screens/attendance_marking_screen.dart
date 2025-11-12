part of '../attendance_management.ui.dart';

class AttendanceMarkingScreen extends StatefulWidget {
  final String institutionId;
  final String classId;
  final DateTime selectedDate;

  const AttendanceMarkingScreen({
    super.key,
    required this.institutionId,
    required this.classId,
    required this.selectedDate,
  });

  @override
  State<AttendanceMarkingScreen> createState() =>
      _AttendanceMarkingScreenState();
}

class _AttendanceMarkingScreenState extends State<AttendanceMarkingScreen> {
  DateTime _selectedDate = DateTime.now();
  final Map<String, AttendanceStatus> _studentStatusMap = {};
  final Map<String, String> _studentNotesMap = {};

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate;
    _loadAttendance();
  }

  void _loadAttendance() {
    context.read<AttendanceManagementBloc>().add(
          LoadAttendanceForDate(
            institutionId: widget.institutionId,
            classId: widget.classId,
            date: _selectedDate,
          ),
        );
  }

  String? _getCurrentUserId() {
    final authState = context.read<AuthBloc>().state;
    if (authState is Authenticated) {
      return authState.user.uid;
    }
    return null;
  }

  void _markStudent(String studentId, AttendanceStatus status) {
    final userId = _getCurrentUserId();
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not authenticated')),
      );
      return;
    }

    final currentState = context.read<AttendanceManagementBloc>().state;
    if (currentState is AttendanceLoaded) {
      final attendanceId = currentState.attendance.id;
      setState(() {
        _studentStatusMap[studentId] = status;
      });

      context.read<AttendanceManagementBloc>().add(
            MarkStudentAttendance(
              institutionId: widget.institutionId,
              attendanceId: attendanceId,
              studentId: studentId,
              status: status,
              notes: _studentNotesMap[studentId],
              markedBy: userId,
            ),
          );
    }
  }

  void _bulkMarkAll(AttendanceStatus status) {
    final userId = _getCurrentUserId();
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not authenticated')),
      );
      return;
    }

    final currentState = context.read<AttendanceManagementBloc>().state;
    if (currentState is AttendanceLoaded) {
      final attendanceId = currentState.attendance.id;
      final studentIds = currentState.students.map((s) => s.id).toList();

      context.read<AttendanceManagementBloc>().add(
            BulkMarkAttendance(
              institutionId: widget.institutionId,
              attendanceId: attendanceId,
              studentIds: studentIds,
              status: status,
              markedBy: userId,
            ),
          );
    }
  }

  void _submitAttendance() {
    final currentState = context.read<AttendanceManagementBloc>().state;
    if (currentState is AttendanceLoaded) {
      context.read<AttendanceManagementBloc>().add(
            SubmitAttendance(
              institutionId: widget.institutionId,
              attendanceId: currentState.attendance.id,
            ),
          );
    }
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _studentStatusMap.clear();
        _studentNotesMap.clear();
      });
      _loadAttendance();
    }
  }

  Color _getStatusColor(AttendanceStatus status) {
    switch (status) {
      case AttendanceStatus.present:
        return Colors.green;
      case AttendanceStatus.absent:
        return Colors.red;
      case AttendanceStatus.late:
        return Colors.orange;
      case AttendanceStatus.excused:
        return Colors.blue;
    }
  }

  String _getStatusLabel(AttendanceStatus status) {
    switch (status) {
      case AttendanceStatus.present:
        return 'Present';
      case AttendanceStatus.absent:
        return 'Absent';
      case AttendanceStatus.late:
        return 'Late';
      case AttendanceStatus.excused:
        return 'Excused';
    }
  }

  Widget _buildStatusButton({
    required AttendanceStatus status,
    required AttendanceStatus? currentStatus,
    required VoidCallback onPressed,
    required IconData icon,
    required Color color,
    required String tooltip,
  }) {
    final isActive = currentStatus == status;
    
    return IconButton(
      icon: Icon(
        icon,
        color: isActive ? color : color.withValues(alpha: 0.4),
      ),
      onPressed: onPressed,
      tooltip: tooltip,
      style: IconButton.styleFrom(
        backgroundColor:
            isActive ? color.withValues(alpha: 0.2) : Colors.transparent,
        side: isActive ? BorderSide(color: color, width: 2) : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mark Attendance'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: _selectDate,
            tooltip: 'Select Date',
          ),
        ],
      ),
      body: BlocConsumer<AttendanceManagementBloc, AttendanceManagementState>(
        listener: (context, state) {
          if (state is AttendanceManagementError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is AttendanceSubmitted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Attendance submitted successfully'),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AttendanceLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is AttendanceManagementError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(state.message),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _loadAttendance,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is AttendanceLoaded) {
            final isSubmitted = state.attendance.isSubmitted;
            final recordsMap = state.recordsMap;

            // Update local status map from records
            for (final record in state.records) {
              _studentStatusMap[record.studentId] = record.status;
              if (record.notes != null) {
                _studentNotesMap[record.studentId] = record.notes!;
              }
            }

            return Column(
              children: [
                // Date and summary card
                Card(
                  margin: const EdgeInsets.all(16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              DateFormat('EEEE, MMMM d, yyyy')
                                  .format(_selectedDate),
                              style: theme.textTheme.titleLarge,
                            ),
                            if (isSubmitted)
                              Chip(
                                label: const Text('Submitted'),
                                backgroundColor: Colors.green.shade100,
                                avatar: const Icon(Icons.check, size: 18),
                              ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Class: ${widget.classId}',
                          style: theme.textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 8),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildStatChip('Present',
                                  recordsMap.values.where((r) => r.status == AttendanceStatus.present).length,
                                  Colors.green),
                              const SizedBox(width: 8),
                              _buildStatChip('Absent',
                                  recordsMap.values.where((r) => r.status == AttendanceStatus.absent).length,
                                  Colors.red),
                              const SizedBox(width: 8),
                              _buildStatChip('Late',
                                  recordsMap.values.where((r) => r.status == AttendanceStatus.late).length,
                                  Colors.orange),
                              const SizedBox(width: 8),
                              _buildStatChip('Excused',
                                  recordsMap.values.where((r) => r.status == AttendanceStatus.excused).length,
                                  Colors.blue),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Bulk actions (if not submitted)
                if (!isSubmitted)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Wrap(
                      spacing: 8,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () => _bulkMarkAll(AttendanceStatus.present),
                          icon: const Icon(Icons.check_circle, size: 18),
                          label: const Text('Mark All Present'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () => _bulkMarkAll(AttendanceStatus.absent),
                          icon: const Icon(Icons.cancel, size: 18),
                          label: const Text('Mark All Absent'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),

                const SizedBox(height: 16),

                // Students list
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.students.length,
                    itemBuilder: (context, index) {
                      final student = state.students[index];
                      final record = recordsMap[student.id];
                      final status = record?.status ?? _studentStatusMap[student.id];

                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text(student.name[0].toUpperCase()),
                          ),
                          title: Text(student.name),
                          subtitle: Text(student.studentId),
                          trailing: !isSubmitted
                              ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    _buildStatusButton(
                                      status: AttendanceStatus.present,
                                      currentStatus: status,
                                      onPressed: () => _markStudent(
                                          student.id, AttendanceStatus.present),
                                      icon: Icons.check_circle,
                                      color: Colors.green,
                                      tooltip: 'Present',
                                    ),
                                    _buildStatusButton(
                                      status: AttendanceStatus.absent,
                                      currentStatus: status,
                                      onPressed: () => _markStudent(
                                          student.id, AttendanceStatus.absent),
                                      icon: Icons.cancel,
                                      color: Colors.red,
                                      tooltip: 'Absent',
                                    ),
                                    _buildStatusButton(
                                      status: AttendanceStatus.late,
                                      currentStatus: status,
                                      onPressed: () => _markStudent(
                                          student.id, AttendanceStatus.late),
                                      icon: Icons.access_time,
                                      color: Colors.orange,
                                      tooltip: 'Late',
                                    ),
                                    _buildStatusButton(
                                      status: AttendanceStatus.excused,
                                      currentStatus: status,
                                      onPressed: () => _markStudent(
                                          student.id, AttendanceStatus.excused),
                                      icon: Icons.info,
                                      color: Colors.blue,
                                      tooltip: 'Excused',
                                    ),
                                  ],
                                )
                              : status != null
                                  ? Chip(
                                      label: Text(_getStatusLabel(status)),
                                      backgroundColor:
                                          _getStatusColor(status)
                                              .withValues(alpha: 0.2),
                                      avatar: Icon(
                                        Icons.circle,
                                        size: 12,
                                        color: _getStatusColor(status),
                                      ),
                                    )
                                  : null,
                        ),
                      );
                    },
                  ),
                ),

                // Submit button
                if (!isSubmitted)
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _submitAttendance,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: theme.primaryColor,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text(
                          'Submit Attendance',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
              ],
            );
          }

          return const Center(child: Text('No data available'));
        },
      ),
    );
  }

  Widget _buildStatChip(String label, int count, Color color) {
    return Chip(
      label: Text('$label: $count'),
      backgroundColor: color.withValues(alpha: 0.2),
      avatar: CircleAvatar(
        backgroundColor: color,
        radius: 10,
        child: Text(
          '$count',
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
    );
  }
}

