import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'financas.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE cartao_credito(id INTEGER PRIMARY KEY NOT NULL, nome TEXT, cor TEXT);'
          'CREATE TABLE categoria(id INTEGER PRIMARY KEY NOT NULL, nome TEXT, cor TEXT, descricao TEXT);'
          'CREATE TABLE saida(id INTEGER PRIMARY KEY NOT NULL, descricao TEXT, valor REAL, data TEXT, cartao_credito INTEGER, FOREIGN KEY(cartao_credito) REFERENCES cartao_credito(id));'
          'CREATE TABLE entrada(id INTEGER PRIMARY KEY NOT NULL, descricao TEXT, valor REAL, data TEXT);'
          'CREATE TABLE saida_possui_categoria(id_saida INTEGER, id_categoria INTEGER, PRIMARY KEY(id_saida, id_categoria),FOREIGN KEY(id_saida) REFERENCES saida(id), FOREIGN KEY(id_categoria) REFERENCES categoria(id));'
          'CREATE TABLE entrada_possui_categoria(id_entrada INTEGER, id_categoria INTEGER, PRIMARY KEY(id_entrada, id_categoria),FOREIGN KEY(id_entrada) REFERENCES entrada(id), FOREIGN KEY(id_categoria) REFERENCES categoria(id));'
      );
    }, version: 1);
  }

  static Future<int> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    return await db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<int> update(String table, Map<String, Object> data, String where, List whereArgs) async {
    final db = await DBHelper.database();
    return await db.update(table, data, where: where, whereArgs: whereArgs);
  }

  static Future<int> delete(String table,  String where, List whereArgs) async {
    final db = await DBHelper.database();
    return await db.delete(table, where: where, whereArgs: whereArgs);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }
}
