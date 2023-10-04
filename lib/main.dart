import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:triberly/core/_core.dart';
import 'package:triberly/core/services/locale_service/local_notifier.dart';
import 'package:triberly/core/services/theme_service/app_theme.dart';

import 'core/services/_services.dart';
import 'generated/l10n.dart';

void main() {
  HttpOverrides.global = CustomHttpOverrides();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      useInheritedMediaQuery: true,
      minTextAdapt: true,
      builder: (contextAlt, child) {
        return OverlaySupport.global(
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: MaterialApp.router(
              title: "Triberly",
              locale: ref.watch(localeProvider).locale,
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en'), // English
                Locale('es'), // Spanish
              ],
              theme: ref.watch(themeProvider).selectedTheme,
              routerConfig: CustomRoutes.goRouter,
            ),
          ),
        );
      },
    );
  }
}
