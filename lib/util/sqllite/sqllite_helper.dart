import 'dart:io';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

class SqlLiteHelper {
  String dbname;
  int version;
  String assetPath = "";
  String? _dbPath;
  bool _useingAsset = false;
  Database? database;
  File? dbfile;
  SqlLiteHelper.init({required this.dbname, required this.version});
  SqlLiteHelper.initfromasset(
      {required this.dbname, required this.assetPath, required this.version}) {
    _useingAsset = true;
  }

  Future<File> copyDatabaseFromAsset() async {
    ByteData data = await rootBundle.load("$assetPath$dbname");
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    return File(dbfile!.path).writeAsBytes(bytes);
  }

  Future<bool> _open(String path) async {
    database = await openDatabase(path);
    return database!.isOpen;
  }

  Future<int> loadDataBase() async {
    _dbPath = await getDatabasesPath();
    dbfile = File("$_dbPath/$dbname");
    bool fileExists = await dbfile!.exists();

    bool exists = await dbfile!.exists();
    if (exists) {
      var databasesPath = await getDatabasesPath();

      bool dd = await _open(dbfile!.path);
      if (dd) {
        return 1;
      }
      ;
    } else {
      if (_useingAsset) {
        File f = await copyDatabaseFromAsset();

        if (await f.exists()) {
          bool dd = await _open(dbfile!.path);
          if (dd) {
            return 1;
          }
          return 0;
        }
      } else {}
    }
    return 0;
  }
}
