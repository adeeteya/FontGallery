import 'package:flutter/material.dart';
import 'package:font_gallery/constants.dart';
import 'package:font_gallery/controllers/home_controller.dart';
import 'package:font_gallery/models/font_model.dart';
import 'package:font_gallery/widgets/font_tile.dart';

class FontPage extends StatefulWidget {
  const FontPage({Key? key, required this.fontModel, this.initialText})
      : super(key: key);
  final FontModel fontModel;
  final String? initialText;

  @override
  State<FontPage> createState() => _FontPageState();
}

class _FontPageState extends State<FontPage> {
  bool isItalic = false;
  bool isUnderlined = false;
  double fontSize = 20;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
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
              padding: const EdgeInsets.symmetric(horizontal: 4),
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
            const SizedBox(height: 15),
            FontTile(
              textStyle: widget.fontModel.textStyle().copyWith(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w300,
                    fontStyle: (isItalic) ? FontStyle.italic : FontStyle.normal,
                    decoration: (isUnderlined)
                        ? TextDecoration.underline
                        : TextDecoration.none,
                  ),
            ),
            FontTile(
              textStyle: widget.fontModel.textStyle().copyWith(
                    fontSize: fontSize,
                    fontStyle: (isItalic) ? FontStyle.italic : FontStyle.normal,
                    decoration: (isUnderlined)
                        ? TextDecoration.underline
                        : TextDecoration.none,
                  ),
            ),
            FontTile(
              textStyle: widget.fontModel.textStyle().copyWith(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w500,
                    fontStyle: (isItalic) ? FontStyle.italic : FontStyle.normal,
                    decoration: (isUnderlined)
                        ? TextDecoration.underline
                        : TextDecoration.none,
                  ),
            ),
            FontTile(
              textStyle: widget.fontModel.textStyle().copyWith(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w600,
                    fontStyle: (isItalic) ? FontStyle.italic : FontStyle.normal,
                    decoration: (isUnderlined)
                        ? TextDecoration.underline
                        : TextDecoration.none,
                  ),
            ),
            FontTile(
              textStyle: widget.fontModel.textStyle().copyWith(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w700,
                    fontStyle: (isItalic) ? FontStyle.italic : FontStyle.normal,
                    decoration: (isUnderlined)
                        ? TextDecoration.underline
                        : TextDecoration.none,
                  ),
            ),
            FontTile(
              textStyle: widget.fontModel.textStyle().copyWith(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w800,
                    fontStyle: (isItalic) ? FontStyle.italic : FontStyle.normal,
                    decoration: (isUnderlined)
                        ? TextDecoration.underline
                        : TextDecoration.none,
                  ),
            ),
            FontTile(
              textStyle: widget.fontModel.textStyle().copyWith(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w900,
                    fontStyle: (isItalic) ? FontStyle.italic : FontStyle.normal,
                    decoration: (isUnderlined)
                        ? TextDecoration.underline
                        : TextDecoration.none,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
