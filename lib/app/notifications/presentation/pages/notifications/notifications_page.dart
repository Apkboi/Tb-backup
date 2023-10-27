import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triberly/core/_core.dart';

import 'notifications_controller.dart';

class NotificationsPage extends ConsumerStatefulWidget {
  const NotificationsPage({super.key});

  @override
  ConsumerState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends ConsumerState<NotificationsPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> dialogKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    dialogKey.currentState?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: const CustomAppBar(
        title: 'Notifications',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerRight,
              child: TextView(
                text: 'Mark all as read',
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Pallets.grey,
              ),
            ),
            32.verticalSpace,
            Expanded(
              child: ListView.separated(
                itemCount: 15,
                padding: const EdgeInsets.only(bottom: 45),
                itemBuilder: (context, index) {
                  return const NotificationTile();
                },
                separatorBuilder: (context, index) {
                  return const CustomDivider();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  const NotificationTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0, top: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ImageWidget(
            imageUrl: Assets.pngsMale,
            shape: BoxShape.circle,
            size: 50,
            fit: BoxFit.cover,
          ),
          16.horizontalSpace,
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: TextView(
                        text: 'Matt sent you a connection request',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextView(
                      text: TimeUtil.getTimeAgo(
                        DateTime.now().toString(),
                      ),
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                13.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: ButtonDialog(
                        title: 'Accept',
                      ),
                    ),
                    24.horizontalSpace,
                    const Expanded(
                      child: ButtonDialog(
                        title: 'Dismiss',
                        isInverted: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EmptyNotificationPage extends StatelessWidget {
  const EmptyNotificationPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerRight,
            child: TextView(
              text: 'Mark all as read',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Pallets.grey,
            ),
          ),
          32.verticalSpace,
          const Stack(
            children: [
              ImageWidget(imageUrl: Assets.svgsNotificationBackground),
              Positioned.fill(
                child: ImageWidget(
                  imageUrl: Assets.svgsNotificationBell,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ],
          ),
          const TextView(
            text: 'You don’t have any new notifications',
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}
