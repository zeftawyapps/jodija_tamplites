import 'package:JoDija_tamplites/tampletes/screens/routed_contral_panal/interface/content_interface.dart';
import 'package:JoDija_tamplites/tampletes/screens/routed_contral_panal/interface/sid_bar_interface.dart';

/// نموذج العنصر القابل للتنقل
class RoutedNavigationItem {
  IRoutedSideBare sideBar; // أيقونة العنصر
  IRoutedContent content; // محتوى الصفحة

  RoutedNavigationItem({
    required this.sideBar,
    required this.content,
  });
}
