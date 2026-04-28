# دليل استخدام لوحة التحكم الموجهة (Routed Control Panel)

هذا الدليل يشرح كيفية استخدام مكون `AdaptiveAppShell` لبناء لوحة تحكم سريعة الاستجابة (Responsive Control Panel) تدعم الشريط الجانبي (Sidebar)، التوجيه (Routing) باستخدام `go_router`، الثيمات الديناميكية، وإدارة حالة المصادقة (Auth).

## 1. ما هو `AdaptiveAppShell`؟

`AdaptiveAppShell` هو ويدجت أساسي يمثل الهيكل العام للتطبيق. يتكيف تلقائيًا مع أحجام الشاشات المختلفة:
- **شاشات الموبايل (Small Screens):** يعرض `AppBar` مع `Drawer` منزلق أو شريط تنقل سفلي `BottomNavigationBar`.
- **شاشات الديسكتوب/التابلت (Large Screens):** يعرض شريطًا جانبيًا (Sidebar) ثابتًا بجوار محتوى الصفحة.

## 2. كيفية الاستخدام (Initialization)

لتهيئة التطبيق، ستحتاج إلى بناء نقطة الإطلاق (App Launcher) وتمرير إعدادات الشريط الجانبي ومزودات الحالة (Bloc Providers).

إليك المثال الشامل لكيفية استخدام `AdaptiveAppShell` داخل ملف نقطة البداية لتطبيقك:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

// استيراد الحزم الخاصة بالقالب والمشروع
import 'package:JoDija_tamplites/tampletes/screens/routed_contral_panal/laaunser.dart';
import 'package:delta_mager_pro_mangement_app/configs/sidbarItmes.dart' show SidebarItemsConfig;
import 'package:delta_mager_pro_mangement_app/configs/app_shell_config.dart';
import 'package:delta_mager_pro_mangement_app/configs/ui_configs.dart';
import 'package:delta_mager_pro_mangement_app/consts/constants/theme/app_theme.dart';
import 'package:delta_mager_pro_mangement_app/consts/constants/values/strings.dart';
// ... وغيرها من الـ Blocs والـ Repositories

class AppLouncher extends StatefulWidget {
  const AppLouncher({super.key});

  @override
  State<AppLouncher> createState() => _AppLouncherState();
}

class _AppLouncherState extends State<AppLouncher> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // تعريف الـ Blocs الأساسية التي ستعمل قبل بناء الـ Router
        BlocProvider(create: (context) => OrganizationConfigBloc(repo: sl<OrganizationRepo>())),
      ],
      child: BlocBuilder<OrganizationConfigBloc, FeaturDataSourceState<OrganizationConfigModel>>(
        builder: (context, state) {
          return AdaptiveAppShell(
            // 1. المسار المبدئي للتطبيق
            initRouter: AppShellConfigs.initRouter,
            
            // 2. مزودات الحالة الإضافية للـ Blocs والـ Providers التي يحتاجها المشروع
            extraProvidersAndBlocs: [
              ChangeNotifierProvider(create: (context) => AppChangesValues()),
              BlocProvider(
                create: (context) => AuthBloc(
                  authRepo: sl<AuthRepo>(),
                  appChangesValues: context.read<AppChangesValues>(),
                ),
              ),
              // ...
            ],
            
            // 3. خصائص التطبيق العامة
            titleApp: AppStrings.appName,
            languageCode: AppShellConfigs.languageCode, // يدعم RTL / LTR تلقائياً
            debugShowCheckedModeBanner: AppShellConfigs.debugShowCheckedModeBanner,
            
            // 4. ألوان وتصميم الشريط الجانبي
            sidebarBackgroundColor: AppShellConfigs.isDarkMode ? AppColors.darkBackground : AppColors.background,
            sidebarTextColor: AppShellConfigs.isDarkMode ? AppColors.darkTextPrimary : AppColors.darkText,
            sidebarSelectedColor: AppColors.primary,
            sidebarSelectedIconColor: AppColors.secondary,
            // (باقي الألوان للـ Hover والـ Expanded)
            
            // 5. خصائص الحركة (Animation) للشريط الجانبي وصفحاته
            animationDuration: AppShellConfigs.animationDuration,
            animationType: AppShellConfigs.animationType,
            
            // 6. تهيئة الثيمات
            darkTheme: AppTheme.darkTheme,
            lightTheme: AppTheme.lightTheme,
            isDarkMode: AppShellConfigs.isDarkMode,
            
            // 7. إعدادات AppBar لجميع أحجام الشاشات
            smallScreenAppBar: AppBarConfigs.buildSmallScreenAppBar(context),
            largeScreenAppBar: AppBarConfigs.buildLargeScreenAppBar(context),
            showAppBarOnSmallScreen: AppShellConfigs.showAppBarOnSmallScreen,
            showAppBarOnLargeScreen: AppShellConfigs.showAppBarOnLargeScreen,
            
            // 8. عناصر الشريط الجانبي والمسارات (Routes Config)
            sidebarItems: SidebarItemsConfig().items,
            
            // 9. إعدادات الترجمة واللغات (Localization)
            loclizationLangs: LocalizationConfigs.buildLocalizations(),
            // ويدجت الشاشة التي تظهر في حالة حدوث خطأ
            errorScreen: ErrorsScreen(),
          );
        },
      ),
    );
  }
}
```

## 3. تكوين عناصر الشريط الجانبي والتوجيه (`RouteItem`)

المتغير `sidebarItems` يقبل قائمة من كائنات `RouteItem`. كل كائن يمثل صفحة ومسارًا في التطبيق ويحدد شكل ظهورها في الشريط الجانبي وسلوكها أثناء التصفح.
يتم تعريف كل عنصر هكذا:

```dart
RouteItem(
  id: "dashboard",
  path: "/dashboard",        // مسار التوجيه
  label: "لوحة القيادة",      // النص الظاهر في الشريط الجانبي أو الشريط العلوي
  icon: Icons.dashboard,     // الأيقونة المرافقة
  content: DashboardScreen(), // محتوى الشاشة
  
  // خيارات العرض:
  isSideBarRouted: true,     // يحدد ما إذا كانت هذه الشاشة موجهة وتظهر داخل غلاف التطبيق الجانبي
  isVisableInSideBar: true,  // إخفاء أو إظهار العنصر بصرياً من الشريط الجانبي (مع بقائه مساراً فعالاً)
  isAppBar: true,            // عرض شريط علوي (AppBar) في هذه الشاشة
  isDrawerShow: true,        // إمكانية ظهور الـ Drawer على الشاشات الصغيرة
  isInBottomNavBar: false,   // إظهار العنصر في شريط التنقل السفلي (للشاشات الصغيرة فقط)
  
  // خيارات عنوان AppBar:
  isDesplayTitleInLargScreen: true,
  isDesplayTitleInSmallScreen: true,
  
  // معاملات إضافية للتوجيه:
  prams: {"id": 1},
)
```

## 4. التنقل بين الصفحات (`AppShellRouterMixin`)

يأتي القالب مع `AppShellRouterMixin` ليسهل عملية التنقل والحصول على المعاملات (Parameters/Queries) من داخل الـ `StatefulWidget`.

```dart
import 'package:JoDija_tamplites/tampletes/screens/routed_contral_panal/utiles/side_bar_navigation_router.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with AppShellRouterMixin {
  
  @override
  void initState() {
    super.initState();
    // يمكنك الوصول للمعاملات من المسار مباشرة
    print(getPrams()); 
    print(getQuery());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                // التنقل العادي يعتمد على مسار go_router
                goRoute(context, "/settings");
              },
              child: const Text("الذهاب للإعدادات"),
            ),
            ElevatedButton(
              onPressed: () {
                // التنقل مع استبدال الصفحة الحالية
                goRoute(context, "/login", replace: true);
              },
              child: const Text("تسجيل الخروج"),
            ),
            ElevatedButton(
              onPressed: () {
                // الرجوع للصفحة السابقة
                goPop(context);
              },
              child: const Text("رجوع"),
            ),
          ],
        ),
      ),
    );
  }
}
```

## 5. ملاحظات هامة حول الهيكلة

* **Responsive Design:** الشاشة الرئيسية (`MainScreen`) تقوم بشكل تلقائي باختبار `isScreenSmall`. إذا كانت الشاشة صغيرة (مثل الموبايل) تعرض الـ Sidebar على هيئة `Drawer` (أو شريط سفلي إذا حُدد `isInBottomNavBar`). وإلا، يظل الـ `Sidebar` عنصراً ثابتاً بجانب المحتوى.
* **Providers Support:** يمكن تمرير قائمة من `MultiBlocProvider` و `ChangeNotifierProvider` تحت البارميتر `extraProvidersAndBlocs` داخل `AdaptiveAppShell`.
* **Theming Context:** إعدادات الألوان (مثل Theme و Dark Theme و Sidebar Custom Colors) معزولة بشكل ممتاز ليتم حقنها داخل شاشتك. يتم ذلك من خلال Singleton Classes و Providers داخل `AdaptiveAppShell`.
