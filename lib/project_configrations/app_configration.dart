import 'package:flutter/material.dart';

import 'enums.dart';

 abstract  class appConfigraion {

    AppType _appType = AppType.App;
    EnvType _envType = EnvType.dev;
    BackendState _backendState = BackendState.remote;
    String _Version = " V:  1.0.0";
    String _AppName = "Commerce App";
    String _AppNameID = "Commerce_App";
    // getter and setter
    AppType get appType => _appType;
    set appType(AppType value) => _appType = value;
    EnvType get envType => _envType;
    set envType(EnvType value) => _envType = value;
    BackendState get backendState => _backendState;
    set backendState(BackendState value) => _backendState = value;
    String get Version => _Version;
    set Version(String value) => _Version = value;
    String get AppName => _AppName;
    set AppName(String value) => _AppName = value;
    String get AppNameID => _AppNameID;
    set AppNameID(String value) => _AppNameID = value;
    Future FirebaseInit() ;
    Future backenRoutsdInit()  ;
      Widget launchScreen() ;
      String baseRoute() ;
      void setAppLocal(String localCode ) ;

}