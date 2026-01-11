import 'package:flutter/material.dart';

class StatusProvider extends ChangeNotifier {

bool isAppInit = false;
int OpenedSubMenuIndex = -1;
bool isSidebarCollapsed = false;

void setAppInitStatus(bool status) {
  if (isAppInit != status) {
    isAppInit = status;
    notifyListeners();
  }
}

void setOpenedSubMenuExtesionsIndex(int index) {
  if (OpenedSubMenuIndex != index) {
    OpenedSubMenuIndex = index;
    notifyListeners();
  }
}

void toggleSidebarCollapsed() {
  isSidebarCollapsed = !isSidebarCollapsed;
  notifyListeners();
}

void setSidebarCollapsed(bool collapsed) {
  if (isSidebarCollapsed != collapsed) {
    isSidebarCollapsed = collapsed;
    notifyListeners();
  }
}
}