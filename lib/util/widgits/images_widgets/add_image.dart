import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'imag_bloc.dart';
import 'image_model.dart';

class ImagePecker extends StatefulWidget {
  ImagePecker(
      {Key? key,
      required this.onImage,
      required this.place,
      this.networkImage = "",
      this.fileNom = 0,
      this.iconSize = 30,
      this.hight = 100,
      this.width = 100,
      this.iconPossiontLeft,
      this.iconPossiontTop,
      this.iconPossiontRight = 0,
      this.iconPossiontBottom = 0,
      this.imageColor = Colors.white,
      this.iconColor = Colors.white,
      this.icon = Icons.add_a_photo,
      this.iconContainerColor = Colors.black,
      this.iconShaw = const [],
      this.shapeShaw = const [],
      this.border,
      this.iconBorder,
      this.shape = BoxShape.circle})
      : super(key: key);
  ImagePickerModele addimagep = ImagePickerModele();
  Function(FileModel file) onImage;
  String place;
  String networkImage = "";
  int fileNom = 0;
  double hight;
  double width;
  double? iconPossiontLeft;
  double? iconPossiontTop;
  double? iconPossiontRight;
  double? iconPossiontBottom;
  IconData icon;
  double iconSize = 30;
  BoxShape shape = BoxShape.circle;
  Color iconColor = Colors.red;
  Color imageColor = Colors.white;
  Color iconContainerColor = Colors.white;
  List<BoxShadow> iconShaw = [];
  List<BoxShadow> shapeShaw = [];
  BoxBorder? border;
  BoxBorder? iconBorder;

  @override
  _ImagePeckerState createState() => _ImagePeckerState();
}

class _ImagePeckerState extends State<ImagePecker> {
  bool imgshwo = false;
  bool imgget = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ImagePickerModele addimagep = widget.addimagep;
    if (widget.networkImage != null || widget.networkImage != "") {
      addimagep.setwebimage(widget.networkImage);
    }
    imgget = addimagep.imgget;

    return BlocConsumer(
        bloc: addimagep,
        listenWhen: (c, p) => c != p,
        listener: (context, state) {
          if (state is FileLoaded) {
            ImageFileLoading.imagFile = addimagep.fileImage;
            if (kIsWeb) {
              addimagep.networkImage = addimagep.fileImagePath;
            }
            widget.onImage(FileModel(
              multiFile: addimagep.multiFile,
              fileImage: addimagep.fileImage,
              fileImagePath: addimagep.fileImagePath,
              xFile: addimagep.xFile,
              Imagebytes: addimagep.Imagebytes,
              fileImageFrombytes: addimagep.fileImageFrombytes,
              networkImage: addimagep.networkImage,
            ));
          }
        },
        builder: (context, state) {
          ImageFileLoading.imagFile = addimagep.fileImage;

          return Container(
            width: widget.width,
            height: widget.hight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        imgshwo = !imgshwo;
                      });
                    },
                    child: Stack(
                      children: [
                        Center(
                          child: Container(
                              width: widget.width,
                              height: widget.hight,
                              decoration: BoxDecoration(
                                shape: widget.shape,
                                border: widget.border,
                                boxShadow: widget.shapeShaw,
                                color: widget.imageColor,
                              ),
                              child: addimagep.networkImage != ""
                                  ? Image(
                                      image:
                                          NetworkImage(addimagep.networkImage),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        child: addimagep.imgget
                                            ? Image(
                                                image: FileImage(
                                                    addimagep.fileImage!),
                                              )
                                            : Image(
                                                image: AssetImage(widget.place),
                                              ),
                                      ),
                                    )),
                        ),
                        Positioned.fill(
                          right: widget.iconPossiontRight,
                          bottom: widget.iconPossiontBottom,
                          left: widget.iconPossiontLeft,
                          top: widget.iconPossiontTop,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: widget.shape,
                              color: widget.iconContainerColor,
                              boxShadow: widget.iconShaw,
                              border: widget.iconBorder,
                            ),
                            child: Icon(
                              widget.icon,
                              size: widget.iconSize,
                              color: widget.iconColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                    child: imgshwo
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              kIsWeb
                                  ? Container()
                                  : Expanded(
                                      child: MaterialButton(
                                      onPressed: () {
                                        addimagep.setgetimage(false);
                                        addimagep.getImage(ImageSource.camera);
                                        imgshwo = false;
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: widget.iconContainerColor,
                                        ),
                                        child: Icon(
                                          Icons.add_a_photo,
                                          size: widget.iconSize,
                                          color: widget.iconColor,
                                        ),
                                      ),
                                    )),
                              Expanded(
                                  child: MaterialButton(
                                onPressed: () {
                                  addimagep.setgetimage(false);
                                  addimagep.getImage(ImageSource.gallery);
                                  imgshwo = false;
                                },
                                child: Container(
                                  color: widget.iconContainerColor,
                                  child: Icon(
                                    Icons.add_photo_alternate_sharp,
                                    size: widget.iconSize,
                                    color: widget.iconColor,
                                  ),
                                ),
                              ))
                            ],
                          ).animate().scaleY(
                              begin: 0,
                              end: 1,
                              duration: Duration(milliseconds: 100),
                            )
                        : Container()),
              ],
            ),
          );
        });
  }
}
