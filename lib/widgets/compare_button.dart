import 'package:flutter/material.dart';

class CompareButton extends StatelessWidget {
  final String? fontName;
  final String? fontName2;
  final VoidCallback removeSelectedFont;
  final VoidCallback removeSelectedFont2;
  final VoidCallback onPressed;

  const CompareButton(
      {Key? key,
      this.fontName,
      this.fontName2,
      required this.removeSelectedFont,
      required this.removeSelectedFont2,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeContext = Theme.of(context);
    return FloatingActionButton.extended(
      label: Row(
        children: [
          if (fontName != null)
            GestureDetector(
              onTap: removeSelectedFont,
              child: Stack(
                children: [
                  CircleAvatar(
                    backgroundColor: themeContext.scaffoldBackgroundColor,
                    child: Text(
                      fontName ?? "",
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: themeContext.backgroundColor,
                      child: const Icon(
                        Icons.remove,
                        size: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(width: 5),
          if (fontName2 != null)
            GestureDetector(
              onTap: removeSelectedFont2,
              child: Stack(
                children: [
                  CircleAvatar(
                    backgroundColor: themeContext.scaffoldBackgroundColor,
                    child: Text(
                      fontName2 ?? "",
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: themeContext.backgroundColor,
                      child: const Icon(
                        Icons.remove,
                        size: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(width: 16),
          Text(
            "Compare",
            style: TextStyle(
              color: (fontName == null || fontName2 == null)
                  ? Colors.grey.shade400
                  : null,
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: (fontName == null || fontName2 == null)
                ? Colors.grey.shade400
                : null,
          ),
        ],
      ),
      onPressed: (fontName == null || fontName2 == null) ? null : onPressed,
    );
  }
}
