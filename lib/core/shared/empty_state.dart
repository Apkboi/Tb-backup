import 'package:flutter/material.dart';
import '../_core.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    this.title,
    this.subtitle,
    required this.imageUrl,
  });

  final String? title;
  final String? subtitle;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          24.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageWidget(imageUrl: imageUrl),
            ],
          ),
          24.verticalSpace,
          TextView(
            text: title ?? 'No activity to show !',
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
          11.verticalSpace,
          TextView(
            text: subtitle ??
                'You don’t have any transactions done. Once you make any transactions it will show here.',
            fontWeight: FontWeight.w400,
            fontSize: 12,
            align: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
