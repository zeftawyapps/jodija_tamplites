import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

/// Comprehensive Cross-Platform SQLite Database Manager for JoDija.
/// Supports Mobile (Android/iOS), Desktop (macOS/Windows/Linux via FFI), and Web.
/// Supports both pre-populated Asset loading and dynamic programmatic Schema creation.
class LocalDataStorageHelper {
  final String dbname;
  final int version;
  final String assetPath;
  final List<String>? createTableQueries;
  final Future<void> Function(Database db, int version)? onCreate;
  final Future<void> Function(Database db)? onConfigure;
  final Future<void> Function(Database db, int oldVersion, int newVersion)? onUpgrade;

  bool _usingAsset = false;
  Database? database;
  File? dbfile;
  String? _dbPath;

  static final Map<String, LocalDataStorageHelper> _instances = {};

  /// Legacy Constructor for basic initialization
  LocalDataStorageHelper.init({
    required this.dbname,
    required this.version,
  })  : assetPath = '',
        createTableQueries = null,
        onCreate = null,
        onConfigure = null,
        onUpgrade = null;

  /// Legacy Constructor for Asset database initialization
  LocalDataStorageHelper.initfromasset({
    required this.dbname,
    required this.assetPath,
    required this.version,
  })  : _usingAsset = true,
        createTableQueries = null,
        onCreate = null,
        onConfigure = null,
        onUpgrade = null;

  /// Modern Named Factory: Create or reuse database from programmatic SQL Schema
  factory LocalDataStorageHelper.fromSchema({
    required String dbName,
    int version = 1,
    List<String>? createTableQueries,
    Future<void> Function(Database db, int version)? onCreate,
    Future<void> Function(Database db)? onConfigure,
    Future<void> Function(Database db, int oldVersion, int newVersion)? onUpgrade,
  }) {
    return _instances.putIfAbsent(
      dbName,
      () => LocalDataStorageHelper._internal(
        dbname: dbName,
        version: version,
        createTableQueries: createTableQueries,
        onCreate: onCreate,
        onConfigure: onConfigure,
        onUpgrade: onUpgrade,
      ),
    );
  }

  /// Modern Named Factory: Create or reuse database copied from bundled Asset
  factory LocalDataStorageHelper.fromAsset({
    required String dbName,
    required String assetPath,
    int version = 1,
    Future<void> Function(Database db)? onConfigure,
    Future<void> Function(Database db, int oldVersion, int newVersion)? onUpgrade,
  }) {
    return _instances.putIfAbsent(
      dbName,
      () => LocalDataStorageHelper._internal(
        dbname: dbName,
        assetPath: assetPath,
        version: version,
        usingAsset: true,
        onConfigure: onConfigure,
        onUpgrade: onUpgrade,
      ),
    );
  }

  LocalDataStorageHelper._internal({
    required this.dbname,
    this.version = 1,
    this.assetPath = '',
    bool usingAsset = false,
    this.createTableQueries,
    this.onCreate,
    this.onConfigure,
    this.onUpgrade,
  }) : _usingAsset = usingAsset;

  /// Getter to retrieve active Database instance safely (with automatic initialization)
  Future<Database> get db async {
    if (database != null && database!.isOpen) return database!;
    await loadDataBase();
    return database!;
  }

  /// Copies pre-populated database binary file from Flutter Assets
  Future<File> copyDatabaseFromAsset() async {
    final cleanAssetPath = assetPath.endsWith('/') ? assetPath : '$assetPath/';
    final assetKey = '$cleanAssetPath$dbname';
    ByteData data = await rootBundle.load(assetKey);
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    return File(dbfile!.path).writeAsBytes(bytes, flush: true);
  }

  /// Internal helper to open database with proper hooks
  Future<bool> _open(String path) async {
    database = await openDatabase(
      path,
      version: version,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
        if (onConfigure != null) await onConfigure!(db);
      },
      onCreate: (db, ver) async {
        if (createTableQueries != null) {
          for (final query in createTableQueries!) {
            await db.execute(query);
          }
        }
        if (onCreate != null) await onCreate!(db, ver);
      },
      onUpgrade: (db, oldVer, newVer) async {
        if (onUpgrade != null) await onUpgrade!(db, oldVer, newVer);
      },
    );
    return database!.isOpen;
  }

  /// Loads and initializes the database across all platforms (Desktop, Mobile, Web)
  Future<int> loadDataBase() async {
    // 1. Initialize Desktop FFI if running on macOS, Windows, or Linux
    if (!kIsWeb && (Platform.isMacOS || Platform.isWindows || Platform.isLinux)) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }

    // 2. Resolve database path
    if (kIsWeb) {
      _dbPath = inMemoryDatabasePath;
      bool success = await _open(_dbPath!);
      return success ? 1 : 0;
    }

    try {
      final docDir = await getApplicationDocumentsDirectory();
      _dbPath = docDir.path;
    } catch (_) {
      _dbPath = await getDatabasesPath();
    }

    dbfile = File("$_dbPath/$dbname");
    bool fileExists = await dbfile!.exists();

    if (fileExists) {
      bool opened = await _open(dbfile!.path);
      return opened ? 1 : 0;
    } else {
      if (_usingAsset && assetPath.isNotEmpty) {
        File f = await copyDatabaseFromAsset();
        if (await f.exists()) {
          bool opened = await _open(dbfile!.path);
          return opened ? 1 : 0;
        }
      } else {
        bool opened = await _open(dbfile!.path);
        return opened ? 1 : 0;
      }
    }
    return 0;
  }

  /// Clear specified tables within an atomic transaction
  Future<void> clearTables(List<String> tableNames) async {
    final activeDb = await db;
    await activeDb.transaction((txn) async {
      for (final table in tableNames) {
        await txn.delete(table);
      }
    });
  }

  /// Delete the physical database file from disk
  Future<bool> deleteDatabaseFile() async {
    await close();
    if (dbfile != null && await dbfile!.exists()) {
      await dbfile!.delete();
      return true;
    }
    return false;
  }

  /// Close the database connection safely
  Future<void> close() async {
    if (database != null && database!.isOpen) {
      await database!.close();
      database = null;
    }
  }
}
