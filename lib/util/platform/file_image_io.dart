import 'dart:io';
import 'package:flutter/widgets.dart';

Widget buildPlatformFileImage(
  Object file, {
  BoxFit? fit,
  double? width,
  double? height,
}) {
  return Image.file(
    file as File,
    fit: fit,
    width: width,
    height: height,
  );
}
