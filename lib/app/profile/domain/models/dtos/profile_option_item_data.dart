import 'package:flutter/material.dart';
import 'package:triberly/core/_core.dart';

class ProfileOptionItemData {
  final String leadingImage;
  final Widget? trailing;
  final String title;
  final Function(BuildContext)
      onTap; // Modify the onTap to include BuildContext
  final bool hasArrow;

  ProfileOptionItemData({
    required this.leadingImage,
    this.trailing,
    required this.title,
    required this.onTap,
    required this.hasArrow,
  });

  static List<ProfileOptionItemData> profileOptions = [
    ProfileOptionItemData(
      leadingImage: Assets.svgsHostFriend,
      title: 'Become a host friend',
      onTap: (BuildContext context) {
        // Define the action for "Become a host friend"
      },
      hasArrow: false,
    ),
    ProfileOptionItemData(
      leadingImage: Assets.svgsServiceVendor,
      title: 'Become a service vendor',
      onTap: (BuildContext context) {
        // Define the action for "Become a service vendor"
      },
      hasArrow: false,
    ),
    ProfileOptionItemData(
      leadingImage: Assets.svgsCard,
      title: 'Cards & Subscriptions',
      onTap: (BuildContext context) {
        // Define the action for "Cards & Subscriptions"
      },
      hasArrow: true,
    ),
    ProfileOptionItemData(
      leadingImage: Assets.svgsLock,
      title: 'Security',
      onTap: (BuildContext context) {
        context.pushNamed(
          PageUrl.security,
        );
      },
      hasArrow: true,
    ),
    ProfileOptionItemData(
      leadingImage: Assets.svgsLanguage,
      title: 'Language',
      trailing: const Row(
        children: [
          TextView(
            text: "English(UK)  ",
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: Pallets.grey),
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 20,
            color: Pallets.grey,
          )
        ],
      ),
      onTap: (BuildContext context) {
        // Define the action for "Language"
      },
      hasArrow: false,
    ),
    ProfileOptionItemData(
      leadingImage: Assets.svgsCall,
      title: 'Help Center',
      onTap: (BuildContext context) {
        context.pushNamed(
          PageUrl.helpCenter,
        );
      },
      hasArrow: true,
    ),
    ProfileOptionItemData(
      leadingImage: Assets.svgsClipboard,
      title: 'Privacy Statement',
      onTap: (BuildContext context) {
        // Define the action for "Privacy Statement"
      },
      hasArrow: true,
    ),
  ];
}
