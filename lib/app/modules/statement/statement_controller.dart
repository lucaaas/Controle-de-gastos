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
    List<TransactionModel> transactions = _mergeTransactions(entradas, saidas);

    EntradaModel previousBalance = await _getPreviousMonthBalance(int.parse(monthYear[0]), int.parse(monthYear[1]));
    transactions.insert(0, previousBalance);

    return transactions;
  }

  Future<EntradaModel> _getPreviousMonthBalance(int month, int year) async {
    DateTime date = DateTime(year, month);
    DateTime previousMonth = date.subtract(const Duration(days: 1));

    double previousEntrada = await _entradaConnection.getTotal(month: previousMonth);
    double previousSaida = await _saidaConnection.getTotal(month: previousMonth);
    double previousMonthBalance = previousEntrada - previousSaida;

    EntradaModel previousEntradaBalance = EntradaModel(
      descricao: 'Saldo mês anterior',
      valor: previousMonthBalance,
      data: previousMonth,
      categorias: [],
    );

    return previousEntradaBalance;
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
