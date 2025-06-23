import 'package:flutter/material.dart';

/// نموذج العنصر القابل للتنقل
class NavigationItem {
  final String path; // المسار في الـ URL
  final String label; // عنوان العنصر
  final IconData icon; // أيقونة العنصر
  final Widget content; // محتوى الصفحة

  const NavigationItem({
    required this.path,
    required this.label,
    required this.icon,
    required this.content,
  });
}
