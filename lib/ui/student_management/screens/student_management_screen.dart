part of '../student_management.ui.dart';

class StudentManagementScreen extends StatefulWidget {
  final String institutionId;

  const StudentManagementScreen({
    super.key,
    required this.institutionId,
  });

  @override
  State<StudentManagementScreen> createState() =>
      _StudentManagementScreenState();
}

class _StudentManagementScreenState extends State<StudentManagementScreen> {
  final TextEditingController _searchController = TextEditingController();
  String? _selectedClassFilter;
  List<ClassEntity> _classes = [];
  bool _isLoadingClasses = true;

  @override
  void initState() {
    super.initState();
    _loadClasses();
    // Defer bloc access until after the first frame is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<StudentManagementBloc>().add(
              LoadStudents(
                institutionId: widget.institutionId,
                sortOption: StudentSortOption.createdAtDesc,
              ),
            );
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadClasses() async {
    if (!mounted) return;

    setState(() {
      _isLoadingClasses = true;
    });

    try {
      final classManagementBloc = context.read<ClassManagementBloc>();
      classManagementBloc.add(
        LoadClasses(institutionId: widget.institutionId),
      );

      await classManagementBloc.stream.firstWhere(
        (state) => state is ClassesLoaded || state is ClassManagementError,
      );

      if (!mounted) return;

      final state = classManagementBloc.state;
      if (state is ClassesLoaded) {
        setState(() {
          _classes = state.classes;
          _isLoadingClasses = false;
        });
      } else if (state is ClassManagementError) {
        setState(() {
          _isLoadingClasses = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoadingClasses = false;
        });
      }
    }
  }

  void _onSearchChanged(String query) {
    final currentState = context.read<StudentManagementBloc>().state;
    final sortOption = currentState is StudentsLoaded
        ? currentState.sortOption
        : null;
    final classId = currentState is StudentsLoaded
        ? currentState.classId
        : _selectedClassFilter;

    context.read<StudentManagementBloc>().add(
      SearchStudents(
        institutionId: widget.institutionId,
        classId: classId,
        query: query,
        sortOption: sortOption,
      ),
    );
  }

  void _refreshStudents() {
    final currentState = context.read<StudentManagementBloc>().state;
    final sortOption = currentState is StudentsLoaded
        ? currentState.sortOption
        : null;
    final classId = currentState is StudentsLoaded
        ? currentState.classId
        : _selectedClassFilter;

    context.read<StudentManagementBloc>().add(
      RefreshStudents(
        institutionId: widget.institutionId,
        classId: classId,
        sortOption: sortOption,
      ),
    );
  }

  void _onSortChanged(StudentSortOption sortOption) {
    final currentState = context.read<StudentManagementBloc>().state;
    final searchQuery = currentState is StudentsLoaded
        ? currentState.searchQuery
        : null;
    final classId = currentState is StudentsLoaded
        ? currentState.classId
        : _selectedClassFilter;

    context.read<StudentManagementBloc>().add(
      SortStudents(
        institutionId: widget.institutionId,
        classId: classId,
        sortOption: sortOption,
        searchQuery: searchQuery,
      ),
    );
  }

  void _onClassFilterChanged(String? classId) {
    setState(() {
      _selectedClassFilter = classId;
    });

    final currentState = context.read<StudentManagementBloc>().state;
    final sortOption = currentState is StudentsLoaded
        ? currentState.sortOption
        : null;
    final searchQuery = currentState is StudentsLoaded
        ? currentState.searchQuery
        : null;

    context.read<StudentManagementBloc>().add(
      FilterStudentsByClass(
        institutionId: widget.institutionId,
        classId: classId,
        searchQuery: searchQuery,
        sortOption: sortOption,
      ),
    );
  }

  void _handleEdit(StudentEntity studentEntity) async {
    final result = await context.push(
      '/institutions/${widget.institutionId}/students/${studentEntity.studentId}/edit',
    );
    if (result == true && mounted) {
      _refreshStudents();
    }
  }

  void _handleDelete(StudentEntity studentEntity) {
    // Capture the outer context before showing the dialog
    final outerContext = context;

    showDialog(
      useRootNavigator: false,
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Student'),
        content: Text(
          'Are you sure you want to delete "${studentEntity.name}"? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              outerContext.read<StudentManagementBloc>().add(
                    DeleteStudent(
                      institutionId: widget.institutionId,
                      studentId: studentEntity.studentId,
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

  String? _getClassName(String classId) {
    try {
      return _classes.firstWhere((c) => c.id == classId).name;
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Management'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshStudents,
            tooltip: 'Refresh',
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final result = await context.push(
                '/institutions/${widget.institutionId}/students/create',
              );
              if (result == true && mounted) {
                _refreshStudents();
              }
            },
            tooltip: 'Create Student',
          ),
        ],
      ),
      body: BlocListener<StudentManagementBloc, StudentManagementState>(
        listener: (context, state) {
          if (state is StudentOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
            _refreshStudents();
          } else if (state is StudentManagementError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<StudentManagementBloc, StudentManagementState>(
          builder: (context, state) {
            final currentSort = state is StudentsLoaded
                ? state.sortOption
                : StudentSortOption.createdAtDesc;

            return Column(
              children: [
                // Filter and Sort section
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            minWidth: 150,
                            maxWidth: 250,
                          ),
                          child: DropdownButtonFormField<String>(
                            initialValue: _selectedClassFilter,
                            decoration: InputDecoration(
                              labelText: 'Filter by Class',
                              hintText: 'All Classes',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 16,
                              ),
                              prefixIcon: const Icon(Icons.filter_list),
                            ),
                            items: [
                              const DropdownMenuItem<String>(
                                value: null,
                                child: Text('All Classes'),
                              ),
                              ..._classes.map(
                                (classEntity) => DropdownMenuItem<String>(
                                  value: classEntity.id,
                                  child: Text(classEntity.name),
                                ),
                              ),
                            ],
                            onChanged: _isLoadingClasses
                                ? null
                                : (value) {
                                    _onClassFilterChanged(value);
                                  },
                          ),
                        ),
                        const SizedBox(width: 8),
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            minWidth: 150,
                            maxWidth: 250,
                          ),
                          child: DropdownButtonFormField<StudentSortOption>(
                            initialValue: currentSort,
                            decoration: InputDecoration(
                              labelText: 'Sort By',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 16,
                              ),
                              prefixIcon: const Icon(Icons.sort),
                            ),
                            items: StudentSortOption.values.map((option) {
                              return DropdownMenuItem<StudentSortOption>(
                                value: option,
                                child: Text(option.displayName),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                _onSortChanged(value);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Search bar
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText:
                          'Search students by name, ID, email, or phone...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                _onSearchChanged('');
                              },
                            )
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onChanged: _onSearchChanged,
                  ),
                ),

                // Student list
                Expanded(
                  child: BlocBuilder<StudentManagementBloc,
                      StudentManagementState>(
                    builder: (context, state) {
                      if (state is StudentManagementLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (state is StudentsLoaded) {
                        if (state.students.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.person_outline,
                                  size: 64,
                                  color: Colors.grey[400],
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  state.searchQuery != null &&
                                          state.searchQuery!.isNotEmpty
                                      ? 'No students found matching "${state.searchQuery}"'
                                      : state.classId != null
                                          ? 'No students found in selected class'
                                          : 'No students found',
                                  style: theme.textTheme.titleMedium
                                      ?.copyWith(color: Colors.grey[600]),
                                ),
                              ],
                            ),
                          );
                        }

                        return RefreshIndicator(
                          onRefresh: () async => _refreshStudents(),
                          child: ListView.builder(
                            itemCount: state.students.length,
                            itemBuilder: (context, index) {
                              final student = state.students[index];
                              return StudentListItem(
                                studentEntity: student,
                                className: _getClassName(student.classId),
                                onTap: () {
                                  // Navigate to detail or edit
                                  _handleEdit(student);
                                },
                                onEdit: () => _handleEdit(student),
                                onDelete: () => _handleDelete(student),
                              );
                            },
                          ),
                        );
                      }

                      if (state is StudentManagementError) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error_outline,
                                size: 64,
                                color: Colors.red[300],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                state.message,
                                style: theme.textTheme.titleMedium
                                    ?.copyWith(color: Colors.red[700]),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: _refreshStudents,
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        );
                      }

                      return const Center(child: Text('No data available'));
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

