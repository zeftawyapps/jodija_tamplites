import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';


class LoadingImage extends StatefulWidget {
  LoadingImage({Key? key ,  required this.place , this.imageUrl ="",
  isCercle = false
  }) : super(key: key);
  String place ;
  String? imageUrl = "";
  bool isCercle = false;
  @override
  _LoadingImageState createState() => _LoadingImageState();
}

class _LoadingImageState extends State<LoadingImage> {
  bool imgshwo = false;
  bool imgget = false;



  @override
  Widget build(BuildContext context) {


    return Container(

        decoration: BoxDecoration(
          shape:widget .  isCercle? BoxShape.circle : BoxShape.rectangle,

        ),
        child: widget.imageUrl != ""
            ? Image(
          image: NetworkImage(widget.imageUrl!),
        )
              :  Image(
            image: AssetImage( widget.place),),
        ) ;
  }
}
