import 'package:flutter/material.dart';

/// نموذج عنصر الشريط الجانبي
class SidebarItem {
  final String path;
  final String label;
  final IconData icon;
  final Widget content;

  SidebarItem({
    required this.path,
    required this.label,
    required this.icon,
    required this.content,
  });
}
