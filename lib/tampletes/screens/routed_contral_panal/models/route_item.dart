import 'package:flutter/material.dart';

/// نموذج عنصر الشريط الجانبي
class RouteItem {
  final String path; // Make path optional for non-routed items
  final String label;
  final IconData icon;
  final Widget content;
  final bool isSideBarRouted; // Add flag to indicate if item should be routed
  final VoidCallback? onTap; // Custom action for non-routed items

  RouteItem({
    required this.path,
    required this.label,
    required this.icon,
    required this.content,
    this.isSideBarRouted = true, // Default to routed
    this.onTap,
  });
}
