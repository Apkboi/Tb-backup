// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
// import 'package:package_info_plus/package_info_plus.dart';
//
// import '../di/di.dart';
//
// typedef OnUriCallBack = Function(Uri uri);
//
// class DynamicLinksService {
//   static FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
//   static int androidMinimumVersion = 20;
//   static String iosMinimumVersion = '1.0.0';
//   static String appStoreId = '6444213009';
//   static String androidPackageName = 'com.kusnap.kusnapapp';
//   static String iosPackageName = 'com.kusnap.kusnapapp';
//   static String testImage =
//       'https://res.cloudinary.com/dxfwzjz4k/image/upload/v1671998865/sample.jpg';
//
//   static Future<String> createDynamicLink({
//     required String parameter,
//     required String path,
//     String? profileImage,
//   }) async {
//     PackageInfo packageInfo = await PackageInfo.fromPlatform();
//     String uriPrefix = "https://kusnap.page.link";
//     final DynamicLinkParameters parameters = DynamicLinkParameters(
//       uriPrefix: uriPrefix,
//       link: Uri.parse('https://kusnap.page.link/$path?path_id=$parameter'),
//       androidParameters: AndroidParameters(
//         packageName: androidPackageName,
//         minimumVersion: androidMinimumVersion,
//       ),
//       iosParameters: IOSParameters(
//         bundleId: iosPackageName,
//         minimumVersion: iosMinimumVersion,
//         appStoreId: appStoreId,
//       ),
//       socialMetaTagParameters: SocialMetaTagParameters(
//           title: 'Kusnap',
//           description: '',
//           imageUrl: Uri.tryParse(profileImage ?? testImage)),
//     );
//     //
//     final ShortDynamicLink shortDynamicLink =
//         await dynamicLinks.buildShortLink(parameters);
//     final Uri shortUrl = shortDynamicLink.shortUrl;
//
//     // final link = await dynamicLinks.buildShortLink(parameters);
//
//     logger.i(shortUrl.toString());
//
//     return shortUrl.toString();
//   }
//
//   static void initDynamicLinks({required OnUriCallBack onUriCallBack}) async {
//     dynamicLinks.onLink
//         .listen((dynamicLinkData) =>
//             _handleDynamicLink(dynamicLinkData, onUriCallBack))
//         .onError((error) {});
//   }
//
//   static _handleDynamicLink(
//       PendingDynamicLinkData data, OnUriCallBack onUriCallBack) async {
//     final Uri deepLink = data.link;
//     if (deepLink == null) {
//       return;
//     }
//     onUriCallBack(deepLink);
//   }
// }
