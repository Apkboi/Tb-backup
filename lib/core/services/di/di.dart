import 'package:cloudinary/cloudinary.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:logger/logger.dart';
import 'package:triberly/app/auth/data/datasources/user_dao.dart';
import 'package:triberly/app/auth/domain/services/account_imp_service.dart';
import 'package:triberly/app/auth/domain/services/auth_imp_service.dart';
import 'package:triberly/app/auth/external/datasources/user_imp_dao.dart';
import 'package:triberly/app/chat/external/datasources/audio_dao_imp_datasource.dart';
import 'package:triberly/core/services/data/hive/hive_store.dart';
import 'package:triberly/core/services/firebase/crashlytics.dart';
import 'package:triberly/firebase_options.dart';

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
  await initDao();

  await initServices();

  // await initializeCountriesList();
}

Future<void> initCore() async {
  final sessionManager = SessionManager();
  // final objectBox = await BoxManager.create();
  await sessionManager.init();

  // final response = await cloudinary.unsignedUpload(
  //     file: file.path,
  //     uploadPreset: somePreset,
  //     fileBytes: file.readAsBytesSync(),
  //     resourceType: CloudinaryResourceType.image,
  //     folder: cloudinaryCustomFolder,
  //     fileName: 'some-name',
  //     progressCallback: (count, total) {
  //       print('Uploading image from file with progress: $count/$total');
  //     });
  //
  // if (response.isSuccessful) {
  //   print('Get your image from with ${response.secureUrl}');
  // }

  sl.registerLazySingleton<SessionManager>(() => sessionManager);
}

Future<void> initFirebaseServices() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  CrashlyticsService.onCrash();

  await notificationService.initializeNotification();

  await FirebaseMessaging.instance.getInitialMessage();
}

Future<void> initializeDB() async {
  await Hive.initFlutter();
  await HiveBoxes.openAllBox();

  await AudioDaoImpDatasource().init();
}

Future<void> initializeCountriesList() async {
  final util = CountryUtil();
}

Future<void> initDao() async {
  // sl.registerLazySingleton<HiveStore>(() => HiveStore());
  sl.registerLazySingleton<UserImpDao>(() => UserImpDao());
}

Future<void> initServices() async {
  sl.registerLazySingleton<NetworkService>(
      () => NetworkService(baseUrl: UrlConfig.coreBaseUrl));
  sl.registerLazySingleton<AuthImpService>(() => AuthImpService(sl()));
  sl.registerLazySingleton<AccountImpService>(() => AccountImpService(sl()));
}
