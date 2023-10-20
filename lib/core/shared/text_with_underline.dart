import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:triberly/app/base/presentation/pages/base/base_page.dart';
import 'package:triberly/app/home/presentation/widgets/filter_widget.dart';
import 'package:triberly/core/_core.dart';
import 'package:triberly/generated/l10n.dart';

class TextWithUndeline extends StatelessWidget {
  const TextWithUndeline({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextView(
          text: text,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        5.verticalSpace,
        Container(
          width: 89.w,
          height: 2,
          color: Pallets.primary,
        )
      ],
    );
  }
}
