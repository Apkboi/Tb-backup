import 'package:cloudinary/cloudinary.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:logger/logger.dart';
import 'package:triberly/app/auth/data/datasources/user_dao.dart';
import 'package:triberly/app/auth/domain/services/account_imp_service.dart';
import 'package:triberly/app/auth/domain/services/auth_imp_service.dart';
import 'package:triberly/app/auth/external/datasources/user_imp_dao.dart';
import 'package:triberly/app/chat/domain/services/chat_imp_service.dart';
import 'package:triberly/app/chat/external/datasources/audio_dao_imp_datasource.dart';
import 'package:triberly/core/services/data/hive/hive_store.dart';
import 'package:triberly/core/services/firebase/crashlytics.dart';
import 'package:triberly/core/services/location_service/location_service.dart';
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
  UrlConfig.environment = environment;
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

  sl.registerLazySingleton<SessionManager>(() => sessionManager);
}

Future<void> initFirebaseServices() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  CrashlyticsService.onCrash();

  await notificationService.initializeNotification();
  FirebaseDatabase.instance.setPersistenceEnabled(true);
  await FirebaseMessaging.instance.getInitialMessage();
  signMessageUser();
}

void signMessageUser() async {
  try {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: UrlConfig.messageUserEmail,
      password: UrlConfig.messageUserPassKey,
    );

    logger.wtf(credential.user?.email);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      logger.e('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      logger.e('Wrong password provided for that user.');
    }
  }
}

Future<void> initializeDB() async {
  await Hive.initFlutter();
  await HiveBoxes.openAllBox();

  await AudioDaoImpDatasource().init();
}

Future<void> initializeCountriesList() async {
  // final util = CountryUtil();
}

Future<void> initDao() async {
  // sl.registerLazySingleton<HiveStore>(() => HiveStore());
  sl.registerLazySingleton<UserImpDao>(() => UserImpDao());
}

Future<void> initServices() async {
  sl.registerLazySingleton<NetworkService>(
      () => NetworkService(baseUrl: UrlConfig.coreBaseUrl));
  sl.registerLazySingleton<LocationService>(() => LocationService());
  sl.registerLazySingleton<AuthImpService>(() => AuthImpService(sl()));
  sl.registerLazySingleton<ChatImpService>(() => ChatImpService(sl()));
  sl.registerLazySingleton<AccountImpService>(() => AccountImpService(sl()));
}
