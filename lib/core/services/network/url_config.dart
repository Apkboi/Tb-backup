enum Environment { development, staging, qa, production }

class UrlConfig {
  static Environment environment = Environment.staging;

  static const String STAGING_URL = String.fromEnvironment('DEV_BASE_URL');
  static const String PRODUCTION_URL = String.fromEnvironment('PROD_BASE_URL');

  static const String imageBaseUrl = String.fromEnvironment('IMAGE_BASE_URL');
  static const String dojahTestAppId = String.fromEnvironment('DOJAH_APP_ID');
  static const String dojahTestPublicKey =
      String.fromEnvironment('DOJAH_PUBLIC_KEY');

  static const String intercomAppID = String.fromEnvironment('INTERCOM_APP_ID');
  static const String intercomAndroidApiKey =
      String.fromEnvironment('INTERCOM_ANDROID_API_KEY');
  static const String intercomIOSApiKey =
      String.fromEnvironment('INTERCOM_IOS_API_KEY');

  static final coreBaseUrl =
      environment == Environment.production ? PRODUCTION_URL : STAGING_URL;

  static const String login = '/auth/login';
  static const String loginPin = '/auth/login/pin';
  static const String register = '/auth/register';
}
