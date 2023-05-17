import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_gallery/controllers/settings_controller.dart';
import 'package:lottie/lottie.dart';

class ThemeModeToggle extends ConsumerStatefulWidget {
  const ThemeModeToggle({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _ThemeModeToggleState();
}

class _ThemeModeToggleState extends ConsumerState<ThemeModeToggle>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late bool isDark;
  @override
  void initState() {
    animationController = AnimationController(vsync: this);
    isDark = ref.read(settingsProvider.select((value) => value.isDark));
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

  Future<void> switchTheme() async {
    if (animationController.isAnimating) {
      return;
    }
    if (animationController.isCompleted) {
      animationController.reverse();
    } else {
      animationController.forward();
    }
    await ref.read(settingsProvider.notifier).switchTheme();
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
