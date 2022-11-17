import 'package:flutter/material.dart';
import 'package:font_gallery/controllers/home_controller.dart';

class FontTile extends StatelessWidget {
  const FontTile({Key? key, required this.textStyle}) : super(key: key);
  final TextStyle textStyle;
  String getWeightText() {
    switch (textStyle.fontWeight) {
      case FontWeight.w100:
        return "Thin 100";
      case FontWeight.w200:
        return "ExtraLight 200";
      case FontWeight.w300:
        return "Light 300";
      case FontWeight.w400:
        return "Regular 400";
      case FontWeight.w500:
        return "Medium 500";
      case FontWeight.w600:
        return "SemiBold 600";
      case FontWeight.w700:
        return "Bold 700";
      case FontWeight.w800:
        return "ExtraBold 800";
      case FontWeight.w900:
        return "Black 900";
      default:
        return "Regular 400";
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeContext = Theme.of(context);
    return ValueListenableBuilder<String>(
      valueListenable: HomeController.displayText,
      builder: (context, value, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(height: 0),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: Text(
                getWeightText(),
                style: themeContext.textTheme.bodyMedium
                    ?.copyWith(color: themeContext.textTheme.bodySmall?.color),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 20),
              child: Text(
                value,
                style: textStyle,
                maxLines: 3,
              ),
            ),
            const Divider(height: 0),
          ],
        );
      },
    );
  }
}
