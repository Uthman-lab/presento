import 'package:flutter/material.dart';

class QuickAction {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final bool isEnabled;

  const QuickAction({
    required this.icon,
    required this.label,
    this.onTap,
    this.isEnabled = true,
  });
}

class QuickActions extends StatelessWidget {
  final List<QuickAction> actions;

  const QuickActions({super.key, required this.actions});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: actions.length,
        itemBuilder: (context, index) {
          final action = actions[index];
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: _QuickActionButton(action: action, theme: theme),
          );
        },
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final QuickAction action;
  final ThemeData theme;

  const _QuickActionButton({required this.action, required this.theme});

  @override
  Widget build(BuildContext context) {
    final backgroundColor = action.isEnabled
        ? theme.primaryColor.withValues(alpha: 0.1)
        : theme.primaryColor.withValues(alpha: 0.05);
    final iconColor = action.isEnabled
        ? theme.primaryColor
        : theme.primaryColor.withValues(alpha: 0.5);
    final textColor = action.isEnabled
        ? theme.textTheme.bodyMedium?.color
        : theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.5);

    return InkWell(
      onTap: action.isEnabled ? action.onTap : null,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 80,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: theme.primaryColor.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(action.icon, size: 24, color: iconColor),
            const SizedBox(height: 8),
            Text(
              action.label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: textColor,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
