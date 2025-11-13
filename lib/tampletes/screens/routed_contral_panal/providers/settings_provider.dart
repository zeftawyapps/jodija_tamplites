import 'package:flutter/material.dart';

/// Settings Provider - manages app settings like theme, language, etc.
class SettingsProvider extends ChangeNotifier {
  SettingsProvider({
    bool isDarkMode = false,
    String languageCode = 'ar',
    double fontSize = 14.0,
    Map<String, dynamic>? customSettings,
  })  : _isDarkMode = isDarkMode,
        _languageCode = languageCode,
        _fontSize = fontSize,
        _customSettings = customSettings ?? {};

  // Theme settings
  bool _isDarkMode;
  bool get isDarkMode => _isDarkMode;

  void setDarkMode(bool value) {
    if (_isDarkMode != value) {
      _isDarkMode = value;
      notifyListeners();
    }
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  // Language settings
  String _languageCode;
  String get languageCode => _languageCode;

  void setLanguage(String code) {
    if (_languageCode != code) {
      _languageCode = code;
      notifyListeners();
    }
  }

  // Font size settings
  double _fontSize;
  double get fontSize => _fontSize;

  void setFontSize(double size) {
    if (_fontSize != size) {
      _fontSize = size;
      notifyListeners();
    }
  }

  void increaseFontSize() {
    if (_fontSize < 24.0) {
      _fontSize += 2.0;
      notifyListeners();
    }
  }

  void decreaseFontSize() {
    if (_fontSize > 10.0) {
      _fontSize -= 2.0;
      notifyListeners();
    }
  }

  void resetFontSize() {
    _fontSize = 14.0;
    notifyListeners();
  }

  // Custom settings (flexible key-value storage)
  Map<String, dynamic> _customSettings;
  Map<String, dynamic> get customSettings => Map.unmodifiable(_customSettings);

  void setSetting(String key, dynamic value) {
    if (_customSettings[key] != value) {
      _customSettings[key] = value;
      notifyListeners();
    }
  }

  dynamic getSetting(String key, {dynamic defaultValue}) {
    return _customSettings[key] ?? defaultValue;
  }

  void removeSetting(String key) {
    if (_customSettings.containsKey(key)) {
      _customSettings.remove(key);
      notifyListeners();
    }
  }

  void clearCustomSettings() {
    if (_customSettings.isNotEmpty) {
      _customSettings.clear();
      notifyListeners();
    }
  }

  // Batch update settings
  void updateSettings({
    bool? isDarkMode,
    String? languageCode,
    double? fontSize,
    Map<String, dynamic>? customSettings,
  }) {
    bool hasChanges = false;

    if (isDarkMode != null && _isDarkMode != isDarkMode) {
      _isDarkMode = isDarkMode;
      hasChanges = true;
    }

    if (languageCode != null && _languageCode != languageCode) {
      _languageCode = languageCode;
      hasChanges = true;
    }

    if (fontSize != null && _fontSize != fontSize) {
      _fontSize = fontSize;
      hasChanges = true;
    }

    if (customSettings != null) {
      _customSettings.addAll(customSettings);
      hasChanges = true;
    }

    if (hasChanges) {
      notifyListeners();
    }
  }

  // Reset all settings to defaults
  void resetToDefaults() {
    _isDarkMode = false;
    _languageCode = 'ar';
    _fontSize = 14.0;
    _customSettings.clear();
    notifyListeners();
  }

  // Export/Import settings
  Map<String, dynamic> exportSettings() {
    return {
      'isDarkMode': _isDarkMode,
      'languageCode': _languageCode,
      'fontSize': _fontSize,
      'customSettings': Map<String, dynamic>.from(_customSettings),
    };
  }

  void importSettings(Map<String, dynamic> settings) {
    _isDarkMode = settings['isDarkMode'] as bool? ?? false;
    _languageCode = settings['languageCode'] as String? ?? 'ar';
    _fontSize = settings['fontSize'] as double? ?? 14.0;
    _customSettings = Map<String, dynamic>.from(
      settings['customSettings'] as Map? ?? {},
    );
    notifyListeners();
  }
}
