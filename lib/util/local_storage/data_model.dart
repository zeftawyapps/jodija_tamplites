/// Base contract for any SQLite data model in the application.
abstract class DataModel {
  const DataModel();

  /// The SQLite table name associated with this model
  String get tableName;

  /// The primary key column name in SQLite
  String get primaryKeyColumn;

  /// The primary key value for this model instance
  dynamic get primaryKeyValue;

  /// Converts the model instance into a SQLite compatible Map
  Map<String, dynamic> toMap();
}
