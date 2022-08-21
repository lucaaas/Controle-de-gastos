import 'package:controlegastos/app/core/models/entrada_model.dart';
import 'package:controlegastos/app/core/models/saida_model.dart';
import 'package:controlegastos/app/core/models/transaction_model.dart';
import 'package:controlegastos/app/core/providers/connections/entrada_connection.dart';
import 'package:controlegastos/app/core/providers/connections/saida_connection.dart';

class StatementController {
  final EntradaConnection _entradaConnection;
  final SaidaConnection _saidaConnection;

  StatementController(this._entradaConnection, this._saidaConnection);

  Future<List<TransactionModel>> getTransactions() async {
    List<EntradaModel> entradas = await _entradaConnection.getAllEffectived();
    List<SaidaModel> saidas = await _saidaConnection.getAllEffectived();

    List<TransactionModel> transactions = _mergeTransactions(entradas, saidas);
    return transactions;
  }

  List<TransactionModel> _mergeTransactions(List<EntradaModel> entradas, List<SaidaModel> saidas) {
    List<TransactionModel> transactions = [];

    while (entradas.isNotEmpty || saidas.isNotEmpty) {
      if (entradas.isEmpty) {
        transactions.addAll(saidas.take(saidas.length));
        saidas.clear();
      } else if (saidas.isEmpty) {
        transactions.addAll(entradas.take(entradas.length));
        entradas.clear();
      } else {
        if (entradas.first.data!.compareTo(saidas.first.data!) >= 0) {
          transactions.add(entradas.removeAt(0));
        } else {
          transactions.add(saidas.removeAt(0));
        }
      }
    }

    return transactions;
  }
}