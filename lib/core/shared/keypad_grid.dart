import 'package:flutter/material.dart';
import 'package:triberly/core/_core.dart';
import 'package:triberly/core/constants/pallets.dart';

import 'image_widget.dart';

class KeyPadGrid extends StatelessWidget {
  const KeyPadGrid(
      {Key? key,
      required this.controller,
      this.count = 4,
      this.hasBio = false,
      this.onBioTap})
      : super(key: key);

  final TextEditingController controller;
  final int count;
  final bool hasBio;

  final VoidCallback? onBioTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        SizedBox(
          height: size.height * 0.09,
          child: Row(
            children: [
              buildKeyPadButton(1),
              buildKeyPadButton(2),
              buildKeyPadButton(3),
            ],
          ),
        ),
        SizedBox(
          height: size.height * 0.09,
          child: Row(
            children: [
              buildKeyPadButton(4),
              buildKeyPadButton(5),
              buildKeyPadButton(6),
            ],
          ),
        ),
        SizedBox(
          height: size.height * 0.09,
          child: Row(
            children: [
              buildKeyPadButton(7),
              buildKeyPadButton(8),
              buildKeyPadButton(9),
            ],
          ),
        ),
        SizedBox(
          height: size.height * 0.09,
          child: Row(
            children: [
              hasBio ? buildBioButton() : const Expanded(child: SizedBox()),
              buildKeyPadButton(0),
              buildBAckSpace(),
            ],
          ),
        ),
      ],
    );
  }

  buildBioButton() {
    return Expanded(
      child: GestureDetector(
        onTap: onBioTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 70,
              minHeight: 70,
            ),
            decoration: BoxDecoration(
              // shape: BoxShape.circle,
              borderRadius: BorderRadius.circular(14),
              color: Pallets.borderGrey,
            ),
            child: const Center(
              child: ImageWidget(imageUrl: ' Assets.svgsFingerprintScan'),
            ),
          ),
        ),
      ),
    );
  }

  buildBAckSpace() {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (controller.text.isNotEmpty) {
            controller.text =
                controller.text.substring(0, controller.text.length - 1);
            controller.selection =
                TextSelection.collapsed(offset: controller.text.length);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              constraints: const BoxConstraints(
                maxWidth: 70,
                minHeight: 70,
              ),
              decoration: BoxDecoration(
                // shape: BoxShape.circle,
                borderRadius: BorderRadius.circular(14),
                color: Pallets.borderGrey,
              ),
              child: Center(
                child: Icon(
                  Icons.backspace_outlined,
                  size: 23.sp,
                  color: Color(0xff000000),
                ),
              )),
        ),
      ),
    );
  }

  buildKeyPadButton(int value) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (controller.text.length >= count) return;

          controller.text = "${controller.text}$value";
          controller.selection =
              TextSelection.collapsed(offset: controller.text.length);
        },
        child: Container(
          margin: const EdgeInsets.all(8.0),
          constraints: const BoxConstraints(
            maxWidth: 70,
            minHeight: 70,
          ),
          decoration: BoxDecoration(
            // shape: BoxShape.circle,
            borderRadius: BorderRadius.circular(14),
            color: Pallets.borderGrey,
          ),
          child: Center(
            child: TextView(
              text: value.toString(),
              color: Color(0xff000000),
              fontWeight: FontWeight.w600,
              fontSize: 30.0,
            ),
          ),
        ),
      ),
    );
  }
}
