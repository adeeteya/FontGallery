import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_gallery/constants.dart';
import 'package:font_gallery/models/font_model.dart';
import 'package:font_gallery/models/settings_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late final SharedPreferences prefs;

  Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }
}

final settingsProvider = NotifierProvider<SettingsController, SettingsModel>(
  SettingsController.new,
);

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

  bool lastSelectedFirstPosition = true;

  Future<void> switchTheme() async {
    state = state.copyWith(
      state.selectedFontModel,
      state.selectedFontModel2,
      isDark: !state.isDark,
    );
    await SharedPrefs.prefs.setBool("isDarkMode", state.isDark);
  }

  void changeDisplayText(String newText) {
    if (newText.isEmpty) {
      state = state.copyWith(
        state.selectedFontModel,
        state.selectedFontModel2,
        displayText: kDefaultText,
      );
    } else {
      state = state.copyWith(
        state.selectedFontModel,
        state.selectedFontModel2,
        displayText: newText,
      );
    }
  }

  void onFontCardAction(FontModel clickedFontModel) {
    //remove
    if (state.selectedFontModel == clickedFontModel) {
      state = state.copyWith(null, state.selectedFontModel2);
    } else if (state.selectedFontModel2 == clickedFontModel) {
      state = state.copyWith(state.selectedFontModel, null);
    } else {
      //add
      if (state.selectedFontModel == null) {
        state = state.copyWith(clickedFontModel, state.selectedFontModel2);
      } else if (state.selectedFontModel2 == null) {
        state = state.copyWith(state.selectedFontModel, clickedFontModel);
      } else {
        if (lastSelectedFirstPosition) {
          lastSelectedFirstPosition = false;
          state = state.copyWith(clickedFontModel, state.selectedFontModel2);
        } else {
          lastSelectedFirstPosition = true;
          state = state.copyWith(state.selectedFontModel, clickedFontModel);
        }
      }
    }
  }

  bool isFontModelSelected(FontModel fontModel) {
    if (state.selectedFontModel?.name == fontModel.name ||
        state.selectedFontModel2?.name == fontModel.name) {
      return true;
    } else {
      return false;
    }
  }

  void removeSelectedFontModel() {
    state = state.copyWith(null, state.selectedFontModel2);
  }

  void removeSelectedFontModel2() {
    state = state.copyWith(state.selectedFontModel, null);
  }
}
