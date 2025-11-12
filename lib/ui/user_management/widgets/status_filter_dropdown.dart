part of '../user_management.ui.dart';

enum StatusFilterOption {
  all,
  activeOnly,
  inactiveOnly,
  superAdminOnly,
}

class StatusFilterDropdown extends StatelessWidget {
  final bool? showActiveOnly;
  final bool? showInactiveOnly;
  final bool? showSuperAdminOnly;
  final Function({
    bool? showActiveOnly,
    bool? showInactiveOnly,
    bool? showSuperAdminOnly,
  }) onChanged;

  const StatusFilterDropdown({
    super.key,
    this.showActiveOnly,
    this.showInactiveOnly,
    this.showSuperAdminOnly,
    required this.onChanged,
  });

  StatusFilterOption _getCurrentOption() {
    if (showSuperAdminOnly == true) {
      return StatusFilterOption.superAdminOnly;
    } else if (showActiveOnly == true) {
      return StatusFilterOption.activeOnly;
    } else if (showInactiveOnly == true) {
      return StatusFilterOption.inactiveOnly;
    }
    return StatusFilterOption.all;
  }


  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<StatusFilterOption>(
      initialValue: _getCurrentOption(),
      isExpanded: true,
      decoration: InputDecoration(
        labelText: 'Status Filter',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        prefixIcon: const Icon(Icons.person_search),
      ),
      items: [
        DropdownMenuItem<StatusFilterOption>(
          value: StatusFilterOption.all,
          child: Row(
            children: [
              const Icon(Icons.people, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'All Users',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        DropdownMenuItem<StatusFilterOption>(
          value: StatusFilterOption.activeOnly,
          child: Row(
            children: [
              const Icon(Icons.check_circle, size: 20, color: Colors.green),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Active Only',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        DropdownMenuItem<StatusFilterOption>(
          value: StatusFilterOption.inactiveOnly,
          child: Row(
            children: [
              const Icon(Icons.cancel, size: 20, color: Colors.grey),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Inactive Only',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        DropdownMenuItem<StatusFilterOption>(
          value: StatusFilterOption.superAdminOnly,
          child: Row(
            children: [
              const Icon(Icons.admin_panel_settings, size: 20, color: Colors.red),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Super Admins Only',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
      onChanged: (value) {
        if (value != null) {
          switch (value) {
            case StatusFilterOption.all:
              onChanged(
                showActiveOnly: null,
                showInactiveOnly: null,
                showSuperAdminOnly: null,
              );
              break;
            case StatusFilterOption.activeOnly:
              onChanged(
                showActiveOnly: true,
                showInactiveOnly: null,
                showSuperAdminOnly: null,
              );
              break;
            case StatusFilterOption.inactiveOnly:
              onChanged(
                showActiveOnly: null,
                showInactiveOnly: true,
                showSuperAdminOnly: null,
              );
              break;
            case StatusFilterOption.superAdminOnly:
              onChanged(
                showActiveOnly: null,
                showInactiveOnly: null,
                showSuperAdminOnly: true,
              );
              break;
          }
        }
      },
    );
  }
}

