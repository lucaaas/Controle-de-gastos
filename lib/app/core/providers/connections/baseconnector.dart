import 'package:controlegastos/app/core/helpers/db_helper.dart';
import 'package:controlegastos/app/core/models/basemodel.dart';
import 'package:controlegastos/app/core/types/message_type.dart';

abstract class BaseConnector {
  /// Saves a [BaseModel] instance into database.
  ///
  /// Returns a [Message] or throws a [DatabaseException].
  Future save(BaseModel model) async {
    if (model.id == null) {
      return insert(model);
    } else {
      return update(model);
    }
  }

  /// Creates a new row of a [BaseModel] into database.
  ///
  /// Returns a [MessageType] containing the inserted id.
  ///
  /// Throws an exception with a [MessageType]
  Future<MessageType> insert(BaseModel model) async {
    try {
      int idInserted =
          await database.insert(table: table, data: model.toJson());

      return MessageType(
        level: MessageLevel.success,
        message: '$table created',
        data: {'id': idInserted},
      );
    } catch (e, stacktrace) {
      throw Exception(
        MessageType(
          level: MessageLevel.error,
          message: 'Não foi possível criar $table: $e',
          data: {'stacktrace': stacktrace},
        ),
      );
    }
  }

  /// Updates a row of [BaseModel].
  ///
  /// Returns a [MessageType] containing the quantity of affected rows.
  ///
  /// Throws an exception with a [MessageType]
  Future<MessageType> update(BaseModel model) async {
    try {
      int rowsAffected = await database.update(
        table: table,
        data: model.toJson(),
        where: 'id = ?',
        whereArgs: [model.id],
      );

      return MessageType(
        level: MessageLevel.success,
        message: '$table atualizado',
        data: {'rowsAffected': rowsAffected},
      );
    } catch (e, stacktrace) {
      throw Exception(
        MessageType(
          level: MessageLevel.error,
          message: 'Não foi possível atualizar $table: $e',
          data: {'stacktrace': stacktrace},
        ),
      );
    }
  }

  /// Deletes a row of [BaseModel] using the [BaseModel.id].
  ///
  /// Returns a [MessageType] containing the quantity of affected rows.
  ///
  /// Throws an exception with a [MessageType]
  Future<MessageType> delete(BaseModel model) async {
    try {
      int rowsAffected = await database.delete(table, 'id=?', [model.id]);
      return MessageType(
        level: MessageLevel.success,
        message: 'Registro apagado.',
        data: {'rowsAffected': rowsAffected},
      );
    } catch (e, stacktrace) {
      throw Exception(
        MessageType(
          level: MessageLevel.error,
          message: 'Não foi possível apagar registro: $e',
          data: {'stacktrace': stacktrace},
        ),
      );
    }
  }

  /// Gets an row from table by [id].
  ///
  /// Returns an instance of [BaseModel].
  ///
  /// Throws an exception with a [MessageType]
  Future<BaseModel> get(int id);

  /// Gets all rows from table.
  ///
  /// Returns an instance of [List<BaseModel>].
  ///
  /// Throws an exception with a [MessageType]
  Future<List<BaseModel>> getAll();

  String get table;

  DBHelper get database;
}
