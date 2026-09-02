import 'data_model.dart';

/// Generic CRUD interface for SQLite operations.
abstract class ICrud<T extends DataModel> {
  /// Inserts a new record into the database table.
  Future<int> insert(T model);

  /// Inserts a batch of records into the database table within a single transaction.
  Future<void> insertAll(List<T> models);

  /// Retrieves a single record by its primary key.
  Future<T?> getById(dynamic id);

  /// Retrieves all records from the table, with optional filtering, sorting, and pagination.
  Future<List<T>> getAll({
    String? where,
    List<dynamic>? whereArgs,
    String? orderBy,
    int? limit,
    int? offset,
  });

  /// Queries records with custom parameters.
  Future<List<T>> query({
    String? where,
    List<Object?>? whereArgs,
    String? orderBy,
    int? limit,
    int? offset,
  });

  /// Updates an existing record identified by its primary key.
  Future<int> update(T model);

  /// Deletes a record identified by its primary key.
  Future<int> delete(dynamic id);

  /// Deletes records matching the given criteria.
  Future<int> deleteWhere({
    required String where,
    required List<dynamic> whereArgs,
  });

  /// Deletes all records from this table.
  Future<int> clear();

  /// Alias to clear table.
  Future<int> deleteAll();

  /// Counts the total number of records matching criteria.
  Future<int> count({String? where, List<dynamic>? whereArgs});
}
