# شرح خصائص الحركة في AdaptiveAppShell

## الخصائص المُضافة

تم إضافة 3 خصائص للتحكم في حركة العناصر في SideBar:
**layoutDirection يُحسب تلقائياً من languageCode** ✅

### 1. **layoutDirection** (TextDirection) ✅ **حسابي تلقائياً من languageCode**
```dart
// لا حاجة لتمريره - يُحسب من languageCode تلقائياً
languageCode: 'ar'  // → layoutDirection: RTL (تلقائي ⬅️)
languageCode: 'en'  // → layoutDirection: LTR (تلقائي ➡️)
languageCode: 'he'  // → layoutDirection: RTL (تلقائي ⬅️)
languageCode: 'fa'  // → layoutDirection: RTL (تلقائي ⬅️)
```
- **اللغات RTL** (العربية، العبرية، الفارسية، إلخ): الحركة من اليمين لليسار ⬅️
- **باقي اللغات**: الحركة من اليسار لليمين ➡️
- **الحساب**: يتم داخلياً بناءً على languageCode فقط
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
  languageCode: 'ar',  // ✅ layoutDirection: RTL (تلقائي)
  
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
  languageCode: 'ar',  // ✅ RTL تلقائياً
  
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
  languageCode: 'ar',  // ✅ RTL تلقائياً
  
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
  languageCode: 'ar',  // ✅ RTL تلقائياً
  
  animationDuration: const Duration(milliseconds: 600),
  animationCurve: Curves.bounceOut,
  animationSlideDistance: 65.0,
)
```

### مثال 5: English (LTR) - تلقائي
```dart
AdaptiveAppShell(
  theme: SideBarNavigationTheames.light(),
  loclizationLangs: {},
  languageCode: 'en',  // ✅ layoutDirection: LTR (تلقائي)
  
  animationDuration: const Duration(milliseconds: 300),
  animationCurve: Curves.easeOutCubic,
  animationSlideDistance: 50.0,
)
```

## كيف تعمل الخصائص معاً

```
languageCode (اللغة)
        ↓
    حساب layoutDirection تلقائياً
        ↓
layoutDirection (اتجاه الحركة)
        ↓
    تحديد: من اليسار أم من اليمين
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

## الاختلاف الأساسي ✨

### ❌ **القديم**:
```dart
AdaptiveAppShell(
  theme: SideBarNavigationTheames.light(),
  languageCode: 'ar',
  layoutDirection: TextDirection.rtl,  // ❌ يدويّ - قد ينسى المستخدم
  animationDuration: ...,
)
```

### ✅ **الجديد**:
```dart
AdaptiveAppShell(
  theme: SideBarNavigationTheames.light(),
  languageCode: 'ar',  // ✅ layoutDirection يُحسب تلقائياً من هنا
  animationDuration: ...,
)
```

## المميزات

✅ **لا الالتباس**: layoutDirection يُحسب من اللغة (اتحاد واحد)
✅ **أقل أخطاء**: لا يمكن عمل تضارب بين اللغة والاتجاه
✅ **أكثر سهولة**: كود أقل
✅ **أكثر منطقية**: اللغة تحدد الاتجاه دائماً
✅ **دعم RTL و LTR**: تلقائي للغات المدعومة

## التأثير على الأداء

- **الحركات السريعة (150-250ms)**: أفضل أداء ⚡
- **الحركات العادية (300-400ms)**: موازنة جيدة 👌
- **الحركات البطيئة (500ms+)**: قد تبدو بطيئة لكن سلسة 🎬

## نصائح الاستخدام

1. **ضع اللغة الصحيحة دائماً**: 'ar' للعربية، 'en' للإنجليزية
2. **layoutDirection يُحسب تلقائياً**: لا حاجة لتمريره يدويّاً
3. **اختبر مع لغات مختلفة**: تأكد من أن RTL يعمل
4. **استخدم animationCurve المناسب**: easeOutCubic للاحترافية

## التوافقية

- ✅ يعمل مع `SideBarNavigationTheames.light()`
- ✅ يعمل مع `SideBarNavigationTheames.dark()`
- ✅ يعمل مع جميع اللغات (LTR و RTL)
- ✅ يعمل على جميع أحجام الشاشات

## اللغات المدعومة RTL

| اللغة | الكود | الاتجاه |
|------|------|--------|
| العربية | ar | RTL ⬅️ |
| العبرية | he | RTL ⬅️ |
| الفارسية | fa | RTL ⬅️ |
| الأردية | ur | RTL ⬅️ |
| اليديشية | yi | RTL ⬅️ |
| الجيم | ji | RTL ⬅️ |
| العبرية (بديل) | iw | RTL ⬅️ |
| الكردية | ku | RTL ⬅️ |
| **باقي اللغات** | en, fr, etc | LTR ➡️ |
