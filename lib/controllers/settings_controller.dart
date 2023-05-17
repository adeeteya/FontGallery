import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_gallery/constants.dart';
import 'package:font_gallery/models/settings_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late final SharedPreferences prefs;

  Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }
}

final settingsProvider = NotifierProvider<SettingsController, SettingsModel>(
    () => SettingsController());

class SettingsController extends Notifier<SettingsModel> {
  @override
  SettingsModel build() {
    return SettingsModel(
      SharedPrefs.prefs.getBool("isDarkMode") ??
          PlatformDispatcher.instance.platformBrightness == Brightness.dark,
      kDefaultText,
      null,
      null,
    );
  }

  Future<void> switchTheme() async {
    state = state.copyWith(isDark: !state.isDark);
    await SharedPrefs.prefs.setBool("isDarkMode", state.isDark);
  }

  void changeDisplayText(String newText) {
    if (newText.isEmpty) {
      state = state.copyWith(displayText: kDefaultText);
    } else {
      state = state.copyWith(displayText: newText);
    }
  }
}
