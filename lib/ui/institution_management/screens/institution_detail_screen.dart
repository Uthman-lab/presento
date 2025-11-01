part of '../institution_management.ui.dart';

class InstitutionDetailScreen extends StatelessWidget {
  final String institutionId;

  const InstitutionDetailScreen({
    super.key,
    required this.institutionId,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (context) => di.sl<InstitutionManagementBloc>()
        ..add(LoadInstitution(institutionId: institutionId)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Institution Details'),
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          actions: [
            BlocBuilder<InstitutionManagementBloc,
                InstitutionManagementState>(
              builder: (context, state) {
                if (state is InstitutionLoaded) {
                  return IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () async {
                      final result = await context.push('/institutions/${institutionId}/edit');
                      if (result == true && context.mounted) {
                        context.read<InstitutionManagementBloc>().add(
                              LoadInstitution(institutionId: institutionId),
                            );
                      }
                    },
                    tooltip: 'Edit Institution',
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
        body: BlocBuilder<InstitutionManagementBloc,
            InstitutionManagementState>(
          builder: (context, state) {
            if (state is InstitutionManagementLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is InstitutionLoaded) {
              final institution = state.institution;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: theme.primaryColor,
                                  radius: 30,
                                  child: Text(
                                    institution.name.isNotEmpty
                                        ? institution.name[0].toUpperCase()
                                        : '?',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        institution.name,
                                        style: theme.textTheme.headlineSmall
                                            ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'ID: ${institution.id}',
                                        style: theme.textTheme.bodySmall?.copyWith(
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Details',
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildDetailRow(
                              context,
                              'Created',
                              _formatDateTime(institution.createdAt),
                              Icons.calendar_today,
                            ),
                            const SizedBox(height: 12),
                            _buildDetailRow(
                              context,
                              'Last Updated',
                              _formatDateTime(institution.updatedAt),
                              Icons.update,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          showDialog(
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
                                    context
                                        .read<InstitutionManagementBloc>()
                                        .add(
                                          DeleteInstitution(
                                            institutionId: institution.id,
                                          ),
                                        );
                                    Navigator.pop(context, true);
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.red,
                                  ),
                                  child: const Text('Delete'),
                                ),
                              ],
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        icon: const Icon(Icons.delete),
                        label: const Text('Delete Institution'),
                      ),
                    ),
                  ],
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
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.red[700],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }

            return const Center(child: Text('No data available'));
          },
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatDateTime(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} '
        '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}

