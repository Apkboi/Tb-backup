import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triberly/core/_core.dart';

class IntroDialog extends StatefulWidget {
  const IntroDialog({Key? key}) : super(key: key);

  @override
  State<IntroDialog> createState() => _IntroDialogState();
}

class _IntroDialogState extends State<IntroDialog> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        children: [
          const ImageWidget(imageUrl: Assets.svgsIntroIcon),
          10.verticalSpace,
          const TextView(
            text: "Swipe left or right to see more tribers",
            style: TextStyle(
                color: Pallets.white,
                fontSize: 16,
                fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}

final isFirsTImeProvider = StateProvider<bool>((ref) => false);
