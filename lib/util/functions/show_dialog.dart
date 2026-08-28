import 'dart:async';

import 'package:JoDija_tamplites/util/main-screen/screen-type.dart';
import 'package:JoDija_tamplites/util/view_data_model/base_data_model.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class ShowInputFieldsDialogs<T extends BaseViewDataModel> {
  Widget content;
  ScreenType screenType;
  double? height;
  double? width;

  ShowInputFieldsDialogs(
      {required this.screenType,
      required this.content,
      this.height,
      this.width});

  Future<void> showDialogs(
    BuildContext context, {
    // T? data,
    // show result of dialog
    void Function(T? data)? onResult,
  }) async {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    if (screenType == ScreenType.web) {
      showDialog<T?>(
          context: context,
          builder: (_) {
            return FadeIn(
                duration: Duration(milliseconds: 300),
                child: Dialog(
                    child: Container(
                        width: width ?? w * 0.9,
                        height: height ?? h * 0.4,
                        child: content)));
          }).then((value) => {onResult!(value)});
    } else {
      showModalBottomSheet<T?>(
          context: context,
          isScrollControlled: true, // يسمح للـ Bottom Sheet بالتمدد وتجنب التقيد بـ 50% من الشاشة
          backgroundColor: Colors.transparent, // لجعل الخلفية تبدو انسيابية
          builder: (modalContext) {
            // نستخدم الـ viewInsets لمعرفة المساحة التي تغطيها لوحة المفاتيح
            final keyboardPadding = MediaQuery.of(modalContext).viewInsets.bottom;
            return Padding(
              padding: EdgeInsets.only(bottom: keyboardPadding),
              child: FadeIn(
                duration: Duration(milliseconds: 300),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  width: width ?? w * 0.9,
                  height: height ?? h * 0.5, // نحدد الارتفاع المطلوب أو الافتراضي
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                      child: SafeArea(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // خط سحب صغير في الأعلى للجمالية وسهولة الإغلاق
                            Container(
                              width: 40,
                              height: 5,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            const SizedBox(height: 15),
                            Expanded(
                              child: SingleChildScrollView(
                                child: content,
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
              ),
            );
          }).then((value) => {onResult?.call(value)});
    }
  }
}
