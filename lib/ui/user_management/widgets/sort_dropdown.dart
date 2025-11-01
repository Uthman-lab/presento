part of '../user_management.ui.dart';

class SortDropdown extends StatelessWidget {
  final UserSortOption currentSort;
  final Function(UserSortOption) onChanged;

  const SortDropdown({
    super.key,
    required this.currentSort,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<UserSortOption>(
      initialValue: currentSort,
      isExpanded: true,
      decoration: InputDecoration(
        labelText: 'Sort By',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 16,
        ),
        prefixIcon: const Icon(Icons.sort),
      ),
      items: [
        DropdownMenuItem<UserSortOption>(
          value: UserSortOption.none,
          child: Row(
            children: [
              const Icon(Icons.unfold_more, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'No Sorting',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        const DropdownMenuItem<UserSortOption>(
          value: null,
          enabled: false,
          child: Divider(),
        ),
        DropdownMenuItem<UserSortOption>(
          value: UserSortOption.nameAsc,
          child: Row(
            children: [
              const Icon(Icons.sort_by_alpha, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Name (A-Z)',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        DropdownMenuItem<UserSortOption>(
          value: UserSortOption.nameDesc,
          child: Row(
            children: [
              const Icon(Icons.sort_by_alpha, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Name (Z-A)',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        DropdownMenuItem<UserSortOption>(
          value: UserSortOption.emailAsc,
          child: Row(
            children: [
              const Icon(Icons.email, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Email (A-Z)',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        DropdownMenuItem<UserSortOption>(
          value: UserSortOption.emailDesc,
          child: Row(
            children: [
              const Icon(Icons.email, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Email (Z-A)',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        DropdownMenuItem<UserSortOption>(
          value: UserSortOption.roleAsc,
          child: Row(
            children: [
              const Icon(Icons.account_circle, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Role (Ascending)',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        DropdownMenuItem<UserSortOption>(
          value: UserSortOption.roleDesc,
          child: Row(
            children: [
              const Icon(Icons.account_circle, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Role (Descending)',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        DropdownMenuItem<UserSortOption>(
          value: UserSortOption.createdAtAsc,
          child: Row(
            children: [
              const Icon(Icons.calendar_today, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Created Date (Oldest)',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        DropdownMenuItem<UserSortOption>(
          value: UserSortOption.createdAtDesc,
          child: Row(
            children: [
              const Icon(Icons.calendar_today, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Created Date (Newest)',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        DropdownMenuItem<UserSortOption>(
          value: UserSortOption.updatedAtAsc,
          child: Row(
            children: [
              const Icon(Icons.update, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Updated Date (Oldest)',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        DropdownMenuItem<UserSortOption>(
          value: UserSortOption.updatedAtDesc,
          child: Row(
            children: [
              const Icon(Icons.update, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Updated Date (Newest)',
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
          onChanged(value);
        }
      },
    );
  }
}
