import 'package:flutter/material.dart';
import 'package:font_gallery/constants.dart';
import 'package:font_gallery/controllers/home_controller.dart';
import 'package:font_gallery/models/font_model.dart';

class CompareFontsPage extends StatefulWidget {
  final FontModel fontModel;
  final FontModel fontModel2;
  final String? initialText;
  const CompareFontsPage({
    Key? key,
    required this.fontModel,
    required this.fontModel2,
    this.initialText,
  }) : super(key: key);

  @override
  State<CompareFontsPage> createState() => _CompareFontsPageState();
}

class _CompareFontsPageState extends State<CompareFontsPage> {
  bool isItalic = false;
  bool isUnderlined = false;
  double fontSize = 16;

  String getWeightText(FontWeight fontWeight) {
    switch (fontWeight) {
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

  Widget compareFontTile(FontWeight fontWeight) {
    final themeContext = Theme.of(context);
    return ValueListenableBuilder<String>(
      valueListenable: HomeController.displayText,
      builder: (context, value, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(height: 0, thickness: 1),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: Text(
                getWeightText(fontWeight),
                style: themeContext.textTheme.bodyMedium
                    ?.copyWith(color: themeContext.textTheme.bodySmall?.color),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                widget.fontModel.name,
                style: themeContext.textTheme.bodyMedium
                    ?.copyWith(color: themeContext.textTheme.bodySmall?.color),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 20),
              child: Text(
                value,
                style: widget.fontModel.textStyle().copyWith(
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                      fontStyle:
                          (isItalic) ? FontStyle.italic : FontStyle.normal,
                      decoration: (isUnderlined)
                          ? TextDecoration.underline
                          : TextDecoration.none,
                    ),
                maxLines: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                widget.fontModel2.name,
                style: themeContext.textTheme.bodyMedium
                    ?.copyWith(color: themeContext.textTheme.bodySmall?.color),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 20),
              child: Text(
                value,
                style: widget.fontModel2.textStyle().copyWith(
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                      fontStyle:
                          (isItalic) ? FontStyle.italic : FontStyle.normal,
                      decoration: (isUnderlined)
                          ? TextDecoration.underline
                          : TextDecoration.none,
                    ),
                maxLines: 3,
              ),
            ),
            const Divider(height: 0, thickness: 1),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Compare Fonts"),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  isItalic = !isItalic;
                });
              },
              tooltip: "Italics",
              isSelected: isItalic,
              icon: const Icon(
                Icons.format_italic,
                color: Colors.grey,
              ),
              selectedIcon: Icon(
                Icons.format_italic,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  isUnderlined = !isUnderlined;
                });
              },
              tooltip: "Underline",
              isSelected: isUnderlined,
              icon: const Icon(
                Icons.format_underline,
                color: Colors.grey,
              ),
              selectedIcon: Icon(
                Icons.format_underlined,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,
              ),
            ),
          ],
        ),
        body: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 0, 4, 15),
              child: Row(
                children: [
                  Flexible(
                    flex: 7,
                    child: TextFormField(
                      initialValue: widget.initialText,
                      decoration: kInputTextFormDecoration,
                      onChanged: (val) {
                        HomeController().changeDisplayText(val);
                      },
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: DropdownButtonFormField<double>(
                      value: fontSize,
                      decoration: kDropdownButtonDecoration,
                      onChanged: (val) {
                        setState(() {
                          fontSize = val ?? 20;
                        });
                      },
                      items: const [
                        DropdownMenuItem(
                          value: 12,
                          child: Text("12"),
                        ),
                        DropdownMenuItem(
                          value: 14,
                          child: Text("14"),
                        ),
                        DropdownMenuItem(
                          value: 16,
                          child: Text("16"),
                        ),
                        DropdownMenuItem(
                          value: 18,
                          child: Text("18"),
                        ),
                        DropdownMenuItem(
                          value: 20,
                          child: Text("20"),
                        ),
                        DropdownMenuItem(
                          value: 22,
                          child: Text("22"),
                        ),
                        DropdownMenuItem(
                          value: 24,
                          child: Text("24"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            compareFontTile(FontWeight.w300),
            compareFontTile(FontWeight.w400),
            compareFontTile(FontWeight.w500),
            compareFontTile(FontWeight.w600),
            compareFontTile(FontWeight.w700),
            compareFontTile(FontWeight.w800),
            compareFontTile(FontWeight.w900),
          ],
        ),
      ),
    );
  }
}
