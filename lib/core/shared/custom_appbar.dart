import 'package:flutter/material.dart';
import 'package:triberly/core/constants/package_exports.dart';
import 'package:triberly/core/constants/pallets.dart';
import 'package:triberly/generated/assets.dart';

import '../_core.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.trailing,
    this.leading,
    this.titleWidget,
    this.color,
  });

  final String title;
  final Widget? trailing;
  final Color? color;
  final Widget? titleWidget;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 0.0,
      ),
      child: AppBar(
        centerTitle: true,
        // leadingWidth: 30,
        leading: leading ??
            (ModalRoute.of(context)?.canPop ?? false
                ? InkWell(
                    radius: 20,
                    onTap: () {
                      context.pop();
                    },
                    child: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Pallets.maybeBlack,
                      opticalSize: 24,
                      size: 24,
                    ),

                    // const ImageWidget(
                    //   imageUrl: Assets.svgsBackIcon,
                    //   fit: BoxFit.scaleDown,
                    // ),
                  )
                : null),
        title: titleWidget ??
            TextView(
              text: title,
              color: Pallets.maybeBlack,
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
        actions: trailing != null ? [trailing!] : null,
        elevation: 0,
        backgroundColor: color ?? Colors.white,
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>
      const Size.fromHeight(kBottomNavigationBarHeight + 10);
}
