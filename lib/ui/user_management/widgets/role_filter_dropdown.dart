part of '../user_management.ui.dart';

class RoleFilterDropdown extends StatelessWidget {
  final Set<UserRole>? selectedRoles;
  final Function(Set<UserRole>?) onChanged;

  const RoleFilterDropdown({
    super.key,
    this.selectedRoles,
    required this.onChanged,
  });

  String _getDisplayText() {
    if (selectedRoles == null || selectedRoles!.isEmpty) {
      return 'All Roles';
    } else if (selectedRoles!.length == 1) {
      return selectedRoles!.first.displayName;
    } else {
      return '${selectedRoles!.length} Roles Selected';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return _RoleFilterBottomSheet(
              selectedRoles: selectedRoles,
              onChanged: onChanged,
            );
          },
        );
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Filter by Role',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          prefixIcon: const Icon(Icons.filter_list),
          suffixIcon: const Icon(Icons.arrow_drop_down),
        ),
        child: Text(
          _getDisplayText(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

class _RoleFilterBottomSheet extends StatefulWidget {
  final Set<UserRole>? selectedRoles;
  final Function(Set<UserRole>?) onChanged;

  const _RoleFilterBottomSheet({
    required this.selectedRoles,
    required this.onChanged,
  });

  @override
  State<_RoleFilterBottomSheet> createState() =>
      _RoleFilterBottomSheetState();
}

class _RoleFilterBottomSheetState extends State<_RoleFilterBottomSheet> {
  late Set<UserRole> _tempSelected;

  @override
  void initState() {
    super.initState();
    _tempSelected = Set<UserRole>.from(
      widget.selectedRoles ?? <UserRole>{},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Filter by Role',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  widget.onChanged(null);
                  Navigator.pop(context);
                },
                child: const Text('Clear All'),
              ),
            ],
          ),
          const Divider(),
          Flexible(
            child: ListView(
              shrinkWrap: true,
              children: [
                ...UserRole.values.map((role) {
                  final isSelected = _tempSelected.contains(role);
                  return CheckboxListTile(
                    title: Row(
                      children: [
                        Icon(role.icon, size: 20, color: role.color),
                        const SizedBox(width: 8),
                        Text(role.displayName),
                      ],
                    ),
                    value: isSelected,
                    onChanged: (value) {
                      setState(() {
                        if (value == true) {
                          _tempSelected.add(role);
                        } else {
                          _tempSelected.remove(role);
                        }
                      });
                    },
                  );
                }),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    widget.onChanged(
                      _tempSelected.isEmpty ? null : _tempSelected,
                    );
                    Navigator.pop(context);
                  },
                  child: const Text('Apply'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

