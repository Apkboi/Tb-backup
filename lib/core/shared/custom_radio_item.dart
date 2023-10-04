import 'package:flutter/material.dart';
import '../_core.dart';

class CustomRadioItem<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final String leading;
  final String? title;
  final String? icon;
  final ValueChanged<T?> onChanged;

  const CustomRadioItem({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.leading,
    this.title,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final title = this.title;
    return InkWell(
      onTap: () => onChanged(value),
      child: _customRadioButton,
    );
  }

  Widget get _customRadioButton {
    final isSelected = value == groupValue;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            border:
                isSelected ? Border.all(color: Colors.black, width: 1) : null,
            borderRadius: BorderRadius.circular(10),
          ),
          child: IconCard(
            iconColor: isSelected ? Pallets.primary : Pallets.borderGrey,
            icon: icon ?? 'Assets',
          ),
        ),
        4.verticalSpace,
        if (title != null)
          TextView(
            text: title!,
            fontSize: 14,
            color: isSelected ? Pallets.black : Pallets.borderGrey,
            fontWeight: FontWeight.w400,
          )
      ],
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : null,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.grey[300]!,
          width: 2,
        ),
      ),
      child: Text(
        leading,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.grey[600]!,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }
}
