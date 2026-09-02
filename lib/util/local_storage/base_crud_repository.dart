import 'package:sqflite/sqflite.dart';
import 'data_model.dart';
import 'i_crud.dart';

/// Generic Base Repository providing automated CRUD implementations for any DataModel in JoDija.
abstract class BaseCrudRepository<T extends DataModel> implements ICrud<T> {
  final Future<Database> Function()? _dbProvider;
  final T Function(Map<String, dynamic> map)? _fromMapFunc;
  final String? _tableNameParam;
  final String? _primaryKeyColumnParam;

  BaseCrudRepository({
    Future<Database> Function()? databaseProvider,
    T Function(Map<String, dynamic> map)? fromMap,
    String? tableName,
    String? primaryKeyColumn,
  })  : _dbProvider = databaseProvider,
        _fromMapFunc = fromMap,
        _tableNameParam = tableName,
        _primaryKeyColumnParam = primaryKeyColumn;

  /// The SQLite table name
  String get tableName => _tableNameParam ?? '';

  /// The primary key column name
  String get primaryKeyColumn => _primaryKeyColumnParam ?? '';

  /// Factory function to deserialize a Map to model instance T
  T fromMap(Map<String, dynamic> map) {
    if (_fromMapFunc != null) {
      return _fromMapFunc!(map);
    }
    throw UnimplementedError('fromMap must be provided via constructor or overridden in subclass.');
  }

  /// Access to the underlying Database instance
  Future<Database> get db {
    if (_dbProvider != null) return _dbProvider!();
    throw UnimplementedError('Database provider must be supplied or db getter overridden in subclass.');
  }

  @override
  Future<int> insert(T item) async {
    final database = await db;
    return await database.insert(
      tableName,
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> insertAll(List<T> models) async {
    if (models.isEmpty) return;
    final database = await db;
    await database.transaction((txn) async {
      final batch = txn.batch();
      for (final model in models) {
        batch.insert(
          tableName,
          model.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      await batch.commit(noResult: true);
    });
  }

  @override
  Future<int> update(T item) async {
    final database = await db;
    return await database.update(
      tableName,
      item.toMap(),
      where: '$primaryKeyColumn = ?',
      whereArgs: [item.primaryKeyValue],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<int> delete(dynamic id) async {
    final database = await db;
    return await database.delete(
      tableName,
      where: '$primaryKeyColumn = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<int> deleteWhere({
    required String where,
    required List<dynamic> whereArgs,
  }) async {
    final database = await db;
    return await database.delete(
      tableName,
      where: where,
      whereArgs: whereArgs,
    );
  }

  @override
  Future<int> clear() async {
    final database = await db;
    return await database.delete(tableName);
  }

  @override
  Future<int> deleteAll() => clear();

  @override
  Future<T?> getById(dynamic id) async {
    final database = await db;
    final results = await database.query(
      tableName,
      where: '$primaryKeyColumn = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (results.isEmpty) return null;
    return fromMap(results.first);
  }

  @override
  Future<List<T>> getAll({
    String? where,
    List<dynamic>? whereArgs,
    String? orderBy,
    int? limit,
    int? offset,
  }) async {
    final database = await db;
    final results = await database.query(
      tableName,
      where: where,
      whereArgs: whereArgs,
      orderBy: orderBy,
      limit: limit,
      offset: offset,
    );
    return results.map((map) => fromMap(map)).toList();
  }

  @override
  Future<List<T>> query({
    String? where,
    List<Object?>? whereArgs,
    String? orderBy,
    int? limit,
    int? offset,
  }) async {
    final database = await db;
    final results = await database.query(
      tableName,
      where: where,
      whereArgs: whereArgs,
      orderBy: orderBy,
      limit: limit,
      offset: offset,
    );
    return results.map((map) => fromMap(map)).toList();
  }

  @override
  Future<int> count({String? where, List<dynamic>? whereArgs}) async {
    final database = await db;
    final result = await database.rawQuery(
      'SELECT COUNT(*) as total FROM $tableName'
      '${where != null ? ' WHERE $where' : ''}',
      whereArgs,
    );
    if (result.isNotEmpty && result.first['total'] != null) {
      return (result.first['total'] as num).toInt();
    }
    return 0;
  }
}
