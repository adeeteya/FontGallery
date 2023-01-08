import 'package:flutter/material.dart';
import 'package:font_gallery/constants.dart';
import 'package:font_gallery/controllers/home_controller.dart';
import 'package:font_gallery/models/font_model.dart';
import 'package:font_gallery/views/font_page.dart';

class FontCard extends StatelessWidget {
  const FontCard(
      {Key? key,
      required this.fontModel,
      required this.isSelected,
      required this.onCompareAction})
      : super(key: key);
  final FontModel fontModel;
  final bool isSelected;
  final VoidCallback onCompareAction;
  @override
  Widget build(BuildContext context) {
    final themeContext = Theme.of(context);
    return ValueListenableBuilder<String>(
      valueListenable: HomeController.displayText,
      builder: (context, value, _) {
        return InkWell(
          borderRadius: BorderRadius.circular(6),
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondAnimation) =>
                    SlideTransition(
                  position:
                      Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
                          .animate(animation),
                  child: FontPage(
                    fontModel: fontModel,
                    initialText:
                        (value.compareTo(kDefaultText) == 0 ? null : value),
                  ),
                ),
              ),
            );
          },
          child: Ink(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
            decoration: BoxDecoration(
              border: Border.all(color: themeContext.dividerColor),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(fontModel.name,
                            style: themeContext.textTheme.titleMedium),
                        Text(
                          fontModel.author,
                          style: themeContext.textTheme.bodyMedium?.copyWith(
                              color: themeContext.textTheme.bodySmall?.color),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: onCompareAction,
                      icon: (isSelected)
                          ? const Icon(Icons.remove)
                          : const Icon(Icons.add),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  value,
                  style: fontModel.textStyle().copyWith(fontSize: 20),
                  maxLines: 3,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
