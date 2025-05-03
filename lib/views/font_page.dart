import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_gallery/constants.dart';
import 'package:font_gallery/controllers/settings_controller.dart';
import 'package:font_gallery/models/font_model.dart';

class FontPage extends ConsumerStatefulWidget {
  final FontModel fontModel;
  const FontPage({super.key, required this.fontModel});

  @override
  ConsumerState createState() => _FontPageState();
}

class _FontPageState extends ConsumerState<FontPage> {
  bool isItalic = false;
  bool isUnderlined = false;
  double fontSize = 20;

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

  Widget fontTile(FontWeight fontWeight) {
    final themeContext = Theme.of(context);
    final String displayText = ref.watch(
      settingsProvider.select((value) => value.displayText),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(height: 0),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          child: Text(
            getWeightText(fontWeight),
            style: themeContext.textTheme.bodyMedium?.copyWith(
              color: themeContext.textTheme.bodySmall?.color,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 20),
          child: Text(
            displayText,
            style: widget.fontModel.textStyle().copyWith(
              fontSize: fontSize,
              fontWeight: fontWeight,
              fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
              decoration:
                  isUnderlined ? TextDecoration.underline : TextDecoration.none,
            ),
            maxLines: 3,
          ),
        ),
        const Divider(height: 0),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.fontModel.name),
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
              padding: const EdgeInsets.symmetric(horizontal: 4),
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
                        DropdownMenuItem(value: 22, child: Text("22")),
                        DropdownMenuItem(value: 24, child: Text("24")),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            fontTile(FontWeight.w300),
            fontTile(FontWeight.w400),
            fontTile(FontWeight.w500),
            fontTile(FontWeight.w600),
            fontTile(FontWeight.w700),
            fontTile(FontWeight.w800),
            fontTile(FontWeight.w900),
          ],
        ),
      ),
    );
  }
}
