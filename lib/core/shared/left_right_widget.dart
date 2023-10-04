import 'package:flutter/material.dart';
import 'package:triberly/core/_core.dart';

import '../constants/pallets.dart';
import 'text_view.dart';

class LeftRightWidget extends StatelessWidget {
  const LeftRightWidget({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextView(
            text: title,
            color: Pallets.grey,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          24.horizontalSpace,
          Expanded(
            child: TextView(
              text: value,
              fontSize: 16,
              align: TextAlign.end,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
