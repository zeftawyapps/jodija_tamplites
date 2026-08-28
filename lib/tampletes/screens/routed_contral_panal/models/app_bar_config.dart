import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// إعدادات وتخصيص الشريط العلوي (App Bar Configuration)
///
/// يتحكم في مظهر وسلوك الـ [AppBar] في الشاشات المختلفة، ويتيح تخصيص العناوين،
/// الأزرار الإضافية (Actions)، زر الرجوع/القائمة (Leading)، والألوان والارتفاع.
class AppBarConfig {
  // Title configuration
  /// عنوان شريط التطبيق العلوي الافتراضي.
  final String title;

  /// النمط والتصميم الخاص بنص العنوان (اللون، الحجم، نوع الخط).
  final TextStyle? titleStyle;

  /// ودجت مخصص للعنوان يحل محل النص الافتراضي إن وجد.
  final Widget? titleWidget;

  // Actions and leading
  /// قائمة العناصر والأزرار التفاعلية في نهاية الـ AppBar (مثل زر الإشعارات، البروفايل).
  final List<Widget>? actions;

  /// عنصر المقدمة (Leading Widget) مثل زر القائمة أو الشعار.
  final Widget? leading;

  /// هل يتم إظهار زر الرجوع أو فتح الـ Drawer تلقائياً إن لم يُحدد [leading].
  final bool automaticallyImplyLeading;

  // Appearance
  /// لون خلفية شريط التطبيق.
  final Color? backgroundColor;

  /// لون العناصر والنصوص الأمامية.
  final Color? foregroundColor;

  /// درجة الظل والارتفاع (Shadow Elevation).
  final double? elevation;

  /// الارتفاع الكلي لشريط التطبيق.
  final double? toolbarHeight;

  /// هل يتم توسيط العنوان في المنتصف.
  final bool? centerTitle;

  /// ودجت يظهر في أسفل شريط التطبيق (مثل الـ TabBar).
  final PreferredSizeWidget? bottom;

  AppBarConfig({
    this.title = 'تطبيقي',
    this.titleStyle,
    this.titleWidget,
    this.actions,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
    this.toolbarHeight,
    this.centerTitle,
    this.bottom,
  });


  AppBar? buildAppBar({
    required BuildContext context,
    bool isAppBar = true,
    bool isDesplayTitle = false,
    String currentTilte = "",
  }) {
    String newTitels = isDesplayTitle ? currentTilte : title;

    // تحديد الـ leading: إذا كان محدداً مسبقاً استخدمه، وإلا تحقق من canPop
    Widget? effectiveLeading = leading;
    if (effectiveLeading == null && GoRouter.of(context).canPop()) {
      effectiveLeading = IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          context.pop();
        },
      );
    }

    return isAppBar
        ? AppBar(
            title: titleWidget ?? Text(newTitels, style: titleStyle),
            actions: actions,
            leading: effectiveLeading,
            automaticallyImplyLeading: automaticallyImplyLeading,
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            elevation: elevation,
            toolbarHeight: toolbarHeight,
            centerTitle: centerTitle,
            bottom: bottom,
          )
        : null;
  }
}
