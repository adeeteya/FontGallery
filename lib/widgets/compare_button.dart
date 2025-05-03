import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_gallery/controllers/settings_controller.dart';
import 'package:font_gallery/views/compare_page.dart';

class CompareButton extends ConsumerWidget {
  const CompareButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeContext = Theme.of(context);
    final settingsModel = ref.watch(settingsProvider);
    if (settingsModel.selectedFontModel == null &&
        settingsModel.selectedFontModel2 == null) {
      return const Offstage();
    }
    return FloatingActionButton.extended(
      label: Row(
        children: [
          if (settingsModel.selectedFontModel != null)
            GestureDetector(
              onTap:
                  () =>
                      ref
                          .read(settingsProvider.notifier)
                          .removeSelectedFontModel(),
              child: Stack(
                children: [
                  CircleAvatar(
                    backgroundColor: themeContext.scaffoldBackgroundColor,
                    child: Text(
                      settingsModel.selectedFontModel?.name.substring(0, 3) ??
                          "",
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: themeContext.colorScheme.surface,
                      child: const Icon(Icons.remove, size: 12),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(width: 5),
          if (settingsModel.selectedFontModel2 != null)
            GestureDetector(
              onTap:
                  () =>
                      ref
                          .read(settingsProvider.notifier)
                          .removeSelectedFontModel2(),
              child: Stack(
                children: [
                  CircleAvatar(
                    backgroundColor: themeContext.scaffoldBackgroundColor,
                    child: Text(
                      settingsModel.selectedFontModel2?.name.substring(0, 3) ??
                          "",
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: themeContext.colorScheme.surface,
                      child: const Icon(Icons.remove, size: 12),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(width: 16),
          Text(
            "Compare",
            style: TextStyle(
              color:
                  (settingsModel.selectedFontModel == null ||
                          settingsModel.selectedFontModel2 == null)
                      ? Colors.grey.shade400
                      : null,
            ),
          ),
          Icon(
            Icons.chevron_right,
            color:
                (settingsModel.selectedFontModel == null ||
                        settingsModel.selectedFontModel2 == null)
                    ? Colors.grey.shade400
                    : null,
          ),
        ],
      ),
      onPressed:
          (settingsModel.selectedFontModel == null ||
                  settingsModel.selectedFontModel2 == null)
              ? null
              : () async {
                await Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const CompareFontsPage(),
                  ),
                );
              },
    );
  }
}
