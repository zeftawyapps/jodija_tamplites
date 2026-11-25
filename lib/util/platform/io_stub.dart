import 'dart:typed_data';

/// Web/Wasm-safe stub for `dart:io` types when `dart.library.io` is unavailable.
class File {
  final String path;

  const File(this.path);

  factory File.fromRawPath(Uint8List rawPath) => const File('');

  Future<bool> exists() async => false;

  Future<File> writeAsBytes(List<int> bytes, {bool flush = false}) {
    throw UnsupportedError('dart:io File.writeAsBytes is not supported on Web.');
  }

  Future<File> delete({bool recursive = false}) {
    throw UnsupportedError('dart:io File.delete is not supported on Web.');
  }

  String readAsStringSync() {
    throw UnsupportedError('dart:io File.readAsStringSync is not supported on Web.');
  }

  void createSync({bool recursive = false, bool exclusive = false}) {
    throw UnsupportedError('dart:io File.createSync is not supported on Web.');
  }

  void writeAsStringSync(String contents, {bool flush = false}) {
    throw UnsupportedError('dart:io File.writeAsStringSync is not supported on Web.');
  }
}

class Directory {
  final String path;

  const Directory(this.path);
}

class Platform {
  static bool get isMacOS => false;
  static bool get isWindows => false;
  static bool get isLinux => false;
  static bool get isAndroid => false;
  static bool get isIOS => false;
}
