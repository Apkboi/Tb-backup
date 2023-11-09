import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:triberly/app/auth/presentation/pages/location_access/location_access_page.dart';
import 'package:triberly/app/auth/presentation/pages/onboarding/onboarding_page.dart';
import 'package:triberly/app/auth/presentation/pages/otp/otp_page.dart';
import 'package:triberly/app/auth/presentation/pages/password_reset/complete_password_reset_page.dart';
import 'package:triberly/app/auth/presentation/pages/password_reset/password_reset_page.dart';
import 'package:triberly/app/auth/presentation/pages/selfie_verification/selfie_verification_page.dart';
import 'package:triberly/app/auth/presentation/pages/sign_in/sign_in_page.dart';
import 'package:triberly/app/auth/presentation/pages/sign_up/sign_up_page.dart';
import 'package:triberly/app/auth/presentation/pages/upload_profile_photo/upload_profile_photo_page.dart';
import 'package:triberly/app/base/presentation/pages/base/base_page.dart';
import 'package:triberly/app/base/presentation/pages/splash/splash_page.dart';
import 'package:triberly/app/chat/presentation/pages/chat/chat_page.dart';
import 'package:triberly/app/chat/presentation/pages/chat_details/chat_details_page.dart';
import 'package:triberly/app/community/presentation/pages/community/community_page.dart';
import 'package:triberly/app/home/presentation/pages/home/home_page.dart';
import 'package:triberly/app/notifications/presentation/pages/notifications/notifications_page.dart';
import 'package:triberly/app/profile/presentation/pages/help_center/faq_page.dart';
import 'package:triberly/app/profile/presentation/pages/help_center/help_center_page.dart';
import 'package:triberly/app/profile/presentation/pages/help_center/report_issue_page.dart';
import 'package:triberly/app/profile/presentation/pages/profile/profile_page.dart';
import 'package:triberly/app/profile/presentation/pages/profile_details/profile_details_page.dart';
import 'package:triberly/app/profile/presentation/pages/security/change_password_page.dart';
import 'package:triberly/app/profile/presentation/pages/security/security_page.dart';
import 'package:triberly/app/profile/presentation/pages/security/suspend_account_page.dart';
import 'package:triberly/app/profile/presentation/pages/setup_profile/setup_profile_intro_page.dart';
import 'package:triberly/app/profile/presentation/pages/setup_profile/setup_profile_page.dart';
import 'package:triberly/app/profile/presentation/pages/setup_profile/upload_photos_page.dart';
import 'package:triberly/core/constants/enums/otp_type.dart';
import 'package:triberly/core/navigation/path_params.dart';
import 'package:triberly/core/navigation/route_url.dart';

final rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'rootNavigator');
final _shellNavigatorAKey = GlobalKey<NavigatorState>(debugLabel: 'shellA');
final _shellNavigatorBKey = GlobalKey<NavigatorState>(debugLabel: 'shellB');
final _shellNavigatorCKey = GlobalKey<NavigatorState>(debugLabel: 'shellC');
final _shellNavigatorDKey = GlobalKey<NavigatorState>(debugLabel: 'shellD');

class CustomRoutes {
  static final goRouter = GoRouter(
    initialLocation: '/splash',
    // initialLocation: '/profile/setupProfileIntroPage/setupProfilePage',
    navigatorKey: rootNavigatorKey,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/splash',
        name: PageUrl.splash,
        builder: (context, state) => SplashPage(),
      ),
      GoRoute(
        path: '/signUp',
        name: PageUrl.signUp,
        builder: (context, state) => SignUpPage(),
      ),
      GoRoute(
        path: '/signIn',
        name: PageUrl.signIn,
        builder: (context, state) => SignInPage(
          email: state.uri.queryParameters[PathParam.email] ?? '',
        ),
      ),
      GoRoute(
        path: '/otpPage',
        name: PageUrl.otpPage,
        builder: (context, state) => OtpPage(
          otpType: state.uri.queryParameters[PathParam.otpType] ??
              OtpType.passwordReset.value,
          phoneNumber: state.uri.queryParameters[PathParam.phoneNumber],
          email: state.uri.queryParameters[PathParam.email],
        ),
      ),
      GoRoute(
        path: '/locationAccessPage',
        name: PageUrl.locationAccessPage,
        builder: (context, state) => const LocationAccessPage(),
      ),
      GoRoute(
        path: '/passwordReset',
        name: PageUrl.passwordReset,
        builder: (context, state) => const PasswordResetPage(),
      ),
      GoRoute(
        path: '/completePasswordReset',
        name: PageUrl.completePasswordReset,
        builder: (context, state) => const CompletePasswordResetPage(),
      ),
      GoRoute(
        path: '/uploadProfilePhoto',
        name: PageUrl.uploadProfilePhoto,
        builder: (context, state) => const UploadProfilePhotoPage(),
      ),
      GoRoute(
        path: '/selfieVerificationPage',
        name: PageUrl.selfieVerificationPage,
        builder: (context, state) => SelfieVerificationPage(
          profilePhoto: state.uri.queryParameters[PathParam.profilePhoto] ?? '',
        ),
      ),
      GoRoute(
        path: '/onBoardingPage',
        name: PageUrl.onBoardingPage,
        builder: (context, state) => const OnBoardingPage(),
      ),
      GoRoute(
        path: '/notificationsPage',
        name: PageUrl.notificationsPage,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const NotificationsPage(),
      ),
      GoRoute(
        path: '/setupProfileIntroPage',
        name: PageUrl.setupProfileIntroPage,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => SetupProfileIntroPage(),
        routes: [
          GoRoute(
            path: 'uploadPhotos',
            name: PageUrl.uploadPhotos,
            parentNavigatorKey: rootNavigatorKey,
            builder: (context, state) => UploadPhotosPage(),
          ),
          GoRoute(
            path: 'setupProfilePage',
            name: PageUrl.setupProfilePage,
            parentNavigatorKey: rootNavigatorKey,
            builder: (context, state) => SetupProfilePage(),
          ),
        ],
      ),
      StatefulShellRoute.indexedStack(

        builder: (context, state, navigationShell) {
          return BasePage(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _shellNavigatorAKey,
            routes: [
              GoRoute(
                path: '/home',
                name: PageUrl.home,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: HomePage(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorBKey,

            routes: [
              GoRoute(
                path: '/community',
                name: PageUrl.community,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: CommunityPage(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorCKey,
            routes: [
              GoRoute(
                path: '/chat',
                name: PageUrl.chat,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: ChatPage(),
                ),
                routes: [
                  GoRoute(
                    path: 'details',
                    name: PageUrl.chatDetails,
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) => ChatDetailsPage(
                      chatId: state.uri.queryParameters[PathParam.chatId] ?? '',
                      // userId: state.uri.queryParameters[PathParam.userId] ?? '',
                      userName: state.uri.queryParameters[PathParam.userName] ?? '',
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorDKey,
            routes: [
              GoRoute(
                path: '/profile',
                name: PageUrl.profile,
                pageBuilder: (context, state) => const NoTransitionPage(

                  child: ProfilePage(),
                ),
                routes: [
                  GoRoute(
                    path: 'details',
                    name: PageUrl.profileDetails,
                    builder: (context, state) => ProfileDetailsPage(
                      userId: state.uri.queryParameters[PathParam.userId] ?? '',
                    ),
                  ),
                  GoRoute(
                    path: 'security',
                    name: PageUrl.security,
                    builder: (context, state) => const SecurityPage(),
                    routes: [
                      GoRoute(
                        path: 'suspendAccountPage',
                        name: PageUrl.suspendAccount,
                        builder: (context, state) => const SuspendAccountPage(),

                      ),
                      GoRoute(
                        path: 'changePassword',
                        name: PageUrl.changePassword,
                        builder: (context, state) => const ChangePasswordPage(),

                      ),
                    ]

                  ),

                  GoRoute(
                      path: 'helpCenter',
                      name: PageUrl.helpCenter,
                      builder: (context, state) => const HelpCenterPage(),
                      routes: [
                        GoRoute(
                          path: 'reportIssue',
                          name: PageUrl.reportIssue,
                          builder: (context, state) => const ReportIssuePage(),

                        ),
                        GoRoute(
                          path: 'faq',
                          name: PageUrl.faq,
                          builder: (context, state) => const FaqPage(),

                        ),
                      ]

                  ),


                  // GoRoute(
                  //   path: 'setupProfilePage',
                  //   name: PageUrl.setupProfilePage,
                  //   parentNavigatorKey: rootNavigatorKey,
                  //   builder: (context, state) => SetupProfilePage(),
                  // ),

                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
