import 'package:flutter/cupertino.dart';

abstract class ScreenStateNotifier extends ChangeNotifier {
  late BuildContext context;
  late Function fuction;

  void createproviers(BuildContext contxt);

}
