import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_gallery/constants.dart';
import 'package:font_gallery/controllers/settings_controller.dart';
import 'package:font_gallery/helpers.dart';

class CompareFontsPage extends ConsumerStatefulWidget {
  const CompareFontsPage({super.key});

  @override
  ConsumerState createState() => _CompareFontsPageState();
}

class _CompareFontsPageState extends ConsumerState<CompareFontsPage> {
  bool isItalic = false;
  bool isUnderlined = false;
  double fontSize = 16;

  Widget compareFontTile(FontWeight fontWeight) {
    final ThemeData themeContext = Theme.of(context);
    final String displayText = ref.watch(
      settingsProvider.select((value) => value.displayText),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(height: 0, thickness: 1),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          child: Text(
            Helpers.getWeightText(fontWeight),
            style: themeContext.textTheme.bodyMedium?.copyWith(
              color: themeContext.textTheme.bodySmall?.color,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            ref.read(settingsProvider).selectedFontModel?.name ?? "",
            style: themeContext.textTheme.bodyMedium?.copyWith(
              color: themeContext.textTheme.bodySmall?.color,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 20),
          child: Text(
            displayText,
            style: ref
                .read(settingsProvider)
                .selectedFontModel
                ?.textStyle()
                .copyWith(
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
                  decoration:
                      isUnderlined
                          ? TextDecoration.underline
                          : TextDecoration.none,
                ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            ref.read(settingsProvider).selectedFontModel2?.name ?? "",
            style: themeContext.textTheme.bodyMedium?.copyWith(
              color: themeContext.textTheme.bodySmall?.color,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 20),
          child: Text(
            displayText,
            style: ref
                .read(settingsProvider)
                .selectedFontModel2
                ?.textStyle()
                .copyWith(
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
                  decoration:
                      isUnderlined
                          ? TextDecoration.underline
                          : TextDecoration.none,
                ),
          ),
        ),
        const Divider(height: 0, thickness: 1),
      ],
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
              icon: const Icon(Icons.format_italic, color: Colors.grey),
              selectedIcon: Icon(
                Icons.format_italic,
                color:
                    Theme.of(context).brightness == Brightness.light
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
              icon: const Icon(Icons.format_underline, color: Colors.grey),
              selectedIcon: Icon(
                Icons.format_underlined,
                color:
                    Theme.of(context).brightness == Brightness.light
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
                      initialValue:
                          (ref
                                      .read(settingsProvider)
                                      .displayText
                                      .compareTo(kDefaultText) ==
                                  0)
                              ? null
                              : ref.read(settingsProvider).displayText,
                      decoration: kInputTextFormDecoration,
                      onChanged: (val) {
                        ref
                            .read(settingsProvider.notifier)
                            .changeDisplayText(val);
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
                        DropdownMenuItem(value: 12, child: Text("12")),
                        DropdownMenuItem(value: 14, child: Text("14")),
                        DropdownMenuItem(value: 16, child: Text("16")),
                        DropdownMenuItem(value: 18, child: Text("18")),
                        DropdownMenuItem(value: 20, child: Text("20")),
                        DropdownMenuItem(value: 24, child: Text("24")),
                        DropdownMenuItem(value: 32, child: Text("32")),
                        DropdownMenuItem(value: 48, child: Text("48")),
                        DropdownMenuItem(value: 64, child: Text("64")),
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
