import 'package:flutter/material.dart';
import 'package:flutter_carwashing/services/internet_service.dart';
import 'package:flutter_carwashing/telas/agenda/agendaListTela.dart';
import 'package:flutter_carwashing/telas/cliente/clienteListTela.dart';
import 'package:flutter_carwashing/telas/horario/horarioListTela.dart';
import 'package:flutter_carwashing/telas/servico/servicoListTela.dart';
import 'package:flutter_carwashing/widgets/network_sensitivity.dart';

class homeTela extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(
              title: Text('Home'),
          ),
          body: NetworkSensitive(
            child: SingleChildScrollView(
                padding: EdgeInsets.all(10.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.max,
                    children: [
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
                        Padding(
                            padding: EdgeInsets.all(10.0),
                            child: ButtonTheme(
                                minWidth: 200.0,
                                height: 75.0,
                                child: RaisedButton(
                                    onPressed: () => _navegarTela(context, servicoListTela()),
                                    child: Text("Lista de Serviços"),
                                ),
                            ),
                        ),
                        Padding(
                            padding: EdgeInsets.all(10.0),
                            child: ButtonTheme(
                                minWidth: 200.0,
                                height: 75.0,
                                child: RaisedButton(
                                    onPressed: () => _navegarTela(context, horarioListTela()),
                                    child: Text("Lista de Horarios"),
                                ),
                            ),
                        ),
                        Padding(
                            padding: EdgeInsets.all(10.0),
                            child: ButtonTheme(
                                minWidth: 200.0,
                                height: 75.0,
                                child: RaisedButton(
                                    onPressed: () => _teste(context),
                                    child: Text("TESTE"),
                                ),
                            ),
                        ),
                    ],
                ),
            ),
          ),
      );
  }

  _teste(BuildContext context){
      //var connectionStatus = Provider.of<ConnectivityStatus>(context);
      InternetService internet = new InternetService(context);
      print( internet.status );

  }
  _navegarTela(BuildContext context, tela) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => tela));
  }
}
