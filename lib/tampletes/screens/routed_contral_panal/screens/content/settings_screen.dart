import 'package:flutter/material.dart';
import '../../utiles/settings_manager.dart';

/// شاشة الإعدادات - مثال على استخدام SettingsManager mixin
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with SettingsManager {
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setupSettingsManager(context);
  }

  @override
  Widget build(BuildContext context) {
    return buildWithSettings(context, (context, settings) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('الإعدادات'),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: resetSettings,
              tooltip: 'إعادة تعيين الإعدادات',
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              child: Column(
                children: [
                  const ListTile(
                    title: Text('المظهر'),
                    subtitle: Text('اختر بين الوضع الفاتح والداكن'),
                    leading: Icon(Icons.brightness_6),
                  ),
                  SwitchListTile(
                    title: const Text('الوضع الداكن'),
                    subtitle: Text(isDarkMode ? 'مفعّل' : 'معطّل'),
                    value: isDarkMode,
                    onChanged: (value) => setDarkMode(value),
                    secondary: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Column(
                children: [
                  const ListTile(
                    title: Text('اللغة'),
                    subtitle: Text('اختر لغة التطبيق'),
                    leading: Icon(Icons.language),
                  ),
                  RadioListTile<String>(
                    title: const Text('العربية'),
                    value: 'ar',
                    groupValue: currentLanguage,
                    onChanged: (value) {
                      if (value != null) changeLanguage(value);
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('English'),
                    value: 'en',
                    groupValue: currentLanguage,
                    onChanged: (value) {
                      if (value != null) changeLanguage(value);
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('Français'),
                    value: 'fr',
                    groupValue: currentLanguage,
                    onChanged: (value) {
                      if (value != null) changeLanguage(value);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Column(
                children: [
                  ListTile(
                    title: const Text('حجم الخط'),
                    subtitle: Text('${currentFontSize.toStringAsFixed(0)} نقطة'),
                    leading: const Icon(Icons.text_fields),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: decreaseFontSize,
                          tooltip: 'تصغير',
                        ),
                        Expanded(
                          child: Slider(
                            value: currentFontSize,
                            min: 10.0,
                            max: 24.0,
                            divisions: 14,
                            label: currentFontSize.toStringAsFixed(0),
                            onChanged: (value) => setFontSize(value),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: increaseFontSize,
                          tooltip: 'تكبير',
                        ),
                        IconButton(
                          icon: const Icon(Icons.refresh),
                          onPressed: resetFontSize,
                          tooltip: 'إعادة تعيين',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Column(
                children: [
                  const ListTile(
                    title: Text('إعدادات مخصصة'),
                    subtitle: Text('أمثلة على الإعدادات القابلة للتخصيص'),
                    leading: Icon(Icons.settings),
                  ),
                  SwitchListTile(
                    title: const Text('تفعيل الإشعارات'),
                    value: getSetting<bool>('notifications') ?? true,
                    onChanged: (value) => setSetting('notifications', value),
                  ),
                  SwitchListTile(
                    title: const Text('تشغيل الأصوات'),
                    value: getSetting<bool>('sounds') ?? true,
                    onChanged: (value) => setSetting('sounds', value),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: ExpansionTile(
                title: const Text('معلومات الإعدادات الحالية'),
                leading: const Icon(Icons.info),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('الوضع: ${isDarkMode ? "داكن" : "فاتح"}'),
                        Text('اللغة: $currentLanguage'),
                        Text('حجم الخط: ${currentFontSize.toStringAsFixed(1)}'),
                        const SizedBox(height: 8),
                        const Text(
                          'الإعدادات المخصصة:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        if (allSettings.isEmpty)
                          const Text(
                            '  لا توجد إعدادات مخصصة',
                            style: TextStyle(color: Colors.grey),
                          )
                        else
                          ...allSettings.entries.map(
                            (e) => Padding(
                              padding: const EdgeInsets.only(left: 8, top: 2),
                              child: Text('${e.key}: ${e.value}'),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
