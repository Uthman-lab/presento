part of '../user_management.ui.dart';

class InstitutionRoleEditor extends StatefulWidget {
  final User user;
  final List<Institution> institutions;
  final Function(Map<String, InstitutionRole>) onRolesChanged;

  const InstitutionRoleEditor({
    super.key,
    required this.user,
    required this.institutions,
    required this.onRolesChanged,
  });

  @override
  State<InstitutionRoleEditor> createState() => _InstitutionRoleEditorState();
}

class _InstitutionRoleEditorState extends State<InstitutionRoleEditor> {
  late Map<String, InstitutionRole> editedRoles;

  @override
  void initState() {
    super.initState();
    editedRoles = Map<String, InstitutionRole>.from(widget.user.roles);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Institution Roles',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ...widget.institutions.map((institution) {
          final institutionId = institution.id;
          final currentRole = editedRoles[institutionId];
          final hasRole = currentRole != null;

          return Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: ExpansionTile(
              leading: Checkbox(
                value: hasRole,
                onChanged: (checked) {
                  setState(() {
                    if (checked == true) {
                      // Add role
                      editedRoles[institutionId] = InstitutionRole(
                        role: AppConstants.teacherRole, // Default role
                        isActive: true,
                        joinedAt: DateTime.now(),
                      );
                    } else {
                      // Remove role
                      editedRoles.remove(institutionId);
                    }
                    widget.onRolesChanged(editedRoles);
                  });
                },
              ),
              title: Text(institution.name),
              subtitle: hasRole
                  ? Text('Role: ${currentRole.role}')
                  : const Text('No role assigned'),
              children: hasRole
                  ? [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            DropdownButtonFormField<String>(
                              value: currentRole.role,
                              decoration: const InputDecoration(
                                labelText: 'Role',
                                border: OutlineInputBorder(),
                              ),
                              items:
                                  [
                                    AppConstants.teacherRole,
                                    AppConstants.studentRole,
                                    AppConstants.classRepRole,
                                    AppConstants.stakeholderRole,
                                  ].map((role) {
                                    return DropdownMenuItem(
                                      value: role,
                                      child: Text(_getRoleDisplayName(role)),
                                    );
                                  }).toList(),
                              onChanged: (newRole) {
                                if (newRole != null) {
                                  setState(() {
                                    editedRoles[institutionId] =
                                        InstitutionRole(
                                          role: newRole,
                                          assignedClassId:
                                              currentRole.assignedClassId,
                                          isActive: currentRole.isActive,
                                          joinedAt: currentRole.joinedAt,
                                        );
                                    widget.onRolesChanged(editedRoles);
                                  });
                                }
                              },
                            ),
                            const SizedBox(height: 16),
                            SwitchListTile(
                              title: const Text('Active'),
                              value: currentRole.isActive,
                              onChanged: (isActive) {
                                setState(() {
                                  editedRoles[institutionId] = InstitutionRole(
                                    role: currentRole.role,
                                    assignedClassId:
                                        currentRole.assignedClassId,
                                    isActive: isActive,
                                    joinedAt: currentRole.joinedAt,
                                  );
                                  widget.onRolesChanged(editedRoles);
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ]
                  : [],
            ),
          );
        }),
      ],
    );
  }

  String _getRoleDisplayName(String role) {
    switch (role) {
      case 'teacher':
        return 'Teacher';
      case 'student':
        return 'Student';
      case 'class_rep':
        return 'Class Representative';
      case 'stakeholder':
        return 'Stakeholder';
      default:
        return role;
    }
  }
}
