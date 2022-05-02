import 'package:controlegastos/app/core/providers/connections/entrada_connection.dart';
import 'package:controlegastos/app/core/providers/connections/saida_connection.dart';
import 'package:flutter/cupertino.dart';

class HomeController {
  late final ValueNotifier<double> real_balance = ValueNotifier(0);
  late final double future_balance;

  final EntradaConnection _entradaConnection;
  final SaidaConnection _saidaConnection;

  HomeController(this._entradaConnection, this._saidaConnection) {
    _init();
  }

  void _init() {
    _getBalances();
  }

  void _getBalances() async {
    double totalEntrada = await _entradaConnection.getAvailableBalance();
    double totalSaida = await _saidaConnection.getAvailableBalance();

    real_balance.value = totalEntrada - totalSaida;
  }
}