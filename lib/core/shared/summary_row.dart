import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../_core.dart';

class SummaryRow extends StatelessWidget {
  const SummaryRow({
    super.key,
    required this.title,
    required this.value,
    this.icon,
  }) : assert(value is String || value is Widget);

  final String title;
  final dynamic value;
  final String? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (icon != null)
            Row(
              children: [
                const ImageWidget(
                  imageUrl: 'Assets.svgsExchange',
                ),
                8.horizontalSpace,
                TextView(
                  text: title,
                  color: Pallets.primary,
                  fontWeight: FontWeight.w400,
                ),
              ],
            )
          else
            Expanded(
              child: TextView(
                text: title,
                color: Pallets.primary,
                fontWeight: FontWeight.w400,
              ),
            ),
          Expanded(
            child: (value is Widget)
                ? value
                : TextView(
                    text: value,
                    color: Pallets.primaryDark,
                    fontWeight: FontWeight.w600,
                    align: TextAlign.end,
                  ),
          ),
        ],
      ),
    );
  }
}
