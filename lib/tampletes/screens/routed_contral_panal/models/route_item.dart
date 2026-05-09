import 'package:flutter/material.dart';

import '../utiles/side_bar_navigation_router.dart';

/// نموذج عنصر الشريط الجانبي
class RouteItem {
  /// المعرف الفريد للعنصر.
  /// The unique identifier for the route item.
  final String id;
  
  /// مسار التوجيه (Route Path).
  /// The routing path for this item.
  final String path; // Make path optional for non-routed items
  
  /// الاسم أو النص الذي سيظهر للمستخدم في واجهة القائمة.
  /// The label or text that will be displayed to the user.
  final String label;
  
  /// الأيقونة الخاصة بهذا العنصر.
  /// The icon associated with this route item.
  final IconData icon;
  
  /// المحتوى أو الشاشة (Widget) التي سيتم عرضها عند اختيار هذا العنصر.
  /// The content or screen (Widget) to display when this item is selected.
  final Widget content;
  
  /// هل يمتلك هذا العنصر شريط علوي (AppBar) خاص به أم لا.
  /// Whether this item has its own app bar.
  bool isAppBar;
  
  /// هل يتم إظهار القائمة الجانبية المصغرة (Drawer) مع هذا العنصر.
  /// Whether to show the drawer when this item is active.
  bool isDrawerShow;
  
  /// هل سيتم استخدام التوجيه الفعلي (Routing) عند الضغط، أم أنه مجرد زر تفاعلي عادي.
  /// Whether this item performs actual routing or just acts as a simple interactive button.
  bool isSideBarRouted;
  
  /// إخفاء هذا العنصر من القائمة الجانبية في الشاشات الصغيرة.
  /// Whether to hide this item from the sidebar on small screens.
  bool isUnViasibleInSideBarIfSmall = false;
  
  /// هل يتواجد هذا العنصر في شريط التنقل السفلي (Bottom Navigation Bar).
  /// Whether this item is part of the bottom navigation bar.
  bool isInBottomNavBar = false;
  
  /// اسم العنصر الأب إذا كان هذا العنصر فرعياً (Child).
  /// The name of the parent item if this is a child item.
  String parentName = "";
  
  /// أيقونة العنصر الأب (إن وجد).
  /// The icon of the parent item (if any).
  IconData? parentIcon;
  
  /// يتم تعيينه تلقائياً لـ true إذا تم تحديد اسم العنصر الأب.
  /// Automatically set to true if a parent name is provided.
  bool isChildItem = false;
  
  /// هل يتم عرض هذا العنصر في شريط التنقل العلوي (Top Navigation Bar).
  /// Whether to show this item in the top navigation bar.
  bool isInTopNavBar = false;
  
  /// هل تم استدعاء هذا المسار من القائمة الجانبية (للاستخدام الداخلي).
  /// Whether this route was called from the sidebar (internal usage).
  bool isCalledFromSideBar = false;
  
  /// هل يتم عرض العنوان (Title) في الشاشات الكبيرة.
  /// Whether to display the title on large screens.
  bool isDesplayTitleInLargScreen;
  
  /// هل يتم عرض العنوان (Title) في الشاشات الصغيرة.
  /// Whether to display the title on small screens.
  bool isDesplayTitleInSmallScreen; // Add flag to indicate if item should be routed

  /// هل يكون هذا العنصر مرئياً بداخل القائمة الجانبية أم مخفياً ليكون فقط مساراً داخلياً.
  /// Whether this item is visible in the sidebar, or hidden just as an internal programmable route.
  bool isVisableInSideBar = true;

  /// المتغيرات أو المعاملات المرفقة مع الرابط (مثال: id=5).
  /// Parameters attached to the route path.
  Map<String, dynamic>? prams;
  
  /// نسخة ثابتة (Constant Copy) من المعاملات للاستخدام الداخلي لمنع تغيرها بالخطأ.
  /// A constant copy of the parameters for internal usage.
  Map<String, dynamic>? constPrams;
  
  /// مسار ثابت (اختياري) يعتمد عليه كمرجع.
  /// Constant route parts (optional) used as reference.
  List<String>? constRoute;
  
  /// المعاملات التي تمرر عبر رابط الاستعلام (Query Parameters).
  /// The query parameters passed through the URL.
  Map<String, dynamic>? queryParameters;
  // Custom action for non-routed items

  RouteItem({
    /// المعرف الفريد للعنصر.
    /// The unique identifier for the route item.
    required this.id,
    /// مسار التوجيه (Route Path).
    /// The routing path for this item.
    required this.path,
    /// الاسم أو النص الذي سيظهر للمستخدم في واجهة القائمة.
    /// The label or text that will be displayed to the user.
    required this.label,
    /// الأيقونة الخاصة بهذا العنصر.
    /// The icon associated with this route item.
    required this.icon,
    /// المحتوى أو الشاشة (Widget) التي سيتم عرضها عند اختيار هذا العنصر.
    /// The content or screen (Widget) to display when this item is selected.
    required this.content,
    /// هل يتم عرض هذا العنصر في شريط التنقل العلوي (Top Navigation Bar).
    /// Whether to show this item in the top navigation bar.
    this.isInTopNavBar = false,
    /// اسم العنصر الأب إذا كان هذا العنصر فرعياً (Child).
    /// The name of the parent item if this is a child item.
    this.parentName = "",
    /// أيقونة العنصر الأب (إن وجد).
    /// The icon of the parent item (if any).
    this.parentIcon,
    /// هل يتواجد هذا العنصر في شريط التنقل السفلي (Bottom Navigation Bar).
    /// Whether this item is part of the bottom navigation bar.
    this.isInBottomNavBar = false,
    /// إخفاء هذا العنصر من القائمة الجانبية في الشاشات الصغيرة.
    /// Whether to hide this item from the sidebar on small screens.
    this.isUnViasibleInSideBarIfSmall = false,
    /// هل يمتلك هذا العنصر شريط علوي (AppBar) خاص به أم لا.
    /// Whether this item has its own app bar.
    this.isAppBar = true,
    /// هل يكون هذا العنصر مرئياً بداخل القائمة الجانبية أم مخفياً.
    /// Whether this item is visible in the sidebar.
    this.isVisableInSideBar = true,
    /// هل سيتم استخدام التوجيه الفعلي (Routing) عند الضغط.
    /// Whether this item performs actual routing.
    this.isSideBarRouted = true,
    /// هل يتم إظهار القائمة الجانبية المصغرة (Drawer) مع هذا العنصر.
    /// Whether to show the drawer when this item is active.
    this.isDrawerShow = false,
    /// هل يتم عرض العنوان (Title) في الشاشات الكبيرة.
    /// Whether to display the title on large screens.
    this.isDesplayTitleInLargScreen = false,
    /// هل يتم عرض العنوان (Title) في الشاشات الصغيرة.
    /// Whether to display the title on small screens.
    this.isDesplayTitleInSmallScreen = false, // Default to routed
    /// المتغيرات أو المعاملات المرفقة مع الرابط (مثال: id=5).
    /// Parameters attached to the route path.
    this.prams,
    /// مسار ثابت (اختياري) يعتمد عليه كمرجع.
    /// Constant route parts (optional) used as reference.
    this.constRoute,
    /// المعاملات التي تمرر عبر رابط الاستعلام (Query Parameters).
    /// The query parameters passed through the URL.
    this.queryParameters,
  }) {
    // عمل نسخة من prams وليس مرجع
    constPrams = prams != null ? Map<String, dynamic>.from(prams!) : null;
    print(prams);
    if (this.isSideBarRouted == false) {
      // إذا لم يكن موجهًا، فلا حاجة إلى معلمات
      isInBottomNavBar = false;
    }
    if (this.isInBottomNavBar == true) {
      // إذا كان في شريط التنقل السفلي، يجب أن يكون موجهًا
      this.isSideBarRouted = true;
    }
    if (this.parentName.isNotEmpty) {
      this.isChildItem = true;
    }
  }

  /// إرجاع المسار مع استبدال المعاملات
  String get resolvedPath {
    if (constPrams == null || constPrams!.isEmpty) {
      return path;
    }

    String resolvedPath = path;
    constPrams!.forEach((key, value) {
      resolvedPath = resolvedPath.replaceAll(':$key', value.toString());
    });
    return resolvedPath;
  }
}
