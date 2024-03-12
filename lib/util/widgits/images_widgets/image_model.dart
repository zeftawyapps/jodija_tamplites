import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class FileModel {
  String networkImage = "";
  File? fileImage;
  File? fileImageFrombytes;
  Uint8List? Imagebytes;
  String fileImagePath = '';
  XFile? xFile;
  MultipartFile? multiFile;
  FileModel(
      {this.fileImage,
      required this.fileImagePath,
      this.xFile,
      this.Imagebytes,
      this.fileImageFrombytes,
      this.multiFile,
      required this.networkImage});
}
