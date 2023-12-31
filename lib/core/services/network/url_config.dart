enum Environment { development, staging, qa, production }

class UrlConfig {
  static Environment environment = Environment.staging;

  static const String STAGING_URL = String.fromEnvironment('DEV_BASE_URL');
  static const String PRODUCTION_URL = String.fromEnvironment('PROD_BASE_URL');

  static const String imageBaseUrl = String.fromEnvironment('IMAGE_BASE_URL');
  static const String dojahTestAppId = String.fromEnvironment('DOJAH_APP_ID');
  static const String dojahTestPublicKey =
      String.fromEnvironment('DOJAH_PUBLIC_KEY');
  static const String facePlusTestApiKey =
      String.fromEnvironment('FACE_PLUS_TEST_API_KEY');
  static const String facePlusTestApiSecret =
      String.fromEnvironment('FACE_PLUS_TEST_API_SECRET');

  static const String messageUserEmail =
      String.fromEnvironment('MESSAGE_USER_EMAIL');

  static const String messageUserPassKey =
      String.fromEnvironment('MESSAGE_USER_PASSKEY');

  // static const String facePlusProdApiKey =
  //     String.fromEnvironment('FACE_PLUS_PROD_API_KEY');
  // static const String facePlusProdApiSecret =
  //     String.fromEnvironment('FACE_PLUS_PROD_API_SECRET');

  static final coreBaseUrl =
      environment == Environment.production ? PRODUCTION_URL : STAGING_URL;

  static const String login = '/auth/login';
  static const String me = '/auth/me';

  static String getUser(String userId) => '/auth/user/$userId';
  static const String forgotPassword = '/auth/forgot-password';
  static const String verifyOtp = '/auth/verify-otp';
  static const String register = '/auth/register';
  static const String oauthLogin = '/auth/oauth-login';
  static const String resendOtp = '/auth/resend-otp';

  ///CONFIGS
  ///
  static const String getConfigs = '/general/configs';
  static const String getCountries = '/location/countries?per_page=300';

  ///CONNECTIONS
  static const String searchConnections = '/general/connections/search';
  static const String saveConnection = '/general/connections/save';
  static const String getConnections = '/general/connections';
  static const String addFavorite = '/user/add/favourite';
  static const String addBookmark = '/user/add/bookmark';
  static const String removeFavorite = '/user/remove/favourite';
  static const String removeBookmark = '/user/remove/bookmark';
  static const String checkBookmark = '/user/check/bookmark';
  static const String checkFavorite = '/user/check/favourite';

  ///ACCOUNT
  static const String updateProfile = '/general/account/update';
  static const String updateOtherPhotos = 'general/account/upload-images';
  static const String deleteAccount = 'general/account/deactivate';

  ///Chat
  static const String getChats = '/chats/list';
  static const String initiateChat = 'chats/initiate';
}
