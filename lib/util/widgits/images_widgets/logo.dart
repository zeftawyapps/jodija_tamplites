import 'package:flutter/material.dart';

 class Logo extends StatelessWidget {
    Logo({Key? key ,
      required this.path ,
      this.hight = 100  , this.width= 100}) : super(key: key);
double width ; double hight;
String path ;
  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(path)) ,
        shape: BoxShape.circle
      ),
    height: hight , width:  width  );


  }
}
