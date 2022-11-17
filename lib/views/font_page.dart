import 'package:flutter/material.dart';
import 'package:font_gallery/models/font_model.dart';

class FontPage extends StatefulWidget {
  const FontPage({Key? key, required this.fontModel}) : super(key: key);
  final FontModel fontModel;

  @override
  State<FontPage> createState() => _FontPageState();
}

class _FontPageState extends State<FontPage> {
  bool isItalic = false;
  double fontSize = 20;
  String displayText = "";
  final String defaultText = "Whereas Recognition of the Inherent Dignity";
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
              tooltip: "Italics Style",
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
          ],
        ),
        body: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: [
            Row(
              children: [
                Flexible(
                  flex: 4,
                  child: TextFormField(
                    onChanged: (val) {
                      setState(() {
                        displayText = val;
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: "Type Something",
                      border: UnderlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: DropdownButtonFormField<double>(
                    value: fontSize,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.format_size),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                    ),
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
                )
              ],
            ),
            const SizedBox(height: 15),
            FontTile(
              displayText: displayText.isEmpty ? defaultText : displayText,
              textStyle: widget.fontModel.textStyle().copyWith(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w300,
                    fontStyle: (isItalic) ? FontStyle.italic : FontStyle.normal,
                  ),
            ),
            FontTile(
              displayText: displayText.isEmpty ? defaultText : displayText,
              textStyle: widget.fontModel.textStyle().copyWith(
                    fontSize: fontSize,
                    fontStyle: (isItalic) ? FontStyle.italic : FontStyle.normal,
                  ),
            ),
            FontTile(
              displayText: displayText.isEmpty ? defaultText : displayText,
              textStyle: widget.fontModel.textStyle().copyWith(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w500,
                    fontStyle: (isItalic) ? FontStyle.italic : FontStyle.normal,
                  ),
            ),
            FontTile(
              displayText: displayText.isEmpty ? defaultText : displayText,
              textStyle: widget.fontModel.textStyle().copyWith(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w600,
                    fontStyle: (isItalic) ? FontStyle.italic : FontStyle.normal,
                  ),
            ),
            FontTile(
              displayText: displayText.isEmpty ? defaultText : displayText,
              textStyle: widget.fontModel.textStyle().copyWith(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w700,
                    fontStyle: (isItalic) ? FontStyle.italic : FontStyle.normal,
                  ),
            ),
            FontTile(
              displayText: displayText.isEmpty ? defaultText : displayText,
              textStyle: widget.fontModel.textStyle().copyWith(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w800,
                    fontStyle: (isItalic) ? FontStyle.italic : FontStyle.normal,
                  ),
            ),
            FontTile(
              displayText: displayText.isEmpty ? defaultText : displayText,
              textStyle: widget.fontModel.textStyle().copyWith(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w900,
                    fontStyle: (isItalic) ? FontStyle.italic : FontStyle.normal,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class FontTile extends StatelessWidget {
  const FontTile({Key? key, required this.textStyle, required this.displayText})
      : super(key: key);
  final String displayText;
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
            displayText,
            style: textStyle,
            maxLines: 3,
          ),
        ),
        const Divider(height: 0),
      ],
    );
  }
}
