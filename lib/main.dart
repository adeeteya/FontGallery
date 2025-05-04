import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_gallery/constants.dart';
import 'package:font_gallery/controllers/settings_controller.dart';
import 'package:font_gallery/views/home.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  await SharedPrefs().initPrefs();
  runApp(const ProviderScope(child: FontGalleryApp()));
}

class FontGalleryApp extends ConsumerWidget {
  const FontGalleryApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDark = ref.watch(
      settingsProvider.select((value) => value.isDark),
    );
    if (isDark) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: kDarkScaffoldColor,
          systemNavigationBarColor: kDarkScaffoldColor,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      );
    } else {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          systemNavigationBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
      );
    }
    return MaterialApp(
      title: 'Font Gallery',
      debugShowCheckedModeBanner: false,
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        splashColor: kLightSplashColor,
        dividerColor: kLightDividerColor,
        primarySwatch: Colors.indigo,
        textTheme: GoogleFonts.notoSansTextTheme(),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: kLightInputFillColor,
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            side: WidgetStateProperty.all(
              const BorderSide(color: Colors.indigo),
            ),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          titleSpacing: 0,
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: kDarkScaffoldColor,
        splashColor: kDarkSplashColor,
        dividerColor: kDarkDividerColor,
        primarySwatch: Colors.indigo,
        textTheme: GoogleFonts.notoSansTextTheme(
          ThemeData(brightness: Brightness.dark).textTheme,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: kDarkInputFillColor,
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            side: WidgetStateProperty.all(
              const BorderSide(color: Colors.indigo),
            ),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          titleSpacing: 0,
          foregroundColor: Color(0xFFE8EAED),
          backgroundColor: Color(0xFF202124),
        ),
      ),
      home: const Home(),
    );
  }
}
