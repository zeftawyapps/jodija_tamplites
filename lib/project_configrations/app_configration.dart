import 'package:flutter/material.dart';



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
      String baseRoute() ;
      void setAppLocal(String localCode ) ;

}