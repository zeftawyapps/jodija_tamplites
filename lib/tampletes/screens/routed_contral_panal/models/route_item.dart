import 'package:flutter/material.dart';

import '../utiles/side_bar_navigation_router.dart';

/// نموذج عنصر الشريط الجانبي
class RouteItem {
  final String path; // Make path optional for non-routed items
  final String label;
  final IconData icon;
  final   Widget content;
  final bool isAppBar ;
  final bool isDrawerShow ;
  final bool isSideBarRouted;
  bool isCalledFromSideBar = false;
  final bool isDesplayTitleInLargScreen ;
  final bool  isDesplayTitleInSmallScreen;// Add flag to indicate if item should be routed
  final VoidCallback? onTap;
 
  Map<String,dynamic>? prams;
  Map<String,dynamic>? constPrams;
  List<String>?constRoute;
  Map<String,dynamic>?queryParameters;
  // Custom action for non-routed items

  RouteItem({
    required this.path,
    required this.label,
    required this.icon,
    required this.content,
    this.isAppBar = true ,
    this.isSideBarRouted = true,
    this.isDrawerShow= false ,
    this.isDesplayTitleInLargScreen = false  ,
    this.isDesplayTitleInSmallScreen = false, // Default to routed
    this.onTap,
    this.prams,
    this.constRoute,
    this.queryParameters,
  }){
    // عمل نسخة من prams وليس مرجع
    constPrams = prams != null ? Map<String, dynamic>.from(prams!) : null;
    print(prams);
    
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
