import 'dart:async';

import 'package:JoDija_view/util/main-screen/screen-type.dart';
import 'package:JoDija_view/util/view_data_model/base_data_model.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class ShowInputFieldsDialogs<  T extends BaseViewDataModel >{

  Widget content ;
  ScreenType screenType;
  double? height ;
  double? width ;

  ShowInputFieldsDialogs({  required this.screenType
  , required this.content
    , this.height , this.width
  });

  Future<void> showCleintDialogs(
    BuildContext context, {
    // T? data,
    // show result of dialog
    void Function( T? data)? onResult,
  }) async {
    double h =    MediaQuery.of(context).size.height;
    double w =   MediaQuery.of(context).size.width;

    if (screenType == ScreenType.web) {
      showDialog<T?> (
          context: context,
          builder: (_) {
            return FadeIn(
                duration: Duration(milliseconds: 300),
                child: Dialog(child: Container(
                    width:width ??  w * 0.9,
                    height:  height ??   h * 0.4,

                    child: content)));
          }).then((value) =>
      {onResult!(value)});
    } else {
      showModalBottomSheet<T?> (
          context: context,
          builder: (_) {
            bool iskeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
            return FadeIn(
                duration: Duration(milliseconds: 300),
                child: Container(
                  width:width ??  w * 0.9,
                  height: iskeyboard ? 20000 : height ??   h * 0.4,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: SingleChildScrollView(
                        child: Container(

                          // height: iskeyboard ? height ??   h * 1.2 : height ??  h * .1,
                          child: content,
                        ),
                      )),
                ));
          }).then((value) => {onResult!(value)});
    }
  }
}
