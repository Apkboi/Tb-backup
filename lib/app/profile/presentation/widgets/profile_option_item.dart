import 'package:flutter/material.dart';
import 'package:triberly/core/_core.dart';

class ProfileOptionItem extends StatelessWidget {
  const ProfileOptionItem(
      {Key? key,
      required this.leaadingImage,
      this.trailing,
      required this.tittle,
      required this.onTap,
      required this.hasArrow})
      : super(key: key);
  final String leaadingImage;
  final Widget? trailing;
  final String tittle;
  final VoidCallback onTap;
  final bool hasArrow;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            ImageWidget(
              imageUrl: leaadingImage,
              imageType: ImageWidgetType.asset,
              size: 20,
              fit: BoxFit.cover,
              // color: Pallets.black,
              shape: BoxShape.circle,
            ),
            16.horizontalSpace,
            Expanded(
                child: TextView(
              text: tittle,
              fontWeight: FontWeight.w500,
              fontSize: 17,
            )),
            hasArrow
                ? const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 20,
                    color: Pallets.grey,
                  )
                : trailing != null
                    ? trailing!
                    : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
