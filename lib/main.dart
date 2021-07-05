import 'package:controlegastos/screens/entradas/new_entrada_screen.dart';
import 'package:controlegastos/widgets/form_popup/form_popup.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.orange,
        textTheme: TextTheme(
          button: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  openTransactionFormModal(BuildContext context) {
    showDialog(
      context: context,
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.vertical(
      //     top: Radius.circular(20.0),
      //   ),
      // ),
      builder: (_) {
        return FormPopUpWidget(
          fields: NewEntradaPage(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Controle de Gastos'),
      ),
      body: Container(),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.event_add,
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Theme.of(context).accentColor,
        children: [
          SpeedDialChild(
            child: Icon(Icons.file_download),
            backgroundColor: Colors.green,
            label: 'Nova entrada',
            onTap: () => Modular,
          ),
        ],
      ),
    );
  }
}
