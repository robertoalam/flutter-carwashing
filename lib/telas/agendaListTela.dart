import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_carwashing/model/agendaModel.dart';
import 'package:flutter_carwashing/model/agendaTruncadoModel.dart';

class agendaListTela extends StatefulWidget {
  @override
  _agendaListTelaState createState() => _agendaListTelaState();
}

class _agendaListTelaState extends State<agendaListTela> {
  var agendaLista = new List<AgendaModel>();
  var agendaLista2 = new List<String>();

  List<AgendaTruncadoModel> agendaTruncado = new List<AgendaTruncadoModel>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _buscarAgenda();
  }

  _buscarAgenda() async {
    AgendaModel agenda = new AgendaModel(2,2,"teste","tse",1);
    agendaLista2 = await agenda.buscarTruncado() ;

    setState(() {

      for(int i = 0; i < agendaLista2.length ; i++){
        Map<String,dynamic> user = agendaLista2[i];

//        AgendaTruncadoModel agendaTruncado = new AgendaTruncadoModel(1,"beto","09/09/2020","15:00", "lavagem");
//        print( agendaTruncado.toString() );
      }
//      print(agendaLista2);
      //agendaLista2;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Lista de Clientes"),
        ),
        body: ListView.builder(
          itemCount: agendaLista.length,
          itemBuilder: (BuildContext context, int index) {
            return _cardExibirConteudo(context, index);
          },
        )
    );
  }

  _cardExibirConteudo(BuildContext context,int index){
    if( agendaLista2.length != null ) {
      return Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
//            Text(agendaLista2[index].nome, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),),
//            Text(agendaLista2[index].cliente.toString()),
//            Text(agendaLista2[index].hora.toString()),
          ],
        ),
      );
    }
  }
}
