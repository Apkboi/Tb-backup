//
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
// class DrawerTile extends StatelessWidget {
//   const DrawerTile({
//     super.key,
//     this.selected = false,
//     this.isLogout = false,
//     this.trailing,
//     required this.icon,
//     required this.title,
//     this.onTap,
//     required this.index,
//   });
//
//   final bool selected;
//   final int index;
//   final bool isLogout;
//   final Widget? trailing;
//   final String icon;
//   final String title;
//   final VoidCallback? onTap;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10.0),
//       child: ListTile(
//         minLeadingWidth: 0,
//         leading: ImageWidget(
//           imageUrl: icon,
//           size: 24,
//           color: isLogout
//               ? Pallets.red
//               : _list.contains(index)
//               ? Pallets.white
//               : Pallets.grey,
//         ),
//         trailing: trailing,
//         selected: _list.contains(index),
//         selectedColor: Pallets.white,
//         selectedTileColor: Pallets.primary,
//         title: TextView(
//           text: title,
//           fontSize: 16,
//           color: isLogout
//               ? Pallets.red
//               : _list.contains(index)
//               ? Pallets.white
//               : Pallets.grey,
//           fontWeight: FontWeight.w600,
//         ),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//         onTap: () {
//           _list.clear();
//           _list.add(index);
//           onTap?.call();
//           context.pop();
//         },
//       ),
//     );
//   }
// }
