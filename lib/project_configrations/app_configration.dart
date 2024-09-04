import 'package:flutter/material.dart';

import '../util/navigations/navigation_service.dart';
 abstract  class DataViewConfigraion {

    String _Version = " V:  1.0.0";
    String _AppName = "Commerce App";
    String _AppNameID = "Commerce_App";

    String get Version => _Version;
    set Version(String value) => _Version = value;
    String get AppName => _AppName;
    set AppName(String value) => _AppName = value;
    String get AppNameID => _AppNameID;
    set AppNameID(String value) => _AppNameID = value;

      Widget launchScreen() ;
      void  RouteInit() {
        NavigationService().setRouters(getRouters());
      }
      Map<String ,Widget> getRouters() ;
      void setAppLocal(String localCode ) ;

}