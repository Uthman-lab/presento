part of '../class_management.ui.dart';

class ClassManagementScreen extends StatefulWidget {
  final String institutionId;

  const ClassManagementScreen({super.key, required this.institutionId});

  @override
  State<ClassManagementScreen> createState() => _ClassManagementScreenState();
}

class _ClassManagementScreenState extends State<ClassManagementScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Defer bloc access until after the first frame is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<ClassManagementBloc>().add(
          LoadClasses(institutionId: widget.institutionId),
        );
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    final currentState = context.read<ClassManagementBloc>().state;
    final sortOption = currentState is ClassesLoaded
        ? currentState.sortOption
        : null;

    context.read<ClassManagementBloc>().add(
      SearchClasses(
        institutionId: widget.institutionId,
        query: query,
        sortOption: sortOption,
      ),
    );
  }

  void _refreshClasses() {
    final currentState = context.read<ClassManagementBloc>().state;
    final sortOption = currentState is ClassesLoaded
        ? currentState.sortOption
        : null;

    context.read<ClassManagementBloc>().add(
      RefreshClasses(
        institutionId: widget.institutionId,
        sortOption: sortOption,
      ),
    );
  }

  void _onSortChanged(ClassSortOption sortOption) {
    final currentState = context.read<ClassManagementBloc>().state;
    final searchQuery = currentState is ClassesLoaded
        ? currentState.searchQuery
        : null;

    context.read<ClassManagementBloc>().add(
      SortClasses(
        institutionId: widget.institutionId,
        sortOption: sortOption,
        searchQuery: searchQuery,
      ),
    );
  }

  void _handleEdit(ClassEntity classEntity) async {
    final result = await context.push(
      '/institutions/${widget.institutionId}/classes/${classEntity.id}/edit',
    );
    if (result == true && mounted) {
      _refreshClasses();
    }
  }

  void _handleDelete(ClassEntity classEntity) {
    // Capture the outer context before showing the dialog
    final outerContext = context;

    showDialog(
      useRootNavigator: false,
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Class'),
        content: Text(
          'Are you sure you want to delete "${classEntity.name}"? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              outerContext.read<ClassManagementBloc>().add(
                DeleteClass(
                  institutionId: widget.institutionId,
                  classId: classEntity.id,
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Class Management'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshClasses,
            tooltip: 'Refresh',
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final result = await context.push(
                '/institutions/${widget.institutionId}/classes/create',
              );
              if (result == true && mounted) {
                _refreshClasses();
              }
            },
            tooltip: 'Create Class',
          ),
        ],
      ),
      body: BlocListener<ClassManagementBloc, ClassManagementState>(
        listener: (context, state) {
          if (state is ClassOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
            _refreshClasses();
          } else if (state is ClassManagementError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<ClassManagementBloc, ClassManagementState>(
          builder: (context, state) {
            final currentSort = state is ClassesLoaded
                ? state.sortOption
                : ClassSortOption.none;

            return Column(
              children: [
                // Sort section
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<ClassSortOption>(
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
                          items: ClassSortOption.values.map((option) {
                            return DropdownMenuItem<ClassSortOption>(
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

                // Search bar
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search classes by name or description...',
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

                // Class list
                Expanded(
                  child: BlocBuilder<ClassManagementBloc, ClassManagementState>(
                    builder: (context, state) {
                      if (state is ClassManagementLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state is ClassesLoaded) {
                        if (state.classes.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.class_outlined,
                                  size: 64,
                                  color: Colors.grey[400],
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  state.searchQuery != null &&
                                          state.searchQuery!.isNotEmpty
                                      ? 'No classes found matching "${state.searchQuery}"'
                                      : 'No classes found',
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        return RefreshIndicator(
                          onRefresh: () async => _refreshClasses(),
                          child: ListView.builder(
                            itemCount: state.classes.length,
                            itemBuilder: (context, index) {
                              final classEntity = state.classes[index];
                              return ClassListItem(
                                classEntity: classEntity,
                                institutionId: widget.institutionId,
                                onTap: () {
                                  // Navigate to detail or edit
                                  _handleEdit(classEntity);
                                },
                                onEdit: () => _handleEdit(classEntity),
                                onDelete: () => _handleDelete(classEntity),
                              );
                            },
                          ),
                        );
                      }

                      if (state is ClassManagementError) {
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
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: Colors.red[700],
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: _refreshClasses,
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
