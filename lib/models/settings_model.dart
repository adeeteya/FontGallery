import 'package:font_gallery/models/font_model.dart';

class SettingsModel {
  final bool isDark;
  final String displayText;
  final FontModel? selectedFontModel;
  final FontModel? selectedFontModel2;

  SettingsModel(this.isDark, this.displayText, this.selectedFontModel,
      this.selectedFontModel2);

  SettingsModel copyWith(
      FontModel? selectedFontModel, FontModel? selectedFontModel2,
      {bool? isDark, String? displayText}) {
    return SettingsModel(isDark ?? this.isDark, displayText ?? this.displayText,
        selectedFontModel, selectedFontModel2);
  }
}
