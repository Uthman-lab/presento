part of '../auth.ui.dart';

class InstitutionCard extends StatelessWidget {
  final Institution institution;
  final String userRole;
  final bool isSelected;
  final VoidCallback onTap;

  const InstitutionCard({
    super.key,
    required this.institution,
    required this.userRole,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isSelected ? 4 : 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected
              ? Theme.of(context).primaryColor
              : Colors.grey.shade300,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Institution Icon
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: isSelected
                      ? Theme.of(context).primaryColor.withValues(alpha: 0.1)
                      : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Icon(
                  Icons.school,
                  color: isSelected
                      ? Theme.of(context).primaryColor
                      : Colors.grey.shade600,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),

              // Institution Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      institution.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isSelected
                            ? Theme.of(context).primaryColor
                            : null,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _getRoleDisplayName(userRole),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),

              // Selection Indicator
              if (isSelected)
                Icon(
                  Icons.check_circle,
                  color: Theme.of(context).primaryColor,
                  size: 24,
                )
              else
                Icon(
                  Icons.radio_button_unchecked,
                  color: Colors.grey.shade400,
                  size: 24,
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _getRoleDisplayName(String role) {
    switch (role) {
      case superAdminRole:
        return 'Super Administrator';
      case adminRole:
        return 'Institution Administrator';
      case teacherRole:
        return 'Teacher';
      case studentRole:
        return 'Student';
      case classRepresentativeRole:
        return 'Class Representative';
      case stakeholderRole:
        return 'Stakeholder';
      default:
        return role.replaceAll('_', ' ').toUpperCase();
    }
  }
}
