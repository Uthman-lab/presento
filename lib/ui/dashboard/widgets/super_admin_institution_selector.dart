import 'package:flutter/material.dart';
import 'package:presento/imports.dart';
import '../../../modules/institution/domain/domain.dart';

class SuperAdminInstitutionSelector extends StatelessWidget {
  final List<Institution> institutions;
  final String? selectedInstitutionId;
  final Function(String institutionId) onInstitutionSelected;

  const SuperAdminInstitutionSelector({
    super.key,
    required this.institutions,
    this.selectedInstitutionId,
    required this.onInstitutionSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (institutions.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'No institutions found',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey[600],
            ),
          ),
        ),
      );
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.business, color: theme.primaryColor),
                const SizedBox(width: 8),
                Text(
                  'Select Institution',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (institutions.length <= 5)
              ...institutions.map((institution) {
                final isSelected = institution.id == selectedInstitutionId;
                return _buildInstitutionTile(context, institution, isSelected);
              })
            else
              _buildDropdownSelector(context),
          ],
        ),
      ),
    );
  }

  Widget _buildInstitutionTile(
    BuildContext context,
    Institution institution,
    bool isSelected,
  ) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () => onInstitutionSelected(institution.id),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.primaryColor.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected
                ? theme.primaryColor
                : Colors.grey.withOpacity(0.3),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.check_circle : Icons.business,
              color: isSelected ? theme.primaryColor : Colors.grey[600],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                institution.name,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  color: isSelected
                      ? theme.primaryColor
                      : theme.textTheme.bodyLarge?.color,
                ),
              ),
            ),
            if (isSelected)
              Icon(Icons.arrow_forward, color: theme.primaryColor, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownSelector(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedInstitutionId,
      decoration: InputDecoration(
        labelText: 'Select Institution',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        prefixIcon: const Icon(Icons.business),
      ),
      items: [
        const DropdownMenuItem<String>(
          value: null,
          child: Text('All Institutions (System View)'),
        ),
        ...institutions.map((institution) {
          return DropdownMenuItem<String>(
            value: institution.id,
            child: Text(institution.name),
          );
        }),
      ],
      onChanged: (value) {
        if (value != null) {
          onInstitutionSelected(value);
        } else {
          // Clear selection - show system view
          onInstitutionSelected('');
        }
      },
    );
  }
}
