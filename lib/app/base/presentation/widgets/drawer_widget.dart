//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:triberly/app/auth/external/datasources/user_imp_dao.dart';
// import 'package:triberly/core/_core.dart';
// import 'package:triberly/core/services/_services.dart';
// import 'package:triberly/generated/assets.dart';
//
// import '../../../../../core/constants/package_exports.dart';
//
// class DrawerWidget extends StatefulWidget {
//   DrawerWidget({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   _DrawerWidgetState createState() => _DrawerWidgetState();
// }
//
// class _DrawerWidgetState extends State<DrawerWidget>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _offsetAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 800),
//       vsync: this,
//     );
//
//     _offsetAnimation = Tween<double>(begin: -0.0, end: 0.0).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: Curves.elasticOut,
//         reverseCurve: Curves.elasticIn,
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }
//
//   final user = sl<UserImpDao>().user;
//
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         // Important: Remove any padding from the ListView.
//         padding: EdgeInsets.symmetric(horizontal: 12.w),
//         children: [
//           65.verticalSpace,
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               InkWell(
//                 onTap: () => context.pop(),
//                 child: Container(
//                   width: 52.w,
//                   height: 52.w,
//                   decoration: BoxDecoration(
//                     color: Pallets.primaryLight,
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(
//                     CupertinoIcons.xmark,
//                     size: 20,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           32.verticalSpace,
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               ImageWidget(
//                 imageUrl: user?.profileImage ?? '',
//                 size: 48.dm,
//                 borderRadius: BorderRadius.circular(24),
//               ),
//               12.horizontalSpace,
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     TextView(
//                       text:
//                       "${user?.lastName ?? 'N/A'} ${user?.firstName ?? 'N/A'} ",
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                     ),
//                     TextView(
//                       text: '${user?.email ?? 'N/A'}',
//                       fontSize: 12,
//                       color: Pallets.grey,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           44.verticalSpace,
//           DrawerTile(
//             title: 'My Profile',
//             icon: Assets.svgsProfileDrawer,
//             index: 0,
//             trailing: Container(
//               decoration: BoxDecoration(
//                 color: Pallets.white,
//                 borderRadius: BorderRadius.circular(2),
//               ),
//               width: 20.w,
//               alignment: Alignment.center,
//               height: 20.w,
//               child: TextView(
//                 text: '2',
//                 color: Pallets.primary,
//               ),
//             ),
//             onTap: () {},
//           ),
//           DrawerTile(
//             index: 1,
//             title: 'My Tribers',
//             icon: Assets.svgsCategory,
//           ),
//           DrawerTile(
//             index: 2,
//             title: 'My Tribers',
//             icon: Assets.svgsCategory,
//           ),
//           DrawerTile(
//             index: 3,
//             title: 'Community Boards',
//             icon: Assets.svgsCategory,
//           ),
//           DrawerTile(
//             index: 4,
//             title: 'Find a Host',
//             icon: Assets.svgsGlobalSearch,
//           ),
//           DrawerTile(
//             index: 5,
//             title: 'Find a Service',
//             icon: Assets.svgsSearchStatus,
//           ),
//           DrawerTile(
//             index: 6,
//             title: 'Refer a Friend',
//             icon: Assets.svgsProfile2user,
//           ),
//           DrawerTile(
//             index: 7,
//             title: 'Upgrade my Account',
//             icon: Assets.svgsCrown,
//           ),
//           DrawerTile(
//             index: 8,
//             title: 'Contact Us',
//             icon: Assets.svgsCall,
//           ),
//           DrawerTile(
//             index: 9,
//             title: 'Log Out',
//             isLogout: true,
//             icon: Assets.svgsLogout,
//             onTap: () {
//               _list.clear();
//               SessionManager.instance.logOut();
//               context.goNamed(PageUrl.signIn);
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
