import 'package:presento/imports.dart';

/// A reusable wrapper around [DropdownButtonFormField] that applies the
/// application's default styling while still allowing full customization of
/// behaviour and decoration.
class CustomDropdownButtonFormField<T> extends StatelessWidget {
  const CustomDropdownButtonFormField({
    super.key,
    this.value,
    required this.items,
    required this.onChanged,
    this.onSaved,
    this.onTap,
    this.validator,
    this.decoration,
    this.autovalidateMode,
    this.enabled,
    this.elevation = 8,
    this.style,
    this.isDense,
    this.isExpanded = true,
    this.autofocus = false,
    this.focusNode,
    this.dropdownColor,
    this.icon,
    this.iconDisabledColor,
    this.iconEnabledColor,
    this.iconSize,
    this.hint,
    this.disabledHint,
    this.selectedItemBuilder,
    this.menuMaxHeight,
    this.alignment = AlignmentDirectional.centerStart,
    this.enableFeedback,
    this.borderRadius,
    this.itemHeight,
  });

  final T? value;
  final List<DropdownMenuItem<T>>? items;
  final ValueChanged<T?>? onChanged;
  final FormFieldSetter<T>? onSaved;
  final VoidCallback? onTap;
  final FormFieldValidator<T>? validator;
  final InputDecoration? decoration;
  final AutovalidateMode? autovalidateMode;
  final bool? enabled;
  final int elevation;
  final TextStyle? style;
  final bool? isDense;
  final bool isExpanded;
  final bool autofocus;
  final FocusNode? focusNode;
  final Color? dropdownColor;
  final Widget? icon;
  final Color? iconDisabledColor;
  final Color? iconEnabledColor;
  final double? iconSize;
  final Widget? hint;
  final Widget? disabledHint;
  final DropdownButtonBuilder? selectedItemBuilder;
  final double? menuMaxHeight;
  final AlignmentGeometry alignment;
  final bool? enableFeedback;
  final BorderRadius? borderRadius;
  final double? itemHeight;

  @override
  Widget build(BuildContext context) {
    final bool isFieldEnabled = enabled ?? true;
    final InputDecoration baseDecoration =
        decoration ?? const InputDecoration();
    final InputDecoration effectiveDecoration = baseDecoration.copyWith(
      border:
          baseDecoration.border ??
          OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      enabledBorder: baseDecoration.enabledBorder,
      focusedBorder: baseDecoration.focusedBorder,
      errorBorder: baseDecoration.errorBorder,
      disabledBorder: baseDecoration.disabledBorder,
      focusedErrorBorder: baseDecoration.focusedErrorBorder,
      contentPadding:
          baseDecoration.contentPadding ??
          const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    );

    return DropdownButtonFormField<T>(
      value: value,
      items: items,
      onChanged: isFieldEnabled ? onChanged : null,
      onSaved: onSaved,
      onTap: isFieldEnabled ? onTap : null,
      validator: validator,
      autovalidateMode: autovalidateMode,
      elevation: elevation,
      style: style,
      isDense: isDense ?? false,
      isExpanded: isExpanded,
      autofocus: autofocus,
      focusNode: focusNode,
      dropdownColor: dropdownColor,
      icon: icon,
      iconDisabledColor: iconDisabledColor,
      iconEnabledColor: iconEnabledColor,
      iconSize: iconSize ?? 24,
      hint: hint,
      disabledHint: disabledHint,
      selectedItemBuilder: selectedItemBuilder,
      menuMaxHeight: menuMaxHeight,
      alignment: alignment,
      enableFeedback: enableFeedback,
      borderRadius: borderRadius,
      itemHeight: itemHeight,
      decoration: effectiveDecoration,
    );
  }
}
