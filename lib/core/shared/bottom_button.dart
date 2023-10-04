import 'package:flutter/material.dart';
import '../_core.dart';

class BottomButton extends StatelessWidget {
  const BottomButton({
    Key? key,
    this.button,
  }) : super(key: key);

  final Widget? button;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomDivider(),
        16.verticalSpace,
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: button ?? const ButtonWidget(),
          ),
        ),
        20.verticalSpace,
      ],
    );
  }
}
