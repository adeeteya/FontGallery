import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:font_gallery/constants.dart';
import 'package:font_gallery/views/home.dart';
import 'package:font_gallery/controllers/home_controller.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await HomeController().getTheme();
  FlutterNativeSplash.remove();
  runApp(const FontGalleryApp());
}

class FontGalleryApp extends StatelessWidget {
  const FontGalleryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: HomeController.isDarkMode,
      builder: (context, value, _) {
        return MaterialApp(
          title: 'Font Gallery',
          debugShowCheckedModeBanner: false,
          themeMode: (value) ? ThemeMode.dark : ThemeMode.light,
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
                side: MaterialStateProperty.all(
                  const BorderSide(
                    color: Colors.indigo,
                    width: 1.0,
                    style: BorderStyle.solid,
                  ),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
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
                side: MaterialStateProperty.all(
                  const BorderSide(
                    color: Colors.indigo,
                    width: 1.0,
                    style: BorderStyle.solid,
                  ),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
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
      },
    );
  }
}
