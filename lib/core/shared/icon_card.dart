import 'package:flutter/material.dart';
import '../_core.dart';

import '../_core.dart';

class IconCard extends StatelessWidget {
  const IconCard({
    super.key,
    this.color,
    this.title,
    required this.icon,
    this.isFlag = false,
    this.onTap,
    this.iconColor,
  });

  final Color? color;
  final Color? iconColor;
  final String? title;
  final String icon;
  final bool isFlag;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 54,
            width: 54,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: color ?? Pallets.primaryDark,
            ),
            child: isFlag
                ? Center(child: TextView(text: icon, fontSize: 35))
                : ImageWidget(
                    imageUrl: icon,
                    size: 24,
                    color: iconColor,
                    fit: BoxFit.scaleDown,
                  ),
          ),
          if (title != null) 10.verticalSpace,
          if (title != null)
            TextView(
              text: title ?? '',
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
        ],
      ),
    );
  }
}
