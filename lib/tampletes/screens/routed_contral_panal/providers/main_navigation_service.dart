// import 'package:JoDija_tamplites/tampletes/screens/routed_contral_panal/interface/content_interface.dart';
// import 'package:JoDija_tamplites/tampletes/screens/routed_contral_panal/interface/sid_bar_interface.dart';
// import 'package:JoDija_tamplites/util/widgits/screen_provider/screen_notfier.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';

// class RodutedContralPanalServices extends ScreenStateNotifier {
// // single ton object

//   static RodutedContralPanalServices? _instance;

//   RodutedContralPanalServices._();
//   DashboardMainServices(
//       {String tittle = "JoDija",
//       String logo = "null",
//       String backgroundImage = "null",
//       Color? backGroundColor,
//       Color? sideBarColor,
//       Color? sideBarHoverColor,
//       Color? headerColor,
//       Color? titleTextColor}) {
//     _tittle = tittle;
//     _logo = logo;
//     _backgroundImage = backgroundImage;
//     _backGroundColor = backGroundColor ?? Colors.white;
//     _sideBarColor = sideBarColor ?? Colors.grey;
//     _sideBarHoverColor = sideBarHoverColor ?? Colors.blueGrey;
//     _headerColor = headerColor ?? Colors.black;
//     _titleTextColor = titleTextColor ?? Colors.black;
//   }

//   String _tittle = 'Default Title';
//   String _logo = 'Default Logo';
//   String _backgroundImage = 'Default Background Image';
//   Color _backGroundColor = Colors.white;
//   Color _sideBarColor = Colors.grey;
//   Color _sideBarHoverColor = Colors.blueGrey;
//   Color _headerColor = Colors.black;
//   Color _titleTextColor = Colors.black;

//   // GETTER
//   String get tittle => _tittle;
//   String get logo => _logo;
//   String get backgroundImage => _backgroundImage;
//   Color get backGroundColor => _backGroundColor;
//   Color get sideBarColor => _sideBarColor;
//   Color get sideBarHoverColor => _sideBarHoverColor;
//   Color get headerColor => _headerColor;
//   Color get titleTextColor => _titleTextColor;

//   // SETTER in one function
//   void setTheme({
//     String tittle = 'Default Title',
//     String logo = "assets/images/logo.png",
//     String backgroundImage = "assets/images/background.jpg",
//     Color? backGroundColor,
//     Color? sideBarColor,
//     Color? sideBarHoverColor,
//     Color? headerColor,
//     Color? titleTextColor,
//   }) {
//     _tittle = tittle;
//     _logo = logo;
//     _backgroundImage = backgroundImage;
//     _backGroundColor = backGroundColor ??
//         Theme.of(context).scaffoldBackgroundColor ??
//         Colors.white;
//     _sideBarColor = sideBarColor ??
//         Theme.of(context).drawerTheme.backgroundColor ??
//         Colors.grey;
//     _sideBarHoverColor = sideBarHoverColor ?? Colors.blueGrey;
//     _headerColor = headerColor ??
//         Theme.of(context).appBarTheme.backgroundColor ??
//         Colors.black;
//     _titleTextColor = titleTextColor ??
//         Theme.of(context).appBarTheme.titleTextStyle!.color ??
//         Colors.black;
//     notifyListeners();
//   }

//   List<IRoutedContent> contents = [];
//   List<IRoutedSideBare> sideBar = [];
//   int selectedIndex = 0;
//   String currentPath = '/';
//   int hoverIndex = 0;
//   List<Widget> getSideBar() {
//     List<Widget> list = [];
//     // for with i loop
//     for (var i = 0; i < sideBar.length; i++) {
//       sideBar[i].index = i;
//       list.add(sideBar[i].build(context));
//     }
//     return list;
//   }

//   List<Widget> getContents() {
//     List<Widget> list = [];
//     // check if the contents length is  equal to  side bar length
//     if (contents.length != sideBar.length) {
//       throw Exception('contents length must be equal to side bar length');
//     }
//     // for with i loop
//     for (var i = 0; i < contents.length; i++) {
//       list.add(contents[i].build(context));
//     }
//     return list;
//   }

//   Widget getContent() {
//     return contents[selectedIndex].build(context);
//   }

//   // on side bar item click
//   void onSideBarClick(int index) {
//     selectedIndex = index;
//     currentPath = sideBar[index].path();
//     // WebRouter.updateUrl(currentPath);

//     notifyListeners();
//   }

//   // on side bar item hover
//   void onSideBarHover(int index) {
//     hoverIndex = index;
//     notifyListeners();
//   }

//   // on side bar item exit
//   void onSideBarExit(int index) {
//     hoverIndex = -1;
//     notifyListeners();
//   }

//   @override
//   void createproviers(BuildContext contxt) {
//     context = contxt;
//   }

//   void initWebRouter() {}

//   String getTittle() {
//     return sideBar[selectedIndex].title;
//   }
// }
