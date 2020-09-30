import 'package:flutter/material.dart';
import 'package:flutter_carwashing/telas/agendaEditTela.dart';
import 'package:flutter_carwashing/telas/agendaListTela.dart';
import 'package:flutter_carwashing/telas/clienteEditTela.dart';
import 'package:flutter_carwashing/telas/clienteListTela.dart';
import 'package:flutter_carwashing/telas/servicoEditTela.dart';

class servicoListTela extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Lista de Serviços'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
//              Padding(
//                padding: EdgeInsets.all(10.0),
//                child: ButtonTheme(
//                  minWidth: 200.0,
//                  height: 75.0,
//                  buttonColor: Colors.blue,
//                  child: RaisedButton(
//                    onPressed: () =>
//                        _navegarTela(context, clienteEditTela()),
//                    child: Text("Cadastro de Clientes"),
//                  ),
//                ),
//              ),
              Padding(
                  padding: EdgeInsets.all(10.0),
                  child: ButtonTheme(
                    minWidth: 200.0,
                    height: 75.0,
                    child: RaisedButton(
                      onPressed: () => _navegarTela(context, agendaEditTela()),
                      child: Text("Agendar Serviço"),
                    ),
                  ),
              ),
              Padding(
                  padding: EdgeInsets.all(10.0),
                  child: ButtonTheme(
                    minWidth: 200.0,
                    height: 75.0,
                    child: RaisedButton(
                      color: Colors.blue,
                      onPressed: () => _navegarTela(context, agendaListTela()),
                      child: Text("Agenda"),
                    ),
                  ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: ButtonTheme(
                  minWidth: 200.0,
                  height: 75.0,
                  child: RaisedButton(
                    onPressed: () => _navegarTela(context, clienteListTela()),
                    child: Text("Lista de Clientes"),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  _navegarTela(BuildContext context, tela) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => tela));
  }
}
