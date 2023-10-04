// import 'dart:io';
//
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';
//
// import '../../lib.dart';
//
// class FirebaseAnalyticsService {
//   final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
//   String? _deviceName;
//   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//
//   FirebaseAnalyticsObserver appAnalyticsObserver() => FirebaseAnalyticsObserver(
//       analytics: _analytics,
//       onError: (e) {
//         logger.e(e.details);
//       });
//
//   FirebaseAnalyticsService() {
//     _getDeviceName();
//   }
//
//   void addEvent({required name, Map<String, Object>? parameters}) {
//     FirebaseAnalytics.instance.logEvent(name: name, parameters: {
//       ...?parameters,
//       "date": DateTime.now().toString(),
//       "deviceOS": Platform.isAndroid ? "Android" : "iOS",
//       "deviceName": _deviceName
//     });
//   }
//
//   void _getDeviceName() {
//     if (Platform.isAndroid) {
//       deviceInfo.androidInfo.then((value) => _deviceName = value.model);
//     } else {
//       deviceInfo.iosInfo.then((value) => _deviceName = value.utsname.machine);
//     }
//   }
//
//   get instance => _analytics;
//
//   Future logLogin() async {
//     await _analytics.logLogin(loginMethod: 'email and password');
//   }
//
//   Future logRemoveFromCart() async {
//     await _analytics.logRemoveFromCart();
//   }
//
//   Future logViewCart() async {
//     await _analytics.logViewCart();
//   }
//
//   Future logBeginCheckout() async {
//     await _analytics.logBeginCheckout();
//   }
//
//   Future logPurchase(AnalyticsEventItem item, List<String> items) async {
//     await _analytics.logEvent(name: 'successful_purchase', parameters: {
//       "items": items,
//       "item_id": item.itemId,
//       "item_category": item.itemCategory,
//       "currency": 'NGN',
//       "price": item.price,
//     });
//   }
//
//   Future logSearch(String term) async {
//     await _analytics.logSearch(searchTerm: term);
//   }
//
//   Future logAddToCart(AnalyticsEventItem item, {double? value}) async {
//     // await _analytics.logAddToCart(
//     //   items: [AnalyticsEventItem(itemName: 'james',itemId: '1234')],
//     //   currency: 'NGN',
//     //   value: value,
//     // );
//     await _analytics.logEvent(name: 'Add_to_cart', parameters: {
//       "item_name": item.itemName,
//       "item_id": item.itemId,
//       "item_category": item.itemCategory,
//       "currency": 'NGN',
//       "price": value,
//     });
//   }
//
//   Future logSignup() async {
//     await _analytics.logSignUp(signUpMethod: 'email and password');
//   }
//
//   Future setUserProperties({required String? userId}) async {
//     await _analytics.setUserId(id: userId);
//   }
//
//   Future logPayment(String method) async {
//     await _analytics
//         .logEvent(name: 'made_payment', parameters: {'payment_method': method});
//   }
//
//   Future loginAttempt(String status) async {
//     await _analytics
//         .logEvent(name: 'Login Attempt', parameters: {'status': status});
//   }
//
//   Future forgotPassword() async {
//     await _analytics.logEvent(
//         name: 'Forgot password',
//         parameters: {'status': 'Forgot password call'});
//   }
// }
