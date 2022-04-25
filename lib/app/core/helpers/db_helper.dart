import 'package:flutter_modular/flutter_modular.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart';

class DBHelper {
  Future<int> delete(String table, String where, List whereArgs) async {
    final db = await _database;
    return await db.delete(table, where: where, whereArgs: whereArgs);
  }

  /// This queries a table and return the rows found.
  ///
  /// Returns a [List<Map<String, dynamic>>]
  ///
  /// If no filters is provided, it returns a list containing all rows of [table].
  Future<List<Map<String, dynamic>>> getData({
    required String table,
    List<String>? columns,
    String? where,
    List<Object>? whereArgs,
    bool? distinct,
    String? groupBy,
    int? limit,
    String? orderBy,
  }) async {
    final db = await _database;
    return db.query(
      table,
      columns: columns,
      where: where,
      whereArgs: whereArgs,
      distinct: distinct,
      groupBy: groupBy,
      orderBy: orderBy,
      limit: limit,
    );
  }

  /// This queries a [table] and return a row containing the [id].
  ///
  /// Return a Map<String, dynamic>.
  /// ```dart
  ///  Map<String, dynamic> data = await database.getDataById(tableModel, model.id);
  ///  ```
  Future<Map<String, dynamic>> getDataById({required String table, required int id}) async {
    final db = await _database;
    List<Map<String, dynamic>> data = await db.query(table, where: 'id=?', whereArgs: [id]);
    return data.first;
  }

  /// Creates a new row on [table]
  ///
  /// Returns the new id.
  /// ```dart
  /// int idInserted = await database.insert(tableModel, model.toMap());
  /// ```
  Future<int> insert({required String table, required Map<String, dynamic> data}) async {
    final db = await _database;
    return await db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  /// Updates the [table] with [data] values that satisfies the [where] condition.
  ///
  /// Returns the number of affected rows.
  ///
  /// ```dart
  /// int rowsAffected = await database.update(tableModel, model.toMap(), 'id = ?', [model.id]);
  /// ```
  Future<int> update({
    required String table,
    required Map<String, dynamic> data,
    required String where,
    required List whereArgs,
  }) async {
    final db = await _database;
    return await db.update(table, data, where: where, whereArgs: whereArgs);
  }

  Future<Database> get _database async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'financas.db'), onCreate: (db, version) {
      db.execute('CREATE TABLE cartao_credito(id INTEGER PRIMARY KEY, nome TEXT, cor INTEGER, createdAt TEXT);');
      db.execute(
          'CREATE TABLE categoria(id INTEGER PRIMARY KEY NOT NULL, nome TEXT, cor INTEGER, descricao TEXT, createdAt TEXT);');
      db.execute(
          'CREATE TABLE saida(id INTEGER PRIMARY KEY NOT NULL, descricao TEXT, valor REAL, data TEXT, createdAt TEXT,  cartao_credito INTEGER, FOREIGN KEY(cartao_credito) REFERENCES cartao_credito(id));');
      db.execute(
          'CREATE TABLE entrada(id INTEGER PRIMARY KEY NOT NULL, descricao TEXT, valor REAL, data TEXT, createdAt TEXT);');
      db.execute(
          'CREATE TABLE saida_possui_categoria(id_saida INTEGER, id_categoria INTEGER, createdAt TEXT, PRIMARY KEY(id_saida, id_categoria),FOREIGN KEY(id_saida) REFERENCES saida(id), FOREIGN KEY(id_categoria) REFERENCES categoria(id));');
      db.execute(
          'CREATE TABLE entrada_possui_categoria(id_entrada INTEGER, id_categoria INTEGER, createdAt TEXT, PRIMARY KEY(id_entrada, id_categoria),FOREIGN KEY(id_entrada) REFERENCES entrada(id), FOREIGN KEY(id_categoria) REFERENCES categoria(id));');
    }, version: 1);
  }
}

final $DBHelper = BindInject((i) => DBHelper());
