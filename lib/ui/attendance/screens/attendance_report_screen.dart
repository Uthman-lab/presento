import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../bloc/attendance_report_bloc.dart';
import '../../../modules/attendance/domain/entities/attendance.dart';

class AttendanceReportScreen extends StatefulWidget {
  final String institutionId;
  final String classId;
  const AttendanceReportScreen({
    super.key,
    required this.institutionId,
    required this.classId,
  });

  @override
  State<AttendanceReportScreen> createState() => _AttendanceReportScreenState();
}

class _AttendanceReportScreenState extends State<AttendanceReportScreen> {
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _loadReport();
  }

  void _loadReport() {
    context.read<AttendanceReportBloc>().add(
      AttendanceReportEvent.loadReport(
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
        title: const Text('Attendance Report'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: _selectDate,
          ),
          IconButton(icon: const Icon(Icons.refresh), onPressed: _loadReport),
        ],
      ),
      body: Column(
        children: [
          _buildDateSelector(),
          Expanded(
            child: BlocConsumer<AttendanceReportBloc, AttendanceReportState>(
              listener: (context, state) {
                state.maybeWhen(
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
                  reportLoaded: (reportData, statistics, date) {
                    return Column(
                      children: [
                        _buildStatisticsCard(statistics),
                        Expanded(child: _buildReportList(reportData)),
                      ],
                    );
                  },
                  orElse: () => const Center(
                    child: Text('Select a date to load the report'),
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
      child: Row(
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
    );
  }

  Widget _buildStatisticsCard(AttendanceStatistics statistics) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Attendance Summary',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    'Present',
                    statistics.presentCount,
                    statistics.presentPercentage,
                    Colors.green,
                    Icons.check_circle,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    'Absent',
                    statistics.absentCount,
                    statistics.absentPercentage,
                    Colors.red,
                    Icons.cancel,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    'Late',
                    statistics.lateCount,
                    statistics.latePercentage,
                    Colors.orange,
                    Icons.schedule,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    'Excused',
                    statistics.excusedCount,
                    statistics.excusedPercentage,
                    Colors.blue,
                    Icons.info,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(
    String label,
    int count,
    double percentage,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 4),
          Text(
            '$count',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(label, style: const TextStyle(fontSize: 12)),
          Text(
            '${percentage.toStringAsFixed(1)}%',
            style: TextStyle(fontSize: 10, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildReportList(List<AttendanceReportItem> reportData) {
    return ListView.builder(
      itemCount: reportData.length,
      itemBuilder: (context, index) {
        final item = reportData[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          child: ListTile(
            leading: CircleAvatar(
              child: Text(item.student.name[0].toUpperCase()),
            ),
            title: Text(item.student.name),
            subtitle: Text('ID: ${item.student.studentId}'),
            trailing: _buildAttendanceStatusChip(item.attendance.status),
          ),
        );
      },
    );
  }

  Widget _buildAttendanceStatusChip(AttendanceStatus status) {
    Color color;
    String label;
    IconData icon;

    switch (status) {
      case AttendanceStatus.present:
        color = Colors.green;
        label = 'Present';
        icon = Icons.check_circle;
        break;
      case AttendanceStatus.absent:
        color = Colors.red;
        label = 'Absent';
        icon = Icons.cancel;
        break;
      case AttendanceStatus.late:
        color = Colors.orange;
        label = 'Late';
        icon = Icons.schedule;
        break;
      case AttendanceStatus.excused:
        color = Colors.blue;
        label = 'Excused';
        icon = Icons.info;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
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
      _loadReport();
    }
  }
}
