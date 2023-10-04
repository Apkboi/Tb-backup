// import 'package:flutter/material.dart';
// import '../_core.dart';
//
// class ConfirmDialog extends StatelessWidget {
//   const ConfirmDialog({
//     super.key,
//     required this.title,
//     this.subtitle,
//     this.onTap,
//     this.buttonTitle,
//   });
//
//   final String title;
//   final String? subtitle;
//   final String? buttonTitle;
//
//   final VoidCallback? onTap;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(24),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           const ImageWidget(
//             imageUrl: Assets.svgsCaution,
//           ),
//           24.verticalSpace,
//           TextView(
//             text: title,
//             fontSize: 24,
//             fontWeight: FontWeight.w700,
//             color: Pallets.primary,
//             textAlign: TextAlign.center,
//           ),
//           if (subtitle != null) 12.verticalSpace,
//           if (subtitle != null)
//             TextView(
//               text: subtitle!,
//               fontSize: 12,
//               fontWeight: FontWeight.w400,
//               color: Pallets.grey2,
//               textAlign: TextAlign.center,
//             ),
//           24.verticalSpace,
//           ButtonWidget(
//             title: buttonTitle ?? 'Proceed to Dashboard',
//             onTap: onTap ??
//                 () {
//                   Pusher.clearAll(context);
//                 },
//           ),
//           24.verticalSpace,
//           TextView(
//             text: 'Cancel',
//             fontSize: 16,
//             fontWeight: FontWeight.w500,
//             decoration: TextDecoration.underline,
//             color: Pallets.primary,
//             textAlign: TextAlign.center,
//             onTap: () {
//               Pusher.back(context);
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
