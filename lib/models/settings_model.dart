import 'package:font_gallery/models/font_model.dart';

class SettingsModel {
  final bool isDark;
  final String displayText;
  final FontModel? selectedFontModel;
  final FontModel? selectedFontModel2;

  SettingsModel(
    this.isDark,
    this.displayText,
    this.selectedFontModel,
    this.selectedFontModel2,
  );

  SettingsModel copyWith(
    FontModel? selectedFontModel,
    FontModel? selectedFontModel2, {
    bool? isDark,
    String? displayText,
  }) {
    return SettingsModel(
      isDark ?? this.isDark,
      displayText ?? this.displayText,
      selectedFontModel,
      selectedFontModel2,
    );
  }

  @override
  String toString() {
    return 'SettingsModel{isDark: $isDark, displayText: $displayText, selectedFontModel: $selectedFontModel, selectedFontModel2: $selectedFontModel2}';
  }

  @override
  bool operator ==(Object other) {
    return other is SettingsModel &&
        isDark == other.isDark &&
        displayText == other.displayText &&
        selectedFontModel == other.selectedFontModel &&
        selectedFontModel2 == other.selectedFontModel2;
  }

  @override
  int get hashCode =>
      Object.hash(isDark, displayText, selectedFontModel, selectedFontModel2);
}
