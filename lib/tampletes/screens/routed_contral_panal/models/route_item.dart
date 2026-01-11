import 'package:flutter/material.dart';

import '../utiles/side_bar_navigation_router.dart';

/// نموذج عنصر الشريط الجانبي
class RouteItem {
  final String id;
  final String path; // Make path optional for non-routed items
  final String label;
  final IconData icon;
  final   Widget content;
  bool isAppBar ;
  bool isDrawerShow ;
   bool isSideBarRouted;
   bool isUnViasibleInSideBarIfSmall = false ;
    bool isInBottomNavBar = false ;
  String parentName = "" ;
  IconData? parentIcon ;
  bool isChildItem = false ;
  bool isInTopNavBar = false ;
  bool isCalledFromSideBar = false;
  bool isDesplayTitleInLargScreen ;
  bool isDesplayTitleInSmallScreen;// Add flag to indicate if item should be routed
 
  bool isVisableInSideBar  = true  ;
 
  Map<String,dynamic>? prams;
  Map<String,dynamic>? constPrams;
  List<String>?constRoute;
  Map<String,dynamic>?queryParameters;
  // Custom action for non-routed items

  RouteItem({
    required this.id,
    required this.path,
    required this.label,
    required this.icon,
    required this.content,
    this.parentName = "",
    this.parentIcon ,
    this.isInBottomNavBar = false ,
    this.isUnViasibleInSideBarIfSmall = false ,
  
    
    
    this.isAppBar = true ,
    this.isVisableInSideBar = true  ,
    this.isSideBarRouted = true,
    this.isDrawerShow= false ,
    this.isDesplayTitleInLargScreen = false  ,
    this.isDesplayTitleInSmallScreen = false, // Default to routed
  
    this.prams,
    this.constRoute,
    this.queryParameters,
  }){
    // عمل نسخة من prams وليس مرجع
    constPrams = prams != null ? Map<String, dynamic>.from(prams!) : null;
    print(prams);
    if (this.isSideBarRouted == false) {
      // إذا لم يكن موجهًا، فلا حاجة إلى معلمات
       isInBottomNavBar = false ;
    }
    if (this.isInBottomNavBar == true) {
      // إذا كان في شريط التنقل السفلي، يجب أن يكون موجهًا
      this.isSideBarRouted = true;
    }
    if (this.parentName.isNotEmpty) {
      this.isChildItem = true ;
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
