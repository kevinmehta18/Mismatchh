import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mismatchh/constants/colors.dart';
import 'package:mismatchh/constants/miscellaneous.dart';
import 'package:mismatchh/constants/strings.dart';
import 'package:mismatchh/presentation/provider/dashboard/chat_provider.dart';
import 'package:mismatchh/presentation/provider/dashboard/dashboard_provider.dart';
import 'package:mismatchh/presentation/provider/dashboard/home_provider.dart';
import 'package:mismatchh/presentation/views/onboarding/onboarding_screen.dart';
import 'package:mismatchh/shared_preference/shared_preference.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

import 'constants/themes.dart';
import 'navigation/app_router.dart';
import 'presentation/provider/auth_provider.dart';
import 'presentation/provider/locale_provider.dart';
import 'presentation/provider/theme_provider.dart';
import 'utils/https_override.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );

  await PrefUtils().init();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => ThemeProvider()),
    ChangeNotifierProvider(create: (context) => AuthProvider()),
    ChangeNotifierProvider(create: (context) => DashboardProvider()),
    ChangeNotifierProvider(create: (context) => HomeProvider()),
    ChangeNotifierProvider(create: (context) => ChatProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      config: const ToastificationConfig(animationDuration: kAnimationDuration),
      child: Consumer2<ThemeProvider, LocaleProvider>(
        builder: (BuildContext context, themeProvider, localeProvider,
            Widget? child) {
          return ToastificationWrapper(
            config: const ToastificationConfig(
                animationDuration: kToastAnimationDuration),
            child: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: 'Asset Management',
              routerConfig: router,
              theme: lightTheme,
              themeMode:
                  themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
              darkTheme: darkTheme,
              themeAnimationCurve: Curves.easeIn,
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              locale: localeProvider.locale,
            ),
          );
        },
      ),
    );
  }
}
