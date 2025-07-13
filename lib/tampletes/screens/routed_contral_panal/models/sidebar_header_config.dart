import 'package:flutter/material.dart';

class SidebarHeaderConfig {
  // Title configuration
  final String? title;
  final TextStyle? titleStyle;

  // Logo/image configuration
  final String? logoAssetPath;
  final String? logoNetworkUrl;
  final double logoSize;
  final BoxFit logoFit;
  final BorderRadius? logoRadius;

  // Layout configuration
  final double height;
  final EdgeInsetsGeometry padding;
  final Color? backgroundColor;
  final Alignment alignment;

  // Custom widget that overrides everything if provided
  final Widget? customHeaderWidget;

  SidebarHeaderConfig({
    this.title,
    this.titleStyle,
    this.logoAssetPath,
    this.logoNetworkUrl,
    this.logoSize = 40,
    this.logoFit = BoxFit.contain,
    this.logoRadius,
    this.height = 80,
    this.padding = const EdgeInsets.all(16),
    this.backgroundColor,
    this.alignment = Alignment.center,
    this.customHeaderWidget,
  });

  Widget buildHeader(BuildContext context) {
    // Return custom header widget if provided
    if (customHeaderWidget != null) {
      return customHeaderWidget!;
    }

    // Build default header
    return Container(
      height: height,
      padding: padding,
      color: backgroundColor,
      alignment: alignment,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (logoAssetPath != null || logoNetworkUrl != null) ...[
            ClipRRect(
              borderRadius: logoRadius ?? BorderRadius.circular(0),
              child: _buildLogo(),
            ),
            SizedBox(height: title != null ? 8 : 0),
          ],
          if (title != null)
            Text(
              title!,
              style: titleStyle,
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    if (logoAssetPath != null) {
      return Image.asset(
        logoAssetPath!,
        height: logoSize,
        width: logoSize,
        fit: logoFit,
      );
    } else if (logoNetworkUrl != null) {
      return Image.network(
        logoNetworkUrl!,
        height: logoSize,
        width: logoSize,
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
            Icon(Icons.broken_image, size: logoSize),
      );
    }
    return SizedBox.shrink();
  }
}
