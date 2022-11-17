import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController {
  static final ValueNotifier<bool> isDarkMode = ValueNotifier(false);

  Future switchTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isDarkMode.value = !isDarkMode.value;
    await prefs.setBool("isDarkMode", isDarkMode.value);
  }

  Future getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isDarkMode.value = prefs.getBool("isDarkMode") ?? false;
  }
}
