part of '../student_management.ui.dart';

class StudentListItem extends StatelessWidget {
  final StudentEntity studentEntity;
  final String? className; // Optional class name for display
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const StudentListItem({
    super.key,
    required this.studentEntity,
    this.className,
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
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: theme.primaryColor,
          child: Text(
            studentEntity.name.isNotEmpty
                ? studentEntity.name[0].toUpperCase()
                : '?',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          studentEntity.name,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ID: ${studentEntity.studentId}',
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            if (className != null) ...[
              const SizedBox(height: 2),
              Text(
                'Class: $className',
                style: theme.textTheme.bodySmall,
              ),
            ] else ...[
              const SizedBox(height: 2),
              Text(
                'Class ID: ${studentEntity.classId}',
                style: theme.textTheme.bodySmall,
              ),
            ],
            if (studentEntity.email != null && studentEntity.email!.isNotEmpty)
              ...[
                const SizedBox(height: 2),
                Text(
                  'Email: ${studentEntity.email}',
                  style: theme.textTheme.bodySmall,
                ),
              ],
            if (studentEntity.phone != null && studentEntity.phone!.isNotEmpty)
              ...[
                const SizedBox(height: 2),
                Text(
                  'Phone: ${studentEntity.phone}',
                  style: theme.textTheme.bodySmall,
                ),
              ],
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (onEdit != null)
              IconButton(
                icon: const Icon(Icons.edit, size: 20),
                onPressed: onEdit,
                tooltip: 'Edit Student',
                color: Colors.blue,
              ),
            if (onDelete != null)
              IconButton(
                icon: const Icon(Icons.delete, size: 20),
                onPressed: onDelete,
                tooltip: 'Delete Student',
                color: Colors.red,
              ),
            if (onTap != null) const Icon(Icons.chevron_right),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}


