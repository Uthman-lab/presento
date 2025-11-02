part of '../attendance_management.ui.dart';

class AttendanceHistoryScreen extends StatefulWidget {
  final String institutionId;
  final String classId;

  const AttendanceHistoryScreen({
    super.key,
    required this.institutionId,
    required this.classId,
  });

  @override
  State<AttendanceHistoryScreen> createState() =>
      _AttendanceHistoryScreenState();
}

class _AttendanceHistoryScreenState extends State<AttendanceHistoryScreen> {
  DateTime _startDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime _endDate = DateTime.now();
  final Map<String, String> _userNames = {};
  final Set<String> _failedUserIds = {};
  bool _isLoadingNames = false;
  final GetUserByIdUseCase _getUserByIdUseCase = di.sl<GetUserByIdUseCase>();
  final GetAllUsersUseCase _getAllUsersUseCase = di.sl<GetAllUsersUseCase>();

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  void _loadHistory() {
    context.read<AttendanceManagementBloc>().add(
      LoadAttendanceHistory(
        institutionId: widget.institutionId,
        classId: widget.classId,
        startDate: _startDate,
        endDate: _endDate,
      ),
    );
  }

  Future<void> _selectDateRange() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      initialDateRange: DateTimeRange(start: _startDate, end: _endDate),
    );

    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
      });
      _loadHistory();
    }
  }

  Widget _buildMarkedByText(String userId, ThemeData theme) {
    if (_isLoadingNames) {
      return Row(
        children: [
          SizedBox(
            width: 12,
            height: 12,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                theme.colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text('Marked by: Loading...', style: theme.textTheme.bodySmall),
        ],
      );
    }

    if (_userNames.containsKey(userId)) {
      return Text(
        'Marked by: ${_userNames[userId]}',
        style: theme.textTheme.bodySmall,
      );
    }

    if (_failedUserIds.contains(userId)) {
      return Row(
        children: [
          Icon(Icons.error_outline, size: 16, color: Colors.red),
          const SizedBox(width: 4),
          Text(
            'Marked by: [Unable to load user name]',
            style: theme.textTheme.bodySmall?.copyWith(color: Colors.red),
          ),
        ],
      );
    }

    // Fallback (shouldn't happen, but just in case)
    return Row(
      children: [
        SizedBox(
          width: 12,
          height: 12,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(
              theme.colorScheme.primary,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text('Marked by: Loading...', style: theme.textTheme.bodySmall),
      ],
    );
  }

  void _deleteAttendance(String attendanceId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Attendance'),
        content: const Text(
          'Are you sure you want to delete this attendance record? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.read<AttendanceManagementBloc>().add(
                DeleteAttendance(
                  institutionId: widget.institutionId,
                  attendanceId: attendanceId,
                ),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  Future<void> _fetchUserNames(List<AttendanceEntity> attendanceList) async {
    // Extract unique user IDs
    final userIds = attendanceList
        .map((attendance) => attendance.markedBy)
        .where((userId) => userId.isNotEmpty)
        .toSet()
        .toList();

    if (userIds.isEmpty) {
      setState(() {
        _isLoadingNames = false;
      });
      return;
    }

    // Clear previous data and set loading state
    setState(() {
      _userNames.clear();
      _failedUserIds.clear();
      _isLoadingNames = true;
    });

    // Separate emails and UIDs
    final emailIds = userIds.where((id) => id.contains('@')).toList();
    final uidIds = userIds.where((id) => !id.contains('@')).toList();

    // First, try to fetch by email (document ID) for those that look like emails
    final emailFutures = emailIds.map((userId) async {
      try {
        final result = await _getUserByIdUseCase(
          GetUserByIdParams(userId: userId),
        );
        return result.fold(
          (failure) => MapEntry(userId, null),
          (user) => MapEntry(userId, user.name),
        );
      } catch (e) {
        return MapEntry(userId, null);
      }
    });

    final emailResults = await Future.wait(emailFutures);

    // For UIDs, get all users and match by uid field
    Map<String, String> uidToNameMap = {};
    if (uidIds.isNotEmpty) {
      try {
        final allUsersResult = await _getAllUsersUseCase(
          GetAllUsersParams(institutionId: widget.institutionId),
        );
        allUsersResult.fold((failure) => null, (users) {
          for (final user in users) {
            if (uidIds.contains(user.uid)) {
              uidToNameMap[user.uid] = user.name;
            }
          }
        });
      } catch (e) {
        // Failed to fetch all users
      }
    }

    // Update state with successful fetches and track failures
    setState(() {
      // Add email lookup results
      for (final result in emailResults) {
        if (result.value != null) {
          _userNames[result.key] = result.value!;
        } else {
          _failedUserIds.add(result.key);
        }
      }

      // Add UID lookup results
      for (final uid in uidIds) {
        if (uidToNameMap.containsKey(uid)) {
          _userNames[uid] = uidToNameMap[uid]!;
        } else {
          _failedUserIds.add(uid);
        }
      }

      _isLoadingNames = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.date_range),
            onPressed: _selectDateRange,
            tooltip: 'Select Date Range',
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadHistory,
            tooltip: 'Refresh',
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
          } else if (state is AttendanceDeleted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Attendance deleted successfully'),
                backgroundColor: Colors.green,
              ),
            );
            _loadHistory();
          } else if (state is AttendanceHistoryLoaded) {
            // Fetch user names when attendance history is loaded
            _fetchUserNames(state.attendanceList);
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
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(state.message),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _loadHistory,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is AttendanceHistoryLoaded) {
            if (state.attendanceList.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.event_busy, size: 64, color: Colors.grey),
                    const SizedBox(height: 16),
                    Text(
                      'No attendance records found',
                      style: theme.textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Date range: ${DateFormat('MMM d').format(_startDate)} - ${DateFormat('MMM d, yyyy').format(_endDate)}',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              );
            }

            return Column(
              children: [
                // Date range info
                Card(
                  margin: const EdgeInsets.all(16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Date Range',
                              style: theme.textTheme.titleSmall,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${DateFormat('MMM d').format(_startDate)} - ${DateFormat('MMM d, yyyy').format(_endDate)}',
                              style: theme.textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        Text(
                          '${state.attendanceList.length} records',
                          style: theme.textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                ),

                // Attendance list
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: state.attendanceList.length,
                    itemBuilder: (context, index) {
                      final attendance = state.attendanceList[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: attendance.isSubmitted
                                ? Colors.green
                                : Colors.orange,
                            child: Icon(
                              attendance.isSubmitted
                                  ? Icons.check
                                  : Icons.pending,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            DateFormat(
                              'EEEE, MMMM d, yyyy',
                            ).format(attendance.date),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Class: ${attendance.classId}'),
                              _buildMarkedByText(attendance.markedBy, theme),
                              Text(
                                attendance.isSubmitted ? 'Submitted' : 'Draft',
                                style: TextStyle(
                                  color: attendance.isSubmitted
                                      ? Colors.green
                                      : Colors.orange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          trailing: PopupMenuButton(
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 'view',
                                child: Row(
                                  children: [
                                    Icon(Icons.visibility),
                                    SizedBox(width: 8),
                                    Text('View Details'),
                                  ],
                                ),
                              ),
                              if (!attendance.isSubmitted)
                                const PopupMenuItem(
                                  value: 'delete',
                                  child: Row(
                                    children: [
                                      Icon(Icons.delete, color: Colors.red),
                                      SizedBox(width: 8),
                                      Text(
                                        'Delete',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                            onSelected: (value) {
                              if (value == 'view') {
                                // Navigate to detail screen
                                context.push(
                                  '/institutions/${widget.institutionId}/attendance/${attendance.id}',
                                );
                              } else if (value == 'delete') {
                                _deleteAttendance(attendance.id);
                              }
                            },
                          ),
                          onTap: () {
                            context.push(
                              '/institutions/${widget.institutionId}/attendance/${attendance.id}',
                            );
                          },
                        ),
                      );
                    },
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
}
