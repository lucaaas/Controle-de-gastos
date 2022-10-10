import 'package:controlegastos/app/core/models/entrada_model.dart';
import 'package:controlegastos/app/core/models/transaction_model.dart';
import 'package:controlegastos/app/core/providers/connections/entrada_connection.dart';
import 'package:controlegastos/app/core/providers/connections/saida_connection.dart';

class StatementController {
  final EntradaConnection _entradaConnection;
  final SaidaConnection _saidaConnection;

  StatementController(this._entradaConnection, this._saidaConnection);

  Future<List<String>> getMonths() async {
    List<String> entradaMonths = await _entradaConnection.getTransactionsMonths();
    List<String> saidaMonths = await _saidaConnection.getTransactionsMonths();

    List<String> months = [
      ...{...entradaMonths, ...saidaMonths}
    ]; // ...{} removes duplicates
    months.sort();

    return months;
  }

  Future<List<TransactionModel>> getTransactions(String month) async {
    List<String> monthYear = month.split('/');
    String formattedMonth = '${monthYear[1]}-${monthYear[0]}';

    List<TransactionModel> entradas = await _entradaConnection.getAllEffectived(formattedMonth);
    List<TransactionModel> saidas = await _saidaConnection.getAllEffectived(formattedMonth);

    DateTime date = DateTime(int.parse(monthYear[1]), int.parse(monthYear[0]));
    DateTime previousMonth = date.subtract(const Duration(days: 1));
    List<TransactionModel> transactions = _mergeTransactions(entradas, saidas);

    double previousMonthBalance = await _entradaConnection.getAvailableBalance(month: previousMonth);
    transactions.insert(0,
      EntradaModel(
        descricao: 'Saldo mês anterior',
        valor: previousMonthBalance,
        data: previousMonth,
        categorias: [],
      ),
    );

    return transactions;
  }

  List<TransactionModel> _mergeTransactions(List<TransactionModel> entradas, List<TransactionModel> saidas) {
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
