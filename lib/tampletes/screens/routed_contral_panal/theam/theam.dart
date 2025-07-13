import 'package:flutter/material.dart';

class SideBarNavigationTheames {
  // single ton inistance
  static final SideBarNavigationTheames _instance =
      SideBarNavigationTheames._internal();

  factory SideBarNavigationTheames() {
    return _instance;
  }

  SideBarNavigationTheames._internal();

  // Create a method to copy instance with customized values
  SideBarNavigationTheames copyWith({
    bool isSidebarInCulomn = false,
    Color? backgroundColor,
    double? itemWidth,
    Color? hoverBackgroundColor,
    Color? selectedBackgroundColor,
    Color? textColor,
    Color? hoverTextColor,
    Color? selectedTextColor,
    Color? iconColor,
    Color? hoverIconColor,
    Color? selectedIconColor,
    Color? selectedBorderColor,
    double? selectedBorderWidth,
    Duration? hoverTransitionDuration,
    Curve? hoverTransitionCurve,
    double? itemHeight,
    EdgeInsetsGeometry? itemPadding,
    double? iconSize,
    double? iconTextSpacing,
    double? fontSize,
    FontWeight? normalFontWeight,
    FontWeight? selectedFontWeight,
  }) {
    // Since this is a singleton, we modify the instance directly
 this.  isSidebarInCulomn = isSidebarInCulomn;
    if (itemWidth != null) {
      itemHeight = itemWidth; // Assuming itemWidth is used for height
          }
    if (backgroundColor != null) this.backgroundColor = backgroundColor;
    if (hoverBackgroundColor != null)
      this.hoverBackgroundColor = hoverBackgroundColor;
    if (selectedBackgroundColor != null)
      this.selectedBackgroundColor = selectedBackgroundColor;
    if (textColor != null) this.textColor = textColor;
    if (hoverTextColor != null) this.hoverTextColor = hoverTextColor;
    if (selectedTextColor != null) this.selectedTextColor = selectedTextColor;
    if (iconColor != null) this.iconColor = iconColor;
    if (hoverIconColor != null) this.hoverIconColor = hoverIconColor;
    if (selectedIconColor != null) this.selectedIconColor = selectedIconColor;
    if (selectedBorderColor != null)
      this.selectedBorderColor = selectedBorderColor;
    if (selectedBorderWidth != null)
      this.selectedBorderWidth = selectedBorderWidth;
    if (hoverTransitionDuration != null)
      this.hoverTransitionDuration = hoverTransitionDuration;
    if (hoverTransitionCurve != null)
      this.hoverTransitionCurve = hoverTransitionCurve;
    if (itemHeight != null) this.itemHeight = itemHeight;
    if (itemPadding != null) this.itemPadding = itemPadding;
    if (iconSize != null) this.iconSize = iconSize;
    if (iconTextSpacing != null) this.iconTextSpacing = iconTextSpacing;
    if (fontSize != null) this.fontSize = fontSize;
    if (normalFontWeight != null) this.normalFontWeight = normalFontWeight;
    if (selectedFontWeight != null)
      this.selectedFontWeight = selectedFontWeight;

    return this;
  }

  // Default theme colors
  // Background colors
  bool isSidebarInCulomn = false;
  Color backgroundColor = Colors.white;
  Color hoverBackgroundColor = Colors.grey.shade100;
  Color selectedBackgroundColor = Colors.blue.shade50;

  // Text colors
  Color textColor = Colors.black87;
  Color hoverTextColor = Colors.blue.shade700;
  Color selectedTextColor = Colors.blue;

  // Icon colors
  Color iconColor = Colors.black54;
  Color hoverIconColor = Colors.blue.shade700;
  Color selectedIconColor = Colors.blue;

  // Border properties
  Color selectedBorderColor = Colors.blue;
  double selectedBorderWidth = 2.0;

  // Animation properties
  Duration hoverTransitionDuration = const Duration(milliseconds: 200);
  Curve hoverTransitionCurve = Curves.easeInOut;

  // Item spacing and sizing
  double itemHeight = 48.0;
  EdgeInsetsGeometry itemPadding = const EdgeInsets.symmetric(horizontal: 16.0);
  double iconSize = 24.0;
  double iconTextSpacing = 16.0;

  // Text style
  double fontSize = 14.0;
  FontWeight normalFontWeight = FontWeight.normal;
  FontWeight selectedFontWeight = FontWeight.bold;

  // Methods to get specific styles

  // Get the container decoration based on item state
  BoxDecoration getItemDecoration(
      {bool isHovered = false, bool isSelected = false}) {
    return BoxDecoration(
      color: isSelected
          ? selectedBackgroundColor
          : (isHovered ? hoverBackgroundColor : backgroundColor),
      border: isSelected
          ? Border(
              left: BorderSide(
                  color: selectedBorderColor, width: selectedBorderWidth))
          : null,
    );
  }

  // Get text style based on item state
  TextStyle getTextStyle({bool isHovered = false, bool isSelected = false}) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: isSelected ? selectedFontWeight : normalFontWeight,
      color: isSelected
          ? selectedTextColor
          : (isHovered ? hoverTextColor : textColor),
    );
  }

  // Get icon color based on item state
  Color getIconColor({bool isHovered = false, bool isSelected = false}) {
    return isSelected
        ? selectedIconColor
        : (isHovered ? hoverIconColor : iconColor);
  }

  // Theme customization methods
  void setColorScheme(ColorScheme colorScheme) {
    selectedBackgroundColor = colorScheme.primary.withOpacity(0.1);
    selectedTextColor = colorScheme.primary;
    selectedIconColor = colorScheme.primary;
    selectedBorderColor = colorScheme.primary;
    hoverTextColor = colorScheme.primary.withOpacity(0.8);
    hoverIconColor = colorScheme.primary.withOpacity(0.8);
  }

  // Create a dark theme variant
  void setDarkTheme() {
    backgroundColor = const Color(0xFF1F1F1F);
    hoverBackgroundColor = const Color(0xFF2D2D2D);
    selectedBackgroundColor = Colors.blue.shade900;
    textColor = Colors.white70;
    hoverTextColor = Colors.white;
    selectedTextColor = Colors.white;
    iconColor = Colors.white54;
    hoverIconColor = Colors.white;
    selectedIconColor = Colors.white;
  }
}
