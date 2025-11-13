part of '../institution_management.ui.dart';

class InstitutionManagementScreen extends StatefulWidget {
  const InstitutionManagementScreen({super.key});

  @override
  State<InstitutionManagementScreen> createState() =>
      _InstitutionManagementScreenState();
}

class _InstitutionManagementScreenState
    extends State<InstitutionManagementScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Defer bloc access until after the first frame is built
    // This ensures the BlocProvider from the route builder is available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<InstitutionManagementBloc>().add(const LoadInstitutions());
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    final currentState = context.read<InstitutionManagementBloc>().state;
    final sortOption = currentState is InstitutionsLoaded
        ? currentState.sortOption
        : null;

    context.read<InstitutionManagementBloc>().add(
      SearchInstitutions(query: query, sortOption: sortOption),
    );
  }

  void _refreshInstitutions() {
    final currentState = context.read<InstitutionManagementBloc>().state;
    final sortOption = currentState is InstitutionsLoaded
        ? currentState.sortOption
        : null;

    context.read<InstitutionManagementBloc>().add(
      RefreshInstitutions(sortOption: sortOption),
    );
  }

  void _onSortChanged(InstitutionSortOption sortOption) {
    final currentState = context.read<InstitutionManagementBloc>().state;
    final searchQuery = currentState is InstitutionsLoaded
        ? currentState.searchQuery
        : null;

    context.read<InstitutionManagementBloc>().add(
      SortInstitutions(sortOption: sortOption, searchQuery: searchQuery),
    );
  }

  void _handleEdit(Institution institution) async {
    final result = await context.push('/institutions/${institution.id}/edit');
    if (!context.mounted) return;

    if (result == true) {
      _refreshInstitutions();
      // Refresh AuthBloc's institutions list so other screens stay in sync
      context.read<AuthBloc>().add(const AllInstitutionsLoadRequested());
    }
  }

  void _handleDelete(Institution institution) {
    // Capture the outer context before showing the dialog
    final outerContext = context;

    showDialog(
      useRootNavigator: false,
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Institution'),
        content: Text(
          'Are you sure you want to delete "${institution.name}"? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Dispatch delete event using dialog context (fine for InstitutionManagementBloc)
              outerContext.read<InstitutionManagementBloc>().add(
                DeleteInstitution(institutionId: institution.id),
              );
              // Use captured outer context to refresh AuthBloc explicitly
              outerContext.read<AuthBloc>().add(
                const AllInstitutionsLoadRequested(),
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
    final currentUser = context.select<AuthBloc, User?>((bloc) {
      final state = bloc.state;
      if (state is Authenticated) return state.user;
      if (state is AllInstitutionsLoaded) return state.user;
      return null;
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Institution Management'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshInstitutions,
            tooltip: 'Refresh',
          ),
          if (currentUser?.isSuperAdmin == true)
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () async {
                final result = await context.push(
                  AppRouter.createInstitutionRoute,
                );
                if (!context.mounted) return;

                if (result == true) {
                  _refreshInstitutions();
                  // Refresh AuthBloc's institutions list so other screens stay in sync
                  context.read<AuthBloc>().add(
                    const AllInstitutionsLoadRequested(),
                  );
                }
              },
              tooltip: 'Create Institution',
            ),
        ],
      ),
      body: BlocListener<InstitutionManagementBloc, InstitutionManagementState>(
        listener: (context, state) {
          if (state is InstitutionOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
            _refreshInstitutions();
            // Refresh AuthBloc's institutions list so other screens stay in sync
            context.read<AuthBloc>().add(const AllInstitutionsLoadRequested());
          } else if (state is InstitutionManagementError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<InstitutionManagementBloc, InstitutionManagementState>(
          builder: (context, state) {
            final currentSort = state is InstitutionsLoaded
                ? state.sortOption
                : InstitutionSortOption.none;

            return Column(
              children: [
                // Sort section
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomDropdownButtonFormField<InstitutionSortOption>(
                          value: currentSort,
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
                          items: InstitutionSortOption.values.map((option) {
                            return DropdownMenuItem<InstitutionSortOption>(
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
                      hintText: 'Search institutions by name...',
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

                // Institution list
                Expanded(
                  child:
                      BlocBuilder<
                        InstitutionManagementBloc,
                        InstitutionManagementState
                      >(
                        builder: (context, state) {
                          if (state is InstitutionManagementLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (state is InstitutionsLoaded) {
                            if (state.institutions.isEmpty) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.business_outlined,
                                      size: 64,
                                      color: Colors.grey[400],
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      state.searchQuery != null &&
                                              state.searchQuery!.isNotEmpty
                                          ? 'No institutions found matching "${state.searchQuery}"'
                                          : 'No institutions found',
                                      style: theme.textTheme.titleMedium
                                          ?.copyWith(color: Colors.grey[600]),
                                    ),
                                  ],
                                ),
                              );
                            }

                            return RefreshIndicator(
                              onRefresh: () async => _refreshInstitutions(),
                              child: ListView.builder(
                                itemCount: state.institutions.length,
                                itemBuilder: (context, index) {
                                  final institution = state.institutions[index];
                                  return InstitutionListItem(
                                    institution: institution,
                                    onTap: () {
                                      // Navigate to detail screen to access classes and other options
                                      context.push(
                                        '/institutions/${institution.id}',
                                      );
                                    },
                                    onEdit: () => _handleEdit(institution),
                                    onDelete: () => _handleDelete(institution),
                                  );
                                },
                              ),
                            );
                          }

                          if (state is InstitutionManagementError) {
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
                                    onPressed: _refreshInstitutions,
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
