import 'package:flutter/material.dart';

class SideBarNavigationTheames {
  // Properties
    bool isSidebarInCulomn; 
  final Color backgroundColor;
  final Color hoverBackgroundColor;
  final Color selectedBackgroundColor;
  final Color textColor;
  final Color hoverTextColor;
  final Color selectedTextColor;
  final Color iconColor;
  final Color hoverIconColor;
  final Color selectedIconColor;
  final Color selectedBorderColor;
  final double selectedBorderWidth;
  final Duration hoverTransitionDuration;
  final Curve hoverTransitionCurve;
  final double itemHeight;
  final EdgeInsetsGeometry itemPadding;
  final double iconSize;
  final double iconTextSpacing;
  final double fontSize;
  final FontWeight normalFontWeight;
  final FontWeight selectedFontWeight;

  // Constructor
    SideBarNavigationTheames({
    this.isSidebarInCulomn = false,
    required this.backgroundColor,
    required this.hoverBackgroundColor,
    required this.selectedBackgroundColor,
    required this.textColor,
    required this.hoverTextColor,
    required this.selectedTextColor,
    required this.iconColor,
    required this.hoverIconColor,
    required this.selectedIconColor,
    required this.selectedBorderColor,
    this.selectedBorderWidth = 2.0,
    this.hoverTransitionDuration = const Duration(milliseconds: 200),
    this.hoverTransitionCurve = Curves.easeInOut,
    this.itemHeight = 48.0,
    this.itemPadding = const EdgeInsets.symmetric(horizontal: 16.0),
    this.iconSize = 24.0,
    this.iconTextSpacing = 16.0,
    this.fontSize = 14.0,
    this.normalFontWeight = FontWeight.normal,
    this.selectedFontWeight = FontWeight.bold,
  });

  // Light Theme (Default)
  factory SideBarNavigationTheames.light({
    bool isSidebarInCulomn = false,
    double? itemHeight,
    double? fontSize,
    EdgeInsetsGeometry? itemPadding,
  }) {
    return SideBarNavigationTheames(
      isSidebarInCulomn: isSidebarInCulomn,
      backgroundColor: Colors.white,
      hoverBackgroundColor: Colors.grey.shade100,
      selectedBackgroundColor: Colors.blue.shade50,
      textColor: Colors.black87,
      hoverTextColor: Colors.blue.shade700,
      selectedTextColor: Colors.blue,
      iconColor: Colors.black54,
      hoverIconColor: Colors.blue.shade700,
      selectedIconColor: Colors.blue,
      selectedBorderColor: Colors.blue,
      itemHeight: itemHeight ?? 48.0,
      fontSize: fontSize ?? 14.0,
      itemPadding: itemPadding ?? const EdgeInsets.symmetric(horizontal: 16.0),
    );
  }

  // Dark Theme
  factory SideBarNavigationTheames.dark({
    bool isSidebarInCulomn = false,
    double? itemHeight,
    double? fontSize,
    EdgeInsetsGeometry? itemPadding,
  }) {
    return SideBarNavigationTheames(
      isSidebarInCulomn: isSidebarInCulomn,
      backgroundColor: const Color(0xFF1F1F1F),
      hoverBackgroundColor: const Color(0xFF2D2D2D),
      selectedBackgroundColor: Colors.blue.shade900,
      textColor: Colors.white70,
      hoverTextColor: Colors.white,
      selectedTextColor: Colors.white,
      iconColor: Colors.white54,
      hoverIconColor: Colors.white,
      selectedIconColor: Colors.white,
      selectedBorderColor: Colors.blue.shade700,
      itemHeight: itemHeight ?? 48.0,
      fontSize: fontSize ?? 14.0,
      itemPadding: itemPadding ?? const EdgeInsets.symmetric(horizontal: 16.0),
    );
  }

  // Copy with method for customization
  SideBarNavigationTheames copyWith({
    bool? isSidebarInCulomn,
    Color? backgroundColor,
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
    return SideBarNavigationTheames(
      isSidebarInCulomn: isSidebarInCulomn ?? this.isSidebarInCulomn,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      hoverBackgroundColor: hoverBackgroundColor ?? this.hoverBackgroundColor,
      selectedBackgroundColor: selectedBackgroundColor ?? this.selectedBackgroundColor,
      textColor: textColor ?? this.textColor,
      hoverTextColor: hoverTextColor ?? this.hoverTextColor,
      selectedTextColor: selectedTextColor ?? this.selectedTextColor,
      iconColor: iconColor ?? this.iconColor,
      hoverIconColor: hoverIconColor ?? this.hoverIconColor,
      selectedIconColor: selectedIconColor ?? this.selectedIconColor,
      selectedBorderColor: selectedBorderColor ?? this.selectedBorderColor,
      selectedBorderWidth: selectedBorderWidth ?? this.selectedBorderWidth,
      hoverTransitionDuration: hoverTransitionDuration ?? this.hoverTransitionDuration,
      hoverTransitionCurve: hoverTransitionCurve ?? this.hoverTransitionCurve,
      itemHeight: itemHeight ?? this.itemHeight,
      itemPadding: itemPadding ?? this.itemPadding,
      iconSize: iconSize ?? this.iconSize,
      iconTextSpacing: iconTextSpacing ?? this.iconTextSpacing,
      fontSize: fontSize ?? this.fontSize,
      normalFontWeight: normalFontWeight ?? this.normalFontWeight,
      selectedFontWeight: selectedFontWeight ?? this.selectedFontWeight,
    );
  }

  // Methods to get specific styles

  // Get the container decoration based on item state
  BoxDecoration getItemDecoration({
    bool isHovered = false,
    bool isSelected = false,
  }) {
    return BoxDecoration(
      color: isSelected
          ? selectedBackgroundColor
          : (isHovered ? hoverBackgroundColor : backgroundColor),
      border: isSelected
          ? Border(
              left: BorderSide(
                color: selectedBorderColor,
                width: selectedBorderWidth,
              ),
            )
          : null,
    );
  }

  // Get text style based on item state
  TextStyle getTextStyle({
    bool isHovered = false,
    bool isSelected = false,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: isSelected ? selectedFontWeight : normalFontWeight,
      color: isSelected
          ? selectedTextColor
          : (isHovered ? hoverTextColor : textColor),
    );
  }

  // Get icon color based on item state
  Color getIconColor({
    bool isHovered = false,
    bool isSelected = false,
  }) {
    return isSelected
        ? selectedIconColor
        : (isHovered ? hoverIconColor : iconColor);
  }
}
