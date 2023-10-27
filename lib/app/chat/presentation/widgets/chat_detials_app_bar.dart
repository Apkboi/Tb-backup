import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triberly/app/chat/presentation/widgets/chat_bottom_action_bar.dart';
import 'package:triberly/core/_core.dart';

class ChatDetailsAppbar extends StatelessWidget implements PreferredSizeWidget {
  const ChatDetailsAppbar({
    super.key,
    required this.name,
  });

  final String name;
  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: '',
      titleWidget: Column(
        children: [
          TextView(
            text: name,
            color: Pallets.maybeBlack,
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
          5.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.circle,
                size: 10,
              ),
              8.horizontalSpace,
              TextView(
                text: 'Online',
                color: Pallets.primary,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ],
          )
        ],
      ),
      trailing: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            PopupMenuButton<int>(
              child: ImageWidget(
                imageUrl: Assets.svgsCall,
                size: 24,
              ),
              itemBuilder: (context) => [
                // popupmenu item 1
                PopupMenuItem(
                  value: 1,
                  child: Row(
                    children: [
                      Icon(Icons.call),
                      8.horizontalSpace,
                      TextView(
                        text: 'Voice Call',
                      )
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 1,
                  child: Row(
                    children: [
                      Icon(Icons.camera_alt),
                      8.horizontalSpace,
                      TextView(
                        text: 'Video Call',
                      )
                    ],
                  ),
                ),
              ],
              offset: Offset(0, 30),
              // color: Colors.grey,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(4.0),
                ),
              ),
            ),
            10.horizontalSpace,
            PopupMenuButton<int>(
              child: ImageWidget(imageUrl: Assets.svgsMore),
              itemBuilder: (context) => [
                // popupmenu item 1
                PopupMenuItem(
                  value: 1,
                  child: Row(
                    children: [
                      ImageWidget(imageUrl: Assets.svgsSearchNormal, size: 20),
                      8.horizontalSpace,
                      TextView(
                        text: 'Search conversation',
                      )
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 2,
                  child: Row(
                    children: [
                      ImageWidget(imageUrl: Assets.svgsBlock, size: 20),
                      8.horizontalSpace,
                      TextView(
                        text: 'Block',
                      )
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 3,
                  child: Row(
                    children: [
                      ImageWidget(imageUrl: Assets.svgsFlag, size: 20),
                      8.horizontalSpace,
                      TextView(
                        text: 'Report',
                      )
                    ],
                  ),
                ),
              ],
              offset: Offset(0, 30),
              // color: Colors.grey,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(4.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>
      const Size.fromHeight(kBottomNavigationBarHeight + 10);
}
