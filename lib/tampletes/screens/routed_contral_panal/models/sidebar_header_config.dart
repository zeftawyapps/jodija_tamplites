import 'package:flutter/material.dart';

class SidebarHeaderConfig {
  // Title configuration
  /// النص أو العنوان الذي يظهر في ترويسة القائمة الجانبية بجوار اللوجو أو أسفله.
  /// The text or title displayed in the sidebar header next to or below the logo.
  final String? title;
  
  /// التصميم الخاص بنص العنوان (مثل حجم الخط واللون).
  /// The text style for the title (e.g., font size and color).
  final TextStyle? titleStyle;

  // Logo/image configuration
  /// مسار الشعار (Logo) من الملفات المحلية للتطبيق (Assets).
  /// The local asset path for the logo image.
  final String? logoAssetPath;
  
  /// رابط صورة الشعار من الإنترنت.
  /// The network URL for the logo image.
  final String? logoNetworkUrl;
  
  /// ارتفاع الشعار. (الافتراضي 60).
  /// The height of the logo. (Default is 60).
  final double logoHight;
  
  /// عرض الشعار. (الافتراضي 60).
  /// The width of the logo. (Default is 60).
  final double logoWidth  ;
  
  /// طريقة تعبئة الشعار ضمن المساحة المخصصة له (مثل BoxFit.contain أو BoxFit.cover).
  /// How the logo image should be inscribed into the allocated space.
  final BoxFit logoFit;
  
  /// مقدار انحناء أو دوران حواف صورة الشعار.
  /// The border radius for the logo image.
  final BorderRadius? logoRadius;

  // Layout configuration
  /// الارتفاع الكلي لمساحة الترويسة. (الافتراضي 80).
  /// The total height of the header area. (Default is 80).
  final double height;
  
  /// الهوامش الداخلية المحيطة بعناصر الترويسة. (الافتراضي 16).
  /// The padding around the header elements. (Default is 16).
  final EdgeInsetsGeometry padding;
  
  /// لون خلفية الترويسة.
  /// The background color of the header.
  final Color? backgroundColor;
  
  /// محاذاة العناصر داخل الترويسة (الافتراضي Alignment.center).
  /// The alignment of elements within the header. (Default is Alignment.center).
  final Alignment alignment;
  
  /// اتجاه عرض العناصر (اللوجو والنص). 
  /// Axis.vertical يجعلهم عمودياً (Column) وهو الافتراضي.
  /// Axis.horizontal يجعلهم أفقياً (Row) جنباً إلى جنب.
  /// The layout direction for elements (logo and text). Axis.vertical stacks them, Axis.horizontal places them side by side.
  final Axis direction;

  // Custom widget that overrides everything if provided
  /// ويدجت مخصص يحل محل الترويسة الافتراضية بالكامل. 
  /// إذا قمت بتمرير هذا الويدجت، سيتم تجاهل جميع الإعدادات الأخرى (اللوجو والعنوان).
  /// A custom widget that completely overrides the default header. If provided, all other settings are ignored.
  final Widget? customHeaderWidget;

  SidebarHeaderConfig({
    /// النص أو العنوان الذي يظهر في ترويسة القائمة الجانبية بجوار اللوجو أو أسفله.
    /// The text or title displayed in the sidebar header next to or below the logo.
    this.title,
    /// التصميم الخاص بنص العنوان (مثل حجم الخط واللون).
    /// The text style for the title (e.g., font size and color).
    this.titleStyle,
    /// مسار الشعار (Logo) من الملفات المحلية للتطبيق (Assets).
    /// The local asset path for the logo image.
    this.logoAssetPath,
    /// رابط صورة الشعار من الإنترنت.
    /// The network URL for the logo image.
    this.logoNetworkUrl,
    /// ارتفاع الشعار. (الافتراضي 60).
    /// The height of the logo. (Default is 60).
    this.logoHight = 60,
    /// عرض الشعار. (الافتراضي 60).
    /// The width of the logo. (Default is 60).
    this.logoWidth = 60,
    /// طريقة تعبئة الشعار ضمن المساحة المخصصة له (مثل BoxFit.contain أو BoxFit.cover).
    /// How the logo image should be inscribed into the allocated space.
    this.logoFit = BoxFit.contain,
    /// مقدار انحناء أو دوران حواف صورة الشعار.
    /// The border radius for the logo image.
    this.logoRadius,
    /// الارتفاع الكلي لمساحة الترويسة. (الافتراضي 80).
    /// The total height of the header area. (Default is 80).
    this.height = 80,
    /// الهوامش الداخلية المحيطة بعناصر الترويسة. (الافتراضي 16).
    /// The padding around the header elements. (Default is 16).
    this.padding = const EdgeInsets.all(16),
    /// لون خلفية الترويسة.
    /// The background color of the header.
    this.backgroundColor,
    /// محاذاة العناصر داخل الترويسة (الافتراضي Alignment.center).
    /// The alignment of elements within the header. (Default is Alignment.center).
    this.alignment = Alignment.center,
    /// اتجاه عرض العناصر (اللوجو والنص). Axis.horizontal يجعلهما جنباً إلى جنب.
    /// The layout direction for elements (logo and text). Axis.horizontal places them side by side.
    this.direction = Axis.vertical,
    /// ويدجت مخصص يحل محل الترويسة الافتراضية بالكامل.
    /// A custom widget that completely overrides the default header.
    this.customHeaderWidget,
  });

  Widget buildHeader(BuildContext context) {
    // Return custom header widget if provided
    if (customHeaderWidget != null) {
      return customHeaderWidget!;
    }

    // Build children
    List<Widget> children = [
      if (logoAssetPath != null || logoNetworkUrl != null) ...[
        _buildLogo(),
        SizedBox(
          height: direction == Axis.vertical && title != null ? 8 : 0,
          width: direction == Axis.horizontal && title != null ? 12 : 0,
        ),
      ],
      if (title != null)
        direction == Axis.horizontal
            ? Flexible(
                child: Text(
                  title!,
                  style: titleStyle,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            : Text(
                title!,
                style: titleStyle,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
    ];

    // Build default header
    return Container(
      height: height,
      padding: padding,
      color: backgroundColor,
      alignment: alignment,
      child: direction == Axis.horizontal
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
    );
  }

  Widget _buildLogo() {
    if (logoAssetPath != null) {
      return Image.asset(
        logoAssetPath!,
        height:  logoHight,
        width:  logoWidth,
        fit: logoFit,
      );
    } else if (logoNetworkUrl != null) {
      return Image.network(
        logoNetworkUrl!,
        height:  logoHight,
        width:  logoWidth,
        fit: logoFit,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) =>
            Icon(Icons.broken_image, size:  logoHight  ),
      );
    }
    return SizedBox.shrink();
  }
}
