# ScreenUtils - دليل الاستخدام الشامل

## نظرة عامة

`ScreenUtils` هو نظام متكامل لإنشاء واجهات مستخدم متجاوبة (Responsive) في Flutter باستخدام `MediaQuery` الأصلية، دون الحاجة لأي مكتبات خارجية.

## نقاط التوقف (Breakpoints)

| الجهاز | العرض | الوصف |
|--------|-------|-------|
| Mobile | < 600px | الهواتف المحمولة |
| Tablet | 600px - 1200px | الأجهزة اللوحية |
| Desktop | >= 1200px | أجهزة سطح المكتب |

## المحتويات

- [فحص حجم الشاشة](#فحص-حجم-الشاشة)
- [Extensions على الأرقام](#extensions-على-الأرقام)
- [Padding و EdgeInsets](#padding-و-edgeinsets)
- [المسافات بين العناصر](#المسافات-بين-العناصر)
- [أمثلة عملية](#أمثلة-عملية)

---

## فحص حجم الشاشة

### التحقق من نوع الجهاز

```dart
// التحقق من الموبايل
if (ScreenUtils.isMobile(context)) {
  return MobileLayout();
}

// التحقق من التابلت
if (ScreenUtils.isTablet(context)) {
  return TabletLayout();
}

// التحقق من الديسكتوب
if (ScreenUtils.isDesktop(context)) {
  return DesktopLayout();
}
```

### تخطيط بسيط (صغير/كبير)

```dart
// للتخطيطات البسيطة ذات التصميمين فقط
return ScreenUtils.isSmallScreen(context)
    ? Column(children: widgets)  // موبايل: عمودي
    : Row(children: widgets);    // تابلت/ديسكتوب: أفقي
```

### الحصول على قيم متجاوبة

```dart
// قيم مختلفة حسب حجم الشاشة
final fontSize = ScreenUtils.responsive<double>(
  context: context,
  mobile: 14.0,
  tablet: 16.0,
  desktop: 18.0,
);

// عدد الأعمدة في Grid
final columns = ScreenUtils.responsive<int>(
  context: context,
  mobile: 1,   // عمود واحد على الموبايل
  tablet: 2,   // عمودين على التابلت
  desktop: 3,  // ثلاثة أعمدة على الديسكتوب
);
```

---

## Extensions على الأرقام

### اصطلاحات التسمية

| البادئة | المعنى | المقياس |
|---------|--------|---------|
| `m` | Mobile base | 1x, 1.2x, 1.4x |
| `t` | Tablet base | 0.833x, 1x, 1.167x |
| `d` | Desktop base | 0.714x, 0.857x, 1x |

| اللاحقة | المعنى | الاستخدام |
|---------|--------|-----------|
| `h` | Height | الارتفاع |
| `w` | Width | العرض |
| `fs` | Font Size | حجم الخط |
| `p` | Padding | الحشو |
| `r` | Radius | زوايا الحدود |

### 1. الارتفاع (Height)

#### Mobile Base - `mh`
```dart
Container(
  height: 100.mh(context),
  // Mobile: 100px
  // Tablet: 120px (100 × 1.2)
  // Desktop: 140px (100 × 1.4)
)
```

#### Tablet Base - `th`
```dart
Container(
  height: 60.th(context),
  // Mobile: 50px (60 ÷ 1.2)
  // Tablet: 60px
  // Desktop: 70px (60 × 1.167)
)
```

#### Desktop Base - `dh`
```dart
Container(
  height: 80.dh(context),
  // Mobile: 57.14px (80 ÷ 1.4)
  // Tablet: 68.57px (80 ÷ 1.167)
  // Desktop: 80px
)
```

### 2. العرض (Width)

#### Mobile Base - `mw`
```dart
Container(
  width: 200.mw(context),
  // Mobile: 200px
  // Tablet: 240px
  // Desktop: 280px
)
```

#### Tablet Base - `tw`
```dart
Container(
  width: 300.tw(context),
  // Mobile: 250px
  // Tablet: 300px
  // Desktop: 350px
)
```

#### Desktop Base - `dw`
```dart
Container(
  width: 400.dw(context),
  // Mobile: 285.71px
  // Tablet: 342.86px
  // Desktop: 400px
)
```

### 3. حجم الخط (Font Size) - `mfs`

```dart
Text(
  'مرحبا بك في التطبيق',
  style: TextStyle(
    fontSize: 16.mfs(context),
    // Mobile: 16
    // Tablet: 19.2 (16 × 1.2)
    // Desktop: 22.4 (16 × 1.4)
  ),
)
```

**أمثلة على أحجام الخطوط المقترحة:**

```dart
// عناوين رئيسية
Text('العنوان الرئيسي', style: TextStyle(fontSize: 32.mfs(context)))
// Mobile: 32, Tablet: 38.4, Desktop: 44.8

// عناوين فرعية
Text('عنوان فرعي', style: TextStyle(fontSize: 24.mfs(context)))
// Mobile: 24, Tablet: 28.8, Desktop: 33.6

// نص عادي
Text('نص المحتوى', style: TextStyle(fontSize: 16.mfs(context)))
// Mobile: 16, Tablet: 19.2, Desktop: 22.4

// نص صغير
Text('ملاحظة', style: TextStyle(fontSize: 12.mfs(context)))
// Mobile: 12, Tablet: 14.4, Desktop: 16.8
```

### 4. الحشو (Padding) - `mp`

**ملاحظة:** الـ Padding يتضاعف بشكل أكبر (1x, 1.5x, 2x)

```dart
Container(
  padding: EdgeInsets.all(16.mp(context)),
  // Mobile: 16px
  // Tablet: 24px (16 × 1.5)
  // Desktop: 32px (16 × 2.0)
)

// استخدام مع EdgeInsets.only
Container(
  padding: EdgeInsets.only(
    left: 10.mp(context),    // 10, 15, 20
    right: 10.mp(context),   // 10, 15, 20
    top: 20.mp(context),     // 20, 30, 40
    bottom: 20.mp(context),  // 20, 30, 40
  ),
)
```

### 5. زوايا الحدود (Radius) - `mr`

```dart
Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12.mr(context)),
    // Mobile: 12px
    // Tablet: 14.4px (12 × 1.2)
    // Desktop: 16.8px (12 × 1.4)
    color: Colors.blue,
  ),
)

// زوايا محددة فقط
Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(16.mr(context)),
      topRight: Radius.circular(16.mr(context)),
    ),
  ),
)
```

---

## Padding و EdgeInsets

### 1. Padding لجميع الجوانب - `mpAll`

```dart
Container(
  padding: 16.mpAll(context),
  // يساوي: EdgeInsets.all(16.mp(context))
  // Mobile: EdgeInsets.all(16)
  // Tablet: EdgeInsets.all(24)
  // Desktop: EdgeInsets.all(32)
  child: Text('محتوى'),
)
```

### 2. Padding أفقي - `mpH`

```dart
Container(
  padding: 20.mpH(context),
  // يساوي: EdgeInsets.symmetric(horizontal: 20.mp(context))
  // Mobile: horizontal 20
  // Tablet: horizontal 30
  // Desktop: horizontal 40
  child: Row(children: [...]),
)
```

### 3. Padding عمودي - `mpV`

```dart
Container(
  padding: 12.mpV(context),
  // يساوي: EdgeInsets.symmetric(vertical: 12.mp(context))
  // Mobile: vertical 12
  // Tablet: vertical 18
  // Desktop: vertical 24
  child: Column(children: [...]),
)
```

---

## المسافات بين العناصر

### 1. مسافة عمودية - `vSpace`

```dart
Column(
  children: [
    Text('العنوان'),
    16.vSpace(context),  // SizedBox(height: 16/19.2/22.4)
    Text('النص الأول'),
    24.vSpace(context),  // SizedBox(height: 24/28.8/33.6)
    Text('النص الثاني'),
    32.vSpace(context),  // SizedBox(height: 32/38.4/44.8)
    ElevatedButton(
      onPressed: () {},
      child: Text('زر'),
    ),
  ],
)
```

### 2. مسافة أفقية - `hSpace`

```dart
Row(
  children: [
    Icon(Icons.home),
    8.hSpace(context),   // SizedBox(width: 8/9.6/11.2)
    Text('الرئيسية'),
    16.hSpace(context),  // SizedBox(width: 16/19.2/22.4)
    Icon(Icons.settings),
    8.hSpace(context),
    Text('الإعدادات'),
  ],
)
```

---

## أمثلة عملية

### مثال 1: بطاقة منتج متجاوبة

```dart
Widget buildProductCard(BuildContext context) {
  return Container(
    width: 300.mw(context),
    padding: 16.mpAll(context),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12.mr(context)),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          blurRadius: 8.mr(context),
          color: Colors.black12,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // صورة المنتج
        Container(
          height: 200.mh(context),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.mr(context)),
            image: DecorationImage(
              image: AssetImage('assets/product.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        
        16.vSpace(context),
        
        // اسم المنتج
        Text(
          'اسم المنتج',
          style: TextStyle(
            fontSize: 20.mfs(context),
            fontWeight: FontWeight.bold,
          ),
        ),
        
        8.vSpace(context),
        
        // وصف المنتج
        Text(
          'وصف تفصيلي للمنتج مع جميع المميزات',
          style: TextStyle(
            fontSize: 14.mfs(context),
            color: Colors.grey[600],
          ),
        ),
        
        16.vSpace(context),
        
        // السعر والزر
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '99.99 ر.س',
              style: TextStyle(
                fontSize: 18.mfs(context),
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.mp(context),
                  vertical: 8.mp(context),
                ),
                child: Text(
                  'أضف للسلة',
                  style: TextStyle(fontSize: 14.mfs(context)),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
```

### مثال 2: نموذج تسجيل دخول متجاوب

```dart
Widget buildLoginForm(BuildContext context) {
  return Container(
    width: 400.mw(context),
    padding: 24.mpAll(context),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16.mr(context)),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          blurRadius: 20.mr(context),
          color: Colors.black26,
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // الشعار
        Icon(
          Icons.account_circle,
          size: 80.mw(context),
          color: Colors.blue,
        ),
        
        24.vSpace(context),
        
        // العنوان
        Text(
          'تسجيل الدخول',
          style: TextStyle(
            fontSize: 28.mfs(context),
            fontWeight: FontWeight.bold,
          ),
        ),
        
        32.vSpace(context),
        
        // حقل البريد الإلكتروني
        TextField(
          decoration: InputDecoration(
            labelText: 'البريد الإلكتروني',
            labelStyle: TextStyle(fontSize: 14.mfs(context)),
            contentPadding: 12.mpAll(context),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.mr(context)),
            ),
          ),
        ),
        
        16.vSpace(context),
        
        // حقل كلمة المرور
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'كلمة المرور',
            labelStyle: TextStyle(fontSize: 14.mfs(context)),
            contentPadding: 12.mpAll(context),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.mr(context)),
            ),
          ),
        ),
        
        24.vSpace(context),
        
        // زر تسجيل الدخول
        SizedBox(
          width: double.infinity,
          height: 48.mh(context),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.mr(context)),
              ),
            ),
            child: Text(
              'دخول',
              style: TextStyle(fontSize: 16.mfs(context)),
            ),
          ),
        ),
        
        16.vSpace(context),
        
        // رابط نسيت كلمة المرور
        TextButton(
          onPressed: () {},
          child: Text(
            'نسيت كلمة المرور؟',
            style: TextStyle(fontSize: 14.mfs(context)),
          ),
        ),
      ],
    ),
  );
}
```

### مثال 3: تخطيط متجاوب (Responsive Layout)

```dart
Widget buildResponsiveLayout(BuildContext context) {
  return Scaffold(
    body: ScreenUtils.isSmallScreen(context)
        ? _buildMobileLayout(context)
        : _buildDesktopLayout(context),
  );
}

// تخطيط الموبايل (عمودي)
Widget _buildMobileLayout(BuildContext context) {
  return SingleChildScrollView(
    padding: 16.mpAll(context),
    child: Column(
      children: [
        _buildHeader(context),
        16.vSpace(context),
        _buildContent(context),
        16.vSpace(context),
        _buildSidebar(context),
      ],
    ),
  );
}

// تخطيط الديسكتوب (أفقي)
Widget _buildDesktopLayout(BuildContext context) {
  return Row(
    children: [
      // Sidebar
      Container(
        width: 300.dw(context),
        child: _buildSidebar(context),
      ),
      
      24.hSpace(context),
      
      // Main content
      Expanded(
        child: SingleChildScrollView(
          padding: 24.mpAll(context),
          child: Column(
            children: [
              _buildHeader(context),
              24.vSpace(context),
              _buildContent(context),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _buildHeader(BuildContext context) {
  return Container(
    padding: 20.mpAll(context),
    decoration: BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(12.mr(context)),
    ),
    child: Text(
      'العنوان',
      style: TextStyle(
        fontSize: 24.mfs(context),
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _buildContent(BuildContext context) {
  return Container(
    padding: 16.mpAll(context),
    child: Text(
      'المحتوى الرئيسي للصفحة...',
      style: TextStyle(fontSize: 16.mfs(context)),
    ),
  );
}

Widget _buildSidebar(BuildContext context) {
  return Container(
    padding: 16.mpAll(context),
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(12.mr(context)),
    ),
    child: Column(
      children: [
        Text(
          'القائمة الجانبية',
          style: TextStyle(
            fontSize: 18.mfs(context),
            fontWeight: FontWeight.bold,
          ),
        ),
        16.vSpace(context),
        // عناصر القائمة...
      ],
    ),
  );
}
```

### مثال 4: Grid متجاوب

```dart
Widget buildResponsiveGrid(BuildContext context) {
  final crossAxisCount = ScreenUtils.responsive<int>(
    context: context,
    mobile: 1,    // عمود واحد على الموبايل
    tablet: 2,    // عمودين على التابلت
    desktop: 3,   // ثلاثة أعمدة على الديسكتوب
  );

  return GridView.builder(
    padding: 16.mpAll(context),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: 16.mp(context),
      mainAxisSpacing: 16.mp(context),
      childAspectRatio: 0.75,
    ),
    itemCount: 20,
    itemBuilder: (context, index) {
      return buildProductCard(context);
    },
  );
}
```

---

## جدول المقاييس السريع

### Mobile Base (الأكثر استخداماً)

| القيمة | Mobile | Tablet | Desktop |
|--------|--------|--------|---------|
| `100.mw` | 100 | 120 | 140 |
| `50.mh` | 50 | 60 | 70 |
| `16.mfs` | 16 | 19.2 | 22.4 |
| `16.mp` | 16 | 24 | 32 |
| `12.mr` | 12 | 14.4 | 16.8 |

### Tablet Base

| القيمة | Mobile | Tablet | Desktop |
|--------|--------|--------|---------|
| `100.tw` | 83.33 | 100 | 116.7 |
| `60.th` | 50 | 60 | 70 |

### Desktop Base

| القيمة | Mobile | Tablet | Desktop |
|--------|--------|--------|---------|
| `400.dw` | 285.71 | 342.86 | 400 |
| `80.dh` | 57.14 | 68.57 | 80 |

---

## نصائح الاستخدام

### 1. اختيار المقياس الأساسي

- استخدم **Mobile Base** (`m`) عند التصميم للموبايل أولاً (الأكثر شيوعاً)
- استخدم **Tablet Base** (`t`) عند التصميم للتابلت أولاً
- استخدم **Desktop Base** (`d`) عند التصميم للديسكتوب أولاً

### 2. الاتساق

```dart
// ✅ جيد: استخدام نفس المقياس في كل المشروع
Container(
  width: 300.mw(context),
  height: 200.mh(context),
  padding: 16.mpAll(context),
)

// ❌ سيء: خلط المقاييس بدون سبب
Container(
  width: 300.tw(context),  // tablet base
  height: 200.mh(context), // mobile base
  padding: 16.mpAll(context),
)
```

### 3. الأحجام المقترحة

**للـ Padding:**
- صغير: `8.mp(context)` → 8, 12, 16
- متوسط: `16.mp(context)` → 16, 24, 32
- كبير: `24.mp(context)` → 24, 36, 48

**للـ Spacing:**
- صغير: `8.vSpace(context)` → 8, 9.6, 11.2
- متوسط: `16.vSpace(context)` → 16, 19.2, 22.4
- كبير: `32.vSpace(context)` → 32, 38.4, 44.8

**للـ Border Radius:**
- صغير: `4.mr(context)` → 4, 4.8, 5.6
- متوسط: `8.mr(context)` → 8, 9.6, 11.2
- كبير: `16.mr(context)` → 16, 19.2, 22.4

---

## معلومات إضافية

### الحصول على معلومات الجهاز

```dart
// عرض الشاشة
double width = ScreenUtils.getScreenWidth(context);

// ارتفاع الشاشة
double height = ScreenUtils.getScreenHeight(context);

// الاتجاه
bool isLandscape = ScreenUtils.isLandscape(context);
bool isPortrait = ScreenUtils.isPortrait(context);

// Safe Area
EdgeInsets safeArea = ScreenUtils.getSafeAreaPadding(context);

// نسبة البكسل
double pixelRatio = ScreenUtils.getPixelRatio(context);

// معامل حجم النص
double textScale = ScreenUtils.getTextScaleFactor(context);

// التحقق من ظهور لوحة المفاتيح
bool isKeyboardVisible = ScreenUtils.isKeyboardVisible(context);

// الارتفاع المتاح (بدون لوحة المفاتيح)
double availableHeight = ScreenUtils.getAvailableHeight(context);
```

### عرض الـ Sidebar

```dart
Drawer(
  width: ScreenUtils.getSidebarWidth(
    context,
    mobileWidth: 250,
    tabletWidth: 300,
    desktopWidth: 350,
  ),
  child: ListView(...),
)
```

---

## الخلاصة

`ScreenUtils` يوفر لك:

✅ تصميمات متجاوبة بدون مكتبات خارجية  
✅ كود أقصر وأسهل في القراءة  
✅ Extensions سهلة الاستخدام على الأرقام  
✅ مقاييس متسقة عبر التطبيق  
✅ توثيق شامل مع أمثلة  

**البداية السريعة:**

```dart
import 'package:your_app/utils/screen_utils.dart';

// استخدم في أي مكان
Container(
  width: 200.mw(context),
  height: 100.mh(context),
  padding: 16.mpAll(context),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12.mr(context)),
  ),
  child: Text(
    'مرحبا',
    style: TextStyle(fontSize: 16.mfs(context)),
  ),
)
```

---

**تم إنشاؤه بواسطة:** ScreenUtils  
**التاريخ:** نوفمبر 2025  
**الإصدار:** 1.0.0
