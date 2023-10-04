import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:logger/logger.dart';
import 'package:triberly/core/services/firebase/crashlytics.dart';

import '../../_core.dart';
import '../data/hive/hive_manager.dart';
import '../data/session_manager.dart';
import '../firebase/notifiactions.dart';
import '../network/network_service.dart';
import '../network/url_config.dart';

/// Creating a singleton instance of GetIt.
final sl = GetIt.instance;

///LazySingleton Logger variable
final logger = Logger();

Future<void> initializeApp({required Environment environment}) async {
  ///Initialize services here
  ///
  await initFirebaseServices();
  await initCore();
  await initializeDB();
  await initServices();
  await initDao();

  // await initializeCountriesList();
}

Future<void> initCore() async {
  final sessionManager = SessionManager();
  // final objectBox = await BoxManager.create();
  await sessionManager.init();

  sl.registerLazySingleton<SessionManager>(() => sessionManager);
}

Future<void> initFirebaseServices() async {
  await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
      );

  CrashlyticsService.onCrash();

  await notificationService.initializeNotification();

  await FirebaseMessaging.instance.getInitialMessage();
}

Future<void> initializeDB() async {
  await Hive.initFlutter();
  await HiveBoxes.openAllBox();
}

Future<void> initializeCountriesList() async {
  final util = CountryUtil();
}

Future<void> initDao() async {
  // sl.registerLazySingleton<HiveStore>(() => HiveStore());
  // sl.registerLazySingleton<UserDatasource>(() => UserDatasource());
}

Future<void> initServices() async {
  sl.registerLazySingleton<NetworkService>(
      () => NetworkService(baseUrl: UrlConfig.coreBaseUrl));
}
