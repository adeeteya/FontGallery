import 'package:flutter/material.dart';
import 'package:font_gallery/controllers/home_controller.dart';
import 'package:lottie/lottie.dart';

class ThemeModeToggle extends StatefulWidget {
  const ThemeModeToggle({Key? key}) : super(key: key);

  @override
  State<ThemeModeToggle> createState() => _ThemeModeToggleState();
}

class _ThemeModeToggleState extends State<ThemeModeToggle>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late bool isDark;
  @override
  void initState() {
    animationController = AnimationController(vsync: this);
    isDark = HomeController.isDarkMode.value;
    if (isDark) {
      animationController
        ..duration = const Duration(seconds: 0)
        ..forward();
    }
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  Future switchTheme() async {
    if (animationController.isAnimating) {
      return null;
    }
    if (animationController.isCompleted) {
      animationController.reverse();
    } else {
      animationController.forward();
    }
    HomeController().switchTheme();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: switchTheme,
      child: Lottie.asset(
        "assets/theme_switch.json",
        controller: animationController,
        onLoaded: (composition) {
          animationController.duration = composition.duration;
        },
      ),
    );
  }
}
