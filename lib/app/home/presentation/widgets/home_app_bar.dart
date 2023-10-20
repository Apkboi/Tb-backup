import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:triberly/app/base/presentation/pages/base/base_page.dart';
import 'package:triberly/app/home/presentation/widgets/filter_widget.dart';
import 'package:triberly/core/_core.dart';
import 'package:triberly/generated/l10n.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      titleWidget: ImageWidget(
        imageUrl: Assets.pngsHomeAppbarTriberly,
        width: 92.w,
        height: 39.h,
      ),
      leading: InkWell(
        onTap: () {
          baseScaffoldKey.currentState?.openDrawer();
        },
        child: ImageWidget(
          imageUrl: Assets.svgsMenuIcon,
          size: 24.w,
          fit: BoxFit.scaleDown,
        ),
      ),
      trailing: Row(
        children: [
          InkWell(
            onTap: () {
              CustomDialogs.showBottomSheet(
                context,
                FilterWidget(),
              );
            },
            child: ImageWidget(
              imageUrl: Assets.svgsFilterIcon,
              size: 24.w,
            ),
          ),
          24.horizontalSpace,
          InkWell(
            onTap: () {
              context.pushNamed(PageUrl.notificationsPage);
            },
            child: ImageWidget(
              imageUrl: Assets.svgsNotification,
              size: 24.w,
            ),
          ),
          20.horizontalSpace,
        ],
      ),
      title: S.of(context).triberly,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>
      const Size.fromHeight(kBottomNavigationBarHeight + 10);
}
