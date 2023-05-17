import 'package:font_gallery/models/font_model.dart';

class SettingsModel {
  final bool isDark;
  final String displayText;
  final FontModel? selectedFontModel;
  final FontModel? selectedFontModel2;

  SettingsModel(this.isDark, this.displayText, this.selectedFontModel,
      this.selectedFontModel2);

  SettingsModel copyWith(
      {bool? isDark,
      String? displayText,
      FontModel? selectedFontModel,
      FontModel? selectedFontModel2}) {
    return SettingsModel(
        isDark ?? this.isDark,
        displayText ?? this.displayText,
        selectedFontModel ?? this.selectedFontModel,
        selectedFontModel2 ?? this.selectedFontModel);
  }
}
