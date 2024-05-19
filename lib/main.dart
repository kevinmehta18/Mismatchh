import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mismatchh/constants/colors.dart';
import 'package:mismatchh/constants/miscellaneous.dart';
import 'package:mismatchh/constants/strings.dart';
import 'package:mismatchh/provider/auth_provider.dart';
import 'package:mismatchh/provider/blog_provider.dart';
import 'package:mismatchh/provider/theme_provider.dart';
import 'package:mismatchh/shared_preference/shared_preference.dart';
import 'package:mismatchh/views/onboarding/onboarding_screen.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  await PrefUtils().init();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => AuthProvider()),
    ChangeNotifierProvider(create: (context) => ThemeProvider()),
    ChangeNotifierProvider(create: (context) => BlogProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      config: const ToastificationConfig(animationDuration: kAnimationDuration),
      child: Selector<ThemeProvider,bool>(
        selector: (ctx,themeProvider)=>themeProvider.isDarkMode,
        builder: (BuildContext context, isDarkMode, Widget? child) { 
          return MaterialApp(
          title: appName,
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          theme: ThemeData(
              textTheme:
                  GoogleFonts.josefinSansTextTheme(Typography.blackHelsinki),
              scaffoldBackgroundColor: kWhite,
),
          themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
          darkTheme: ThemeData.dark(
          ).copyWith(
            textTheme: GoogleFonts.josefinSansTextTheme(Typography.whiteHelsinki),
            scaffoldBackgroundColor: kBlack,
          ),
          themeAnimationCurve: Curves.easeIn,
          home: const OnboardingScreen(),
        );
         },
      ),
    );
  }
}
