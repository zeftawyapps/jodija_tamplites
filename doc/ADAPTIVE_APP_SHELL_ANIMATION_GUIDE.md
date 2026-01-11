# شرح خصائص الحركة في AdaptiveAppShell

## الخصائص المُضافة

تم إضافة 3 خصائص للتحكم في حركة العناصر في SideBar:
(layoutDirection يُحسب تلقائياً من languageCode)

### 1. **layoutDirection** (TextDirection) ✅ **حسابي تلقائياً**
```dart
// لا حاجة لتمريره - يُحسب من languageCode
languageCode: 'ar'  // → layoutDirection: RTL (تلقائي)
languageCode: 'en'  // → layoutDirection: LTR (تلقائي)
```
- **العربية وغيرها من لغات RTL**: الحركة من اليمين لليسار ⬅️
- **باقي اللغات (LTR)**: الحركة من اليسار لليمين ➡️
- **الحساب**: يتم داخلياً بناءً على languageCode
- **اللغات المدعومة RTL**: ar, he, fa, ur, yi, ji, iw, ku

### 2. **animationDuration** (Duration)
```dart
animationDuration: const Duration(milliseconds: 300),
```
- **مدة الحركة الإجمالية** لكل عنصر
- **الخيارات الشائعة**:
  - `150ms`: سريع جداً ⚡
  - `200ms`: سريع 🔥
  - `300ms`: عادي (افتراضي) 👌
  - `500ms`: بطيء 🐌
  - `800ms`: بطيء جداً 🐢

### 3. **animationCurve** (Curve)
```dart
animationCurve: Curves.easeOutCubic,
```
- **منحنى التسارع والتبطيء**
- **الخيارات الموصى به**:
  - `Curves.easeOutCubic`: سريع ثم بطيء (الأفضل) ✨
  - `Curves.easeInOutCubic`: ناعم جداً من الطرفين 😌
  - `Curves.easeOut`: سريع ثم بطيء 🎯
  - `Curves.easeIn`: بطيء ثم سريع
  
- **خيارات مرحة**:
  - `Curves.bounceOut`: ارتدادية (زنبركية) 🎾
  - `Curves.elasticOut`: مرنة جداً 🎪
  
- **خيارات أخرى**:
  - `Curves.linear`: منتظمة (ممل)
  - `Curves.fastOutSlowIn`: سريع جداً ثم بطيء

### 4. **animationSlideDistance** (double)
```dart
animationSlideDistance: 50.0,
```
- **مسافة الانزلاق الأفقي** للحركة
- **القيم الموصى به**:
  - `20.0`: قليل جداً 🤏
  - `40.0`: قليل 👈
  - `50.0`: متوسط (افتراضي) 👌
  - `60.0`: كبير 👉
  - `80.0`: كبير جداً 🚀
  - `100.0+`: درامي جداً 🎬

## أمثلة الاستخدام

### مثال 1: العربية (RTL) - الإعداد الموصى به
```dart
AdaptiveAppShell(
  theme: SideBarNavigationTheames.light(),
  loclizationLangs: {},
  languageCode: 'ar',
  
  layoutDirection: TextDirection.rtl,
  animationDuration: const Duration(milliseconds: 300),
  animationCurve: Curves.easeOutCubic,
  animationSlideDistance: 50.0,
)
```

### مثال 2: حركة سريعة وخفيفة
```dart
AdaptiveAppShell(
  theme: SideBarNavigationTheames.light(),
  loclizationLangs: {},
  
  layoutDirection: TextDirection.rtl,
  animationDuration: const Duration(milliseconds: 200),
  animationCurve: Curves.easeOutQuad,
  animationSlideDistance: 35.0,
)
```

### مثال 3: حركة بطيئة وناعمة
```dart
AdaptiveAppShell(
  theme: SideBarNavigationTheames.light(),
  loclizationLangs: {},
  
  layoutDirection: TextDirection.rtl,
  animationDuration: const Duration(milliseconds: 500),
  animationCurve: Curves.easeInOutCubic,
  animationSlideDistance: 70.0,
)
```

### مثال 4: حركة مرحة وارتدادية
```dart
AdaptiveAppShell(
  theme: SideBarNavigationTheames.light(),
  loclizationLangs: {},
  
  layoutDirection: TextDirection.rtl,
  animationDuration: const Duration(milliseconds: 600),
  animationCurve: Curves.bounceOut,
  animationSlideDistance: 65.0,
)
```

## كيف تعمل الخصائص معاً

```
layoutDirection (اتجاه)
        ↓
    تحديد: هل من اليسار أم اليمين
        ↓
animationSlideDistance (المسافة)
        ↓
    تحديد: كم مسافة تنزلق
        ↓
animationDuration (الوقت)
        ↓
    تحديد: في كم ثانية تتحرك
        ↓
animationCurve (المنحنى)
        ↓
    تحديد: كيفية التحرك (سريع/بطيء/ارتدادي...)
        ↓
النتيجة: حركة سلسة وجميلة ✨
```

## Static Methods للوصول إلى الخصائص

```dart
// في أي مكان بالتطبيق:
final layoutDir = AdaptiveAppShell.getLayoutDirection(context);
final duration = AdaptiveAppShell.getAnimationDuration(context);
final curve = AdaptiveAppShell.getAnimationCurve(context);
final slideDistance = AdaptiveAppShell.getAnimationSlideDistance(context);
```

## المميزات

✅ التحكم الكامل في الحركة من خارج الكود
✅ سهل التبديل بين إعدادات مختلفة
✅ دعم RTL و LTR
✅ متوافق مع جميع أنواع الحركات
✅ يعمل تلقائياً عند التهيئة

## التأثير على الأداء

- **الحركات السريعة (150-250ms)**: أفضل أداء ⚡
- **الحركات العادية (300-400ms)**: موازنة جيدة 👌
- **الحركات البطيئة (500ms+)**: قد تبدو بطيئة لكن سلسة 🎬

## نصائح الاستخدام

1. **للتطبيقات الاحترافية**: استخدم `easeOutCubic` 👔
2. **للتطبيقات المرحة**: استخدم `bounceOut` أو `elasticOut` 🎉
3. **للتطبيقات الهادئة**: استخدم `easeInOutCubic` مع `500ms` 🧘
4. **للتطبيقات السريعة**: استخدم `easeOutQuad` مع `200ms` 🚀

## التوافقية

- ✅ يعمل مع `SideBarNavigationTheames.light()`
- ✅ يعمل مع `SideBarNavigationTheames.dark()`
- ✅ يعمل مع جميع اللغات (LTR و RTL)
- ✅ يعمل على جميع أحجام الشاشات
