import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../bloc/attendance_view_bloc.dart';
import '../../domain/entities/attendance.dart';

class ViewAttendanceScreen extends StatefulWidget {
  final String institutionId;
  const ViewAttendanceScreen({super.key, required this.institutionId});

  @override
  State<ViewAttendanceScreen> createState() => _ViewAttendanceScreenState();
}

class _ViewAttendanceScreenState extends State<ViewAttendanceScreen> {
  String? selectedClassId;
  DateTime startDate = DateTime.now().subtract(const Duration(days: 7));
  DateTime endDate = DateTime.now();

  // Placeholder class data - in a real app, this would come from the class repository
  final List<Map<String, String>> availableClasses = [
    {'id': 'class1', 'name': 'Mathematics 101'},
    {'id': 'class2', 'name': 'Physics 201'},
    {'id': 'class3', 'name': 'Chemistry 101'},
  ];

  @override
  void initState() {
    super.initState();
    // Set default selected class
    if (availableClasses.isNotEmpty) {
      selectedClassId = availableClasses.first['id'];
      _loadAttendance();
    }
  }

  void _loadAttendance() {
    if (selectedClassId != null) {
      context.read<AttendanceViewBloc>().add(
        AttendanceViewEvent.loadAttendance(
          widget.institutionId,
          selectedClassId!,
          startDate,
          endDate,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Attendance'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadAttendance,
          ),
        ],
      ),
      body: Column(
        children: [
          _buildFiltersSection(),
          Expanded(
            child: BlocConsumer<AttendanceViewBloc, AttendanceViewState>(
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
                  attendanceLoaded: (viewData, statistics, startDate, endDate) {
                    return Column(
                      children: [
                        _buildStatisticsCard(statistics),
                        Expanded(child: _buildAttendanceTable(viewData)),
                      ],
                    );
                  },
                  orElse: () => const Center(
                    child: Text(
                      'Select a class and date range to view attendance',
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFiltersSection() {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Filters',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildClassDropdown()),
                const SizedBox(width: 16),
                Expanded(child: _buildDateRangePicker()),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _loadAttendance,
                child: const Text('Load Attendance'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClassDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedClassId,
      decoration: const InputDecoration(
        labelText: 'Select Class',
        border: OutlineInputBorder(),
      ),
      items: availableClasses.map((classData) {
        return DropdownMenuItem<String>(
          value: classData['id'],
          child: Text(classData['name']!),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedClassId = value;
        });
      },
    );
  }

  Widget _buildDateRangePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Date Range', style: TextStyle(fontSize: 12)),
        const SizedBox(height: 4),
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: _selectStartDate,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    DateFormat('MMM dd').format(startDate),
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text('to', style: TextStyle(fontSize: 12)),
            ),
            Expanded(
              child: InkWell(
                onTap: _selectEndDate,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    DateFormat('MMM dd').format(endDate),
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatisticsCard(AttendanceViewStatistics statistics) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Attendance Summary',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    'Total Records',
                    statistics.totalAttendanceRecords.toString(),
                    Colors.blue,
                    Icons.list,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    'Present',
                    '${statistics.presentCount} (${statistics.presentPercentage.toStringAsFixed(1)}%)',
                    Colors.green,
                    Icons.check_circle,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    'Absent',
                    '${statistics.absentCount} (${statistics.absentPercentage.toStringAsFixed(1)}%)',
                    Colors.red,
                    Icons.cancel,
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
    String value,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: const TextStyle(fontSize: 10),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceTable(List<AttendanceViewItem> viewData) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('Student')),
          DataColumn(label: Text('Student ID')),
          DataColumn(label: Text('Date')),
          DataColumn(label: Text('Status')),
          DataColumn(label: Text('Marked By')),
          DataColumn(label: Text('Notes')),
        ],
        rows: viewData.expand((item) {
          if (item.attendanceRecords.isEmpty) {
            return [
              DataRow(
                cells: [
                  DataCell(Text(item.student.name)),
                  DataCell(Text(item.student.studentId)),
                  DataCell(const Text('No records')),
                  DataCell(const Text('')),
                  DataCell(const Text('')),
                  DataCell(const Text('')),
                ],
              ),
            ];
          }
          return item.attendanceRecords.map(
            (record) => DataRow(
              cells: [
                DataCell(Text(item.student.name)),
                DataCell(Text(item.student.studentId)),
                DataCell(Text(DateFormat('MMM dd, yyyy').format(record.date))),
                DataCell(_buildStatusChip(record.status)),
                DataCell(Text(record.markedBy)),
                DataCell(
                  record.notes != null ? Text(record.notes!) : const Text(''),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildStatusChip(AttendanceStatus status) {
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
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectStartDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: endDate,
    );

    if (picked != null && picked != startDate) {
      setState(() {
        startDate = picked;
      });
    }
  }

  Future<void> _selectEndDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: endDate,
      firstDate: startDate,
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null && picked != endDate) {
      setState(() {
        endDate = picked;
      });
    }
  }
}
