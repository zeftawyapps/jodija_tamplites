// # شرح خصائص الحركة في SideBarNavigationTheames

/*

## الخصائص الجديدة:

1. **layoutDirection** (TextDirection)
   - TextDirection.ltr: الحركة من اليسار لليمين
   - TextDirection.rtl: الحركة من اليمين لليسار (للعربية)
   - Default: TextDirection.ltr

2. **animationDuration** (Duration)
   - مدة الحركة الكلية
   - Default: Duration(milliseconds: 300)
   - مثال: Duration(milliseconds: 500) للحركة البطيئة

3. **animationCurve** (Curve)
   - منحنى التسارع والتبطيء
   - Curves.easeOutCubic: سريع ثم بطيء (الأفضل)
   - Curves.linear: حركة منتظمة
   - Curves.elasticOut: حركة ارتدادية
   - Curves.easeInOutCubic: ناعم جداً
   - Default: Curves.easeOutCubic

4. **animationSlideDistance** (double)
   - مسافة الانزلاق الأفقي
   - Default: 50.0
   - زيادة القيمة = حركة أكبر

## كيفية الاستخدام:

// 1. إنشاء ثيم مع خصائص حركة مخصصة
final theme = SideBarNavigationTheames.light(
  layoutDirection: TextDirection.rtl,  // للعربية
  animationDuration: Duration(milliseconds: 400),
  animationCurve: Curves.easeOutCubic,
  animationSlideDistance: 60.0,
);

// 2. استخدام في MaterialApp
MaterialApp.router(
  theme: ThemeData(
    useMaterial3: true,
  ),
  routerConfig: router,
  // ...
)

// 3. تخصيص ثيم في SettingsProvider
settingsProvider.setAnimationCurve(Curves.easeInOutCubic);
settingsProvider.setAnimationDuration(Duration(milliseconds: 300));

## Method getAnimationOffset():

يحسب موضع الحركة بناءً على layoutDirection:

- إذا كان RTL: Offset موجب (من اليمين)
- إذا كان LTR: Offset سالب (من اليسار)

مثال استخدام:
final offset = theme.getAnimationOffset(0.5); // 0.5 = نصف الحركة

## الأمثلة الجاهزة:

// سريع (200ms)
SideBarNavigationTheames.light(
  animationDuration: Duration(milliseconds: 200),
  animationCurve: Curves.easeOutQuad,
  animationSlideDistance: 40.0,
)

// ناعم (500ms)
SideBarNavigationTheames.light(
  animationDuration: Duration(milliseconds: 500),
  animationCurve: Curves.easeInOutCubic,
  animationSlideDistance: 80.0,
)

// ارتدادي
SideBarNavigationTheames.light(
  animationDuration: Duration(milliseconds: 600),
  animationCurve: Curves.bounceOut,
  animationSlideDistance: 70.0,
)

## التأثير على الكود:

في SidebarWidget._buildAnimatedItem():

Transform.translate(
  offset: theme.getAnimationOffset(value),  // يحسب الاتجاه
  child: Opacity(
    opacity: value,
    child: child,
  ),
)

- value: من 0.0 إلى 1.0 (تقدم الحركة)
- theme.getAnimationOffset(value): يرجع Offset حسب اللغة والاتجاه

*/

// النقاط المهمة:

// 1. التوافق مع اللغات:
//    - العربية (RTL): الحركة من اليمين لليسار
//    - الإنجليزية (LTR): الحركة من اليسار لليمين

// 2. الأداء:
//    - مدة أقصر = أداء أفضل لكن قد تبدو سريعة جداً
//    - مدة طويلة جداً قد تبدو بطيئة

// 3. تجربة المستخدم:
//    - Curves.easeOutCubic: الأفضل للأداء والمظهر
//    - Curves.bounceOut: مرحة لكن قد تبدو غير احترافية

// 4. المسافة:
//    - 40-50: مناسبة للسايدبار العادي
//    - 60-80: حركة ملحوظة أكثر
//    - 100+: حركة درامية جداً

void main() {
  // استخدام الإعدادات الجاهزة من AnimationSettings
  final theme = AnimationSettings.presets['fast_rtl'];
  
  // أو إنشاء ثيم مخصص
  final customTheme = SideBarNavigationTheames.light(
    layoutDirection: TextDirection.rtl,
    animationDuration: const Duration(milliseconds: 350),
    animationCurve: Curves.easeOutCubic,
    animationSlideDistance: 55.0,
  );
}
