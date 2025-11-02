part of '../class_management.ui.dart';

class ClassListItem extends StatelessWidget {
  final ClassEntity classEntity;
  final String institutionId;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ClassListItem({
    super.key,
    required this.classEntity,
    required this.institutionId,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: theme.primaryColor,
          child: Text(
            classEntity.name.isNotEmpty
                ? classEntity.name[0].toUpperCase()
                : '?',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          classEntity.name,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (classEntity.description != null &&
                classEntity.description!.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                classEntity.description!,
                style: theme.textTheme.bodySmall,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            const SizedBox(height: 4),
            Text(
              'Created: ${_formatDate(classEntity.createdAt)}',
              style: theme.textTheme.bodySmall,
            ),
            if (classEntity.updatedAt != classEntity.createdAt)
              Text(
                'Updated: ${_formatDate(classEntity.updatedAt)}',
                style: theme.textTheme.bodySmall,
              ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              onSelected: (value) {
                if (value == 'mark_attendance') {
                  _navigateToMarkAttendance(context);
                } else if (value == 'view_history') {
                  _navigateToAttendanceHistory(context);
                } else if (value == 'edit' && onEdit != null) {
                  onEdit!();
                } else if (value == 'delete' && onDelete != null) {
                  onDelete!();
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'mark_attendance',
                  child: Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.green, size: 20),
                      SizedBox(width: 8),
                      Text('Mark Attendance'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'view_history',
                  child: Row(
                    children: [
                      Icon(Icons.history, color: Colors.orange, size: 20),
                      SizedBox(width: 8),
                      Text('View History'),
                    ],
                  ),
                ),
                if (onEdit != null)
                  const PopupMenuItem(
                    value: 'edit',
                    child: Row(
                      children: [
                        Icon(Icons.edit, color: Colors.blue, size: 20),
                        SizedBox(width: 8),
                        Text('Edit'),
                      ],
                    ),
                  ),
                if (onDelete != null)
                  const PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete, color: Colors.red, size: 20),
                        SizedBox(width: 8),
                        Text('Delete'),
                      ],
                    ),
                  ),
              ],
            ),
            if (onTap != null) const Icon(Icons.chevron_right),
          ],
        ),
        onTap: onTap,
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  void _navigateToMarkAttendance(BuildContext context) {
    context.push(
      '/institutions/$institutionId/classes/${classEntity.id}/attendance/mark',
    );
  }

  void _navigateToAttendanceHistory(BuildContext context) {
    context.push(
      '/institutions/$institutionId/classes/${classEntity.id}/attendance/history',
    );
  }
}
