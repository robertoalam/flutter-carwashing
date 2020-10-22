import 'package:flutter/material.dart';
import 'package:flutter_carwashing/services/internet_service.dart';
import 'package:flutter_carwashing/telas/agenda/agendaListTela.dart';
import 'package:flutter_carwashing/telas/cliente/clienteListTela.dart';
import 'package:flutter_carwashing/telas/horario/horarioListTela.dart';
import 'package:flutter_carwashing/telas/servico/servicoListTela.dart';
import 'package:flutter_carwashing/widgets/network_sensitivity.dart';

class homeTela extends StatelessWidget {

    final List<Map<String,dynamic>> _listagem = [
        {'label':'Agenda','tela':agendaListTela(),'imagem':'agenda.jpg'},
        {'label':'Lista de Clientes','tela':clienteListTela(),'imagem':'clientes.jpg'},
        {'label':'Lista de Serviços','tela':servicoListTela(),'imagem':'servicos.jpg'},
        {'label':'Lista de Horarios','tela':horarioListTela(),'imagem':'horarios.jpg'},
    ];

  @override
  Widget build(BuildContext context) {
      print(_listagem.length);
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
                    children: _listagem.map( ( item ){
                        return Padding(
                            padding: EdgeInsets.all(10.0),
                            child: ButtonTheme(
                                minWidth: 200.0,
                                height: 75.0,
                                child: RaisedButton(
                                    color: Colors.blue,
                                    onPressed: () => _navegarTela(context, item['tela'] ),
                                    child: Text( item['label']),
                                ),
                            ),
                        );
                    }).toList(),
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
