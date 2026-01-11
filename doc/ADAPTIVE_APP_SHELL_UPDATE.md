# AdaptiveAppShell - دليل الاستخدام

## نظرة عامة
تم تحديث `AdaptiveAppShell` ليكون مرتبطاً بشكل كامل مع ثيم Flutter الخارجي (`ThemeData`)، مما يوفر مرونة أكبر وتكامل أفضل مع نظام الثيمات في Flutter.

## التغييرات الرئيسية

### 1. إزالة الاعتماد على `SideBarNavigationTheames` كخاصية إلزامية
بدلاً من تمرير `SideBarNavigationTheames` مباشرة، الآن نستخدم:
- `lightTheme: ThemeData?` - الثيم الفاتح
- `darkTheme: ThemeData?` - الثيم الداكن
- `isDarkMode: bool` - لتحديد الوضع الحالي

### 2. خصائص جديدة لتخصيص الـ Sidebar
```dart
// Sidebar styling properties
final Color? sidebarBackgroundColor;
final Color? sidebarSelectedColor;
final Color? sidebarHoverColor;
final Color? sidebarTextColor;
final Color? sidebarIconColor;
final double? sidebarItemHeight;
final double? sidebarFontSize;
```

### 3. نقل الدوال المساعدة إلى `AppShellUtils`
تم نقل جميع الدوال المساعدة إلى:
```
lib/tampletes/screens/routed_contral_panal/utils/app_shell_utils.dart
```

الدوال المتاحة:
- `AppShellUtils.getLayoutDirection(String languageCode)`
- `AppShellUtils.isRTL(String languageCode)`

## مثال على الاستخدام

### الطريقة الأساسية (استخدام الثيم الافتراضي)

```dart
AdaptiveAppShell(
  languageCode: 'ar',
  isDarkMode: false,
  loclizationLangs: myLocalizations,
  sidebarItems: [
    RouteItem(
      title: 'الرئيسية',
      icon: Icons.home,
      path: '/home',
    ),
  ],
)
```

### الطريقة المتقدمة (ثيم مخصص)

```dart
AdaptiveAppShell(
  languageCode: 'ar',
  loclizationLangs: myLocalizations,
  
  // تخصيص الثيمات
  lightTheme: ThemeData.light(useMaterial3: true).copyWith(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.light,
    ),
  ),
  darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.dark,
    ),
  ),
  isDarkMode: false,
  
  // تخصيص الـ Sidebar
  sidebarBackgroundColor: Colors.white,
  sidebarSelectedColor: Colors.blue,
  sidebarHoverColor: Colors.grey[200],
  sidebarItemHeight: 56.0,
  sidebarFontSize: 16.0,
  
  // تخصيص الحركات
  animationType: SidBarAnimationType.slideAndFade,
  animationDuration: Duration(milliseconds: 300),
  animationCurve: Curves.easeOutCubic,
  
  sidebarItems: myItems,
)
```

## الحصول على الثيم داخل التطبيق

```dart
// للحصول على SideBarNavigationTheames
final sidebarTheme = AdaptiveAppShell.getTheme(context);

// للحصول على الثيم العام من Flutter
final theme = Theme.of(context);

// للحصول على اتجاه النص
final direction = AdaptiveAppShell.getLayoutDirection(context);
```

## الميزات

### 1. التكامل مع Material 3
الآن يدعم `AdaptiveAppShell` Material 3 بالكامل ويستخدم `ColorScheme` و `ThemeData` القياسية.

### 2. دعم الوضع الليلي/النهاري
يمكن التبديل بين الوضع الفاتح والداكن بسهولة:
```dart
SettingsProvider.of(context).toggleDarkMode();
```

### 3. دعم RTL/LTR تلقائياً
يتم حساب اتجاه النص تلقائياً بناءً على `languageCode`:
- `ar, he, fa, ur` → RTL
- باقي اللغات → LTR

### 4. حركات متعددة للـ Sidebar
```dart
enum SidBarAnimationType {
  slideAndFade,      // انزلاق مع تلاشي
  scaleUp,           // تكبير
  fadeOnly,          // تلاشي فقط
  slideFromTop,      // من الأعلى
  slideFromBottom,   // من الأسفل
  scaleAndFade,      // تكبير مع تلاشي
  rotateAndScale,    // دوران مع تكبير
}
```

## الهيكل الجديد

```
lib/tampletes/screens/routed_contral_panal/
├── laaunser.dart                    # AdaptiveAppShell الرئيسي
├── theam/
│   └── theam.dart                   # SideBarNavigationTheames
├── utils/
│   └── app_shell_utils.dart         # الدوال المساعدة
├── providers/
│   ├── sidebar_provider.dart
│   ├── settings_provider.dart
│   └── status_provider.dart
└── models/
    ├── route_item.dart
    ├── app_bar_config.dart
    └── sidebar_header_config.dart
```

## الترقية من الإصدار القديم

### قبل:
```dart
AdaptiveAppShell(
  theme: SideBarNavigationTheames.light(),
  // ...
)
```

### بعد:
```dart
AdaptiveAppShell(
  lightTheme: ThemeData.light(useMaterial3: true),
  darkTheme: ThemeData.dark(useMaterial3: true),
  isDarkMode: false,
  // ...
)
```

## ملاحظات مهمة

1. **الثيم الافتراضي**: إذا لم يتم تمرير `lightTheme` أو `darkTheme`، سيتم استخدام الثيمات الافتراضية من Flutter.

2. **الأداء**: تم تحسين الأداء بنقل العمليات الثقيلة إلى `AppShellUtils`.

3. **التوافق**: هذا الإصدار متوافق مع Material 3 ويدعم جميع ميزات Flutter الحديثة.

4. **الـ Provider**: يتم توفير `SideBarNavigationTheames` تلقائياً عبر Provider للاستخدام في الويدجات الفرعية.
