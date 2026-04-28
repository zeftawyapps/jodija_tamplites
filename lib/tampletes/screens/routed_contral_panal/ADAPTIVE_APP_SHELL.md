# وثيقة استخدام AdaptiveAppShell

هذه الوثيقة تشرح كيفية استخدام وتخصيص نظام الـ **AdaptiveAppShell**، وهو نظام متكامل لإدارة واجهة التطبيق (Sidebar, AppBar, Layout) مع دعم كامل للـ Routing والـ Themes والـ Localization.

---

## 1. المكون الأساسي: `AdaptiveAppShell`

هو الوجت (Widget) الرئيسي الذي يغلف التطبيق ويوفر البنية التحتية اللازمة.

### أهم الخصائص (Properties):

| الخاصية | النوع | الوصف |
| :--- | :--- | :--- |
| `titleApp` | `String` | عنوان التطبيق. |
| `sidebarItems` | `List<RouteItem>` | قائمة العناصر التي ستظهر في القائمة الجانبية (Sidebar). |
| `extraProvidersAndBlocs` | `List<SingleChildWidget>` | قائمة الـ Providers أو الـ Blocs الإضافية التي تريد حقنها على مستوى التطبيق. |
| `lightTheme` / `darkTheme` | `ThemeData` | تخصيص الثيمات الفاتحة والداكنة. |
| `isDarkMode` | `bool` | تحديد ما إذا كان التطبيق سيبدأ بالوضع الليلة. |
| `languageCode` | `String` | لغة التطبيق الافتراضية (مثلاً 'ar' أو 'en'). |
| `loclizationLangs` | `Map<String, AppLocalizationsInit>` | خريطة اللغات المدعومة وإعدادات الترجمة. |
| `sidebarHeader` | `SidebarHeaderConfig` | إعدادات رأس القائمة الجانبية (الشعار، العنوان). |
| `smallScreenAppBar` | `AppBarConfig` | إعدادات الـ AppBar للشاشات الصغيرة. |
| `largeScreenAppBar` | `AppBarConfig` | إعدادات الـ AppBar للشاشات الكبيرة. |
| `animationType` | `SidBarAnimationType` | نوع حركة ظهور العناصر في القائمة (slide, fade, scale, etc.). |

---

## 2. تعريف المسارات: `RouteItem`

يستخدم لتعريف كل صفحة في التطبيق وكيفية ظهورها في القائمة الجانبية.

```dart
RouteItem({
  required this.id,             // معرف فريد للمسار
  required this.path,           // المسار (الرابط) الخاص بالصفحة
  required this.label,          // النص الذي يظهر في القائمة
  required this.icon,           // الأيقونة
  required this.content,        // الوجت (الصفحة) التي سيتم عرضها
  this.isSideBarRouted = true,  // هل يتم الانتقال للصفحة عند الضغط؟
  this.isInBottomNavBar = false, // هل تظهر في شريط التنقل السفلي؟
  this.parentName = "",         // اسم العنصر الأب (لعمل قوائم منسدلة)
})
```

---

## 3. تخصيص رأس القائمة: `SidebarHeaderConfig`

يسمح لك `SidebarHeaderConfig` بتخصيص الجزء العلوي من القائمة الجانبية (Sidebar) بسهولة، سواء بإضافة شعار (Logo)، عنوان (Title)، أو حتى تصميم واجهة مخصصة بالكامل.

### الخصائص (Properties):

| الخاصية | النوع | الافتراضي | الوصف |
| :--- | :--- | :--- | :--- |
| `title` | `String?` | `null` | النص الذي يظهر كعنوان في الهيدر. |
| `titleStyle` | `TextStyle?` | `null` | تنسيق الخط الخاص بالعنوان. |
| `logoAssetPath` | `String?` | `null` | مسار صورة الشعار من ملفات المشروع (Assets). |
| `logoNetworkUrl` | `String?` | `null` | رابط صورة الشعار من الإنترنت. |
| `logoHight` | `double` | `60.0` | ارتفاع الشعار. |
| `logoWidth` | `double` | `60.0` | عرض الشعار. |
| `logoFit` | `BoxFit` | `BoxFit.contain` | طريقة احتواء الصورة داخل الإطار. |
| `logoRadius` | `BorderRadius?` | `null` | تدوير حواف الشعار. |
| `height` | `double` | `80.0` | الارتفاع الكلي للهيدر. |
| `padding` | `EdgeInsetsGeometry` | `EdgeInsets.all(16)` | المسافات الداخلية للهيدر. |
| `backgroundColor` | `Color?` | `null` | لون خلفية الهيدر. |
| `alignment` | `Alignment` | `Alignment.center` | محاذاة المحتوى داخل الهيدر. |
| `customHeaderWidget` | `Widget?` | `null` | إذا تم توفيره، سيتم تجاهل كل الخصائص أعلاه وعرض هذا الوجت بدلاً منها. |

### مثال على الاستخدام:

```dart
SidebarHeaderConfig(
  title: "لوحة التحكم",
  logoAssetPath: "assets/images/logo.png",
  logoHight: 50,
  backgroundColor: Colors.blueAccent,
  titleStyle: TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 18,
  ),
)
```

**أو استخدام واجهة مخصصة بالكامل:**

```dart
SidebarHeaderConfig(
  customHeaderWidget: UserAccountsDrawerHeader(
    accountName: Text("اسم المستخدم"),
    accountEmail: Text("user@example.com"),
    currentAccountPicture: CircleAvatar(child: Icon(Icons.person)),
  ),
)
```

---

## 4. إعدادات الـ AppBar: `AppBarConfig`

يستخدم لتخصيص الـ AppBar بشكل مرن للشاشات الصغيرة والكبيرة.

- **الخصائص:** الـ `title`, `actions`, `leading`, `backgroundColor`, وغيره من خصائص الـ AppBar القياسية.

---

## 5. حقن الـ Providers والـ Blocs

لقد قمنا بإضافة خاصية `extraProvidersAndBlocs` لتسهيل إضافة أي نظام إدارة حالة خارجي.

**مثال على الاستخدام:**

```dart
AdaptiveAppShell(
  extraProvidersAndBlocs: [
    // إضافة Bloc
    BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(),
    ),
    // إضافة Provider
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
  ],
  // ... باقي الإعدادات
)
```

---

## 6. حركات الأنيميشن (Animations)

يدعم النظام عدة أنواع من الحركات للعناصر الجانبية من خلال `SidBarAnimationType`:
- `slideAndFade`: انزلاق مع تلاشي (Default).
- `scaleUp`: تكبير من الصفر.
- `rotateAndScale`: دوران مع تكبير.
- وخرائط أخرى مثل `slideFromTop`, `fadeOnly`, إلخ.

---

## 7. التحكم في الحالة (State Management)

يوفر النظام `Providers` داخلية يمكن الوصول إليها بـ `context`:
- `SettingsProvider`: للتحكم في اللغة والوضع الليلي.
- `AppShellRouterProvider`: لإدارة التنقل والمسارات.
- `StatusProvider`: لمتابعة حالة التطبيق.

---

> [!TIP]
> جميع المكونات مصممة لتكون **Responsive**، بحيث تتغير طريقة العرض تلقائياً بين الموبايل (Drawer) والتابلت/الويب (Fixed Sidebar).
