import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';

/// Mixin for managing settings in external screens
mixin SettingsManager {
  SettingsProvider? _settingsProvider;

  /// Setup settings manager - call this in initState or build
  void setupSettingsManager(BuildContext context) {
    if (_settingsProvider == null) {
      _settingsProvider = context.read<SettingsProvider>();
    }
  }

  /// Get the settings provider
  SettingsProvider? get settingsProvider => _settingsProvider;

  // Quick access methods

  /// Get current theme mode
  bool get isDarkMode => _settingsProvider?.isDarkMode ?? false;

  /// Toggle between light and dark theme
  void toggleTheme() {
    _settingsProvider?.toggleTheme();
  }

  /// Set theme mode
  void setDarkMode(bool value) {
    _settingsProvider?.setDarkMode(value);
  }

  /// Get current language code
  String get currentLanguage => _settingsProvider?.languageCode ?? 'ar';

  /// Change language
  void changeLanguage(String languageCode) {
    _settingsProvider?.setLanguage(languageCode);
  }

  /// Get current font size
  double get currentFontSize => _settingsProvider?.fontSize ?? 14.0;

  /// Set font size
  void setFontSize(double size) {
    _settingsProvider?.setFontSize(size);
  }

  /// Increase font size
  void increaseFontSize() {
    _settingsProvider?.increaseFontSize();
  }

  /// Decrease font size
  void decreaseFontSize() {
    _settingsProvider?.decreaseFontSize();
  }

  /// Reset font size to default
  void resetFontSize() {
    _settingsProvider?.resetFontSize();
  }

  /// Get custom setting value
  T? getSetting<T>(String key, {T? defaultValue}) {
    if (_settingsProvider == null) return defaultValue;
    final value = _settingsProvider!.getSetting(key, defaultValue: defaultValue);
    if (value == null) return defaultValue;
    try {
      return value as T;
    } catch (e) {
      return defaultValue;
    }
  }

  /// Set custom setting value
  void setSetting(String key, dynamic value) {
    _settingsProvider?.setSetting(key, value);
  }

  /// Remove custom setting
  void removeSetting(String key) {
    _settingsProvider?.removeSetting(key);
  }

  /// Get all custom settings
  Map<String, dynamic> get allSettings =>
      _settingsProvider?.customSettings ?? {};

  /// Update multiple settings at once
  void updateSettings({
    bool? isDarkMode,
    String? languageCode,
    double? fontSize,
    Map<String, dynamic>? customSettings,
  }) {
    _settingsProvider?.updateSettings(
      isDarkMode: isDarkMode,
      languageCode: languageCode,
      fontSize: fontSize,
      customSettings: customSettings,
    );
  }

  /// Reset all settings to defaults
  void resetSettings() {
    _settingsProvider?.resetToDefaults();
  }

  /// Export settings as map
  Map<String, dynamic> exportSettings() {
    return _settingsProvider?.exportSettings() ?? {};
  }

  /// Import settings from map
  void importSettings(Map<String, dynamic> settings) {
    _settingsProvider?.importSettings(settings);
  }

  /// Build a widget that listens to settings changes
  Widget buildWithSettings(
    BuildContext context,
    Widget Function(BuildContext context, SettingsProvider settings) builder,
  ) {
    return Consumer<SettingsProvider>(
      builder: (context, settings, child) => builder(context, settings),
    );
  }
}
