import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_carwashing/model/agendaModel.dart';
import 'package:flutter_carwashing/model/agendaTruncadoModel.dart';

import '../model/agendaTruncadoModel.dart';

class agendaListTela extends StatefulWidget {
  @override
  _agendaListTelaState createState() => _agendaListTelaState();
}

class _agendaListTelaState extends State<agendaListTela> {
  var agendaLista3 = new List<AgendaTruncadoModel>();

  List<AgendaTruncadoModel> agendaTruncado = new List<AgendaTruncadoModel>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _buscarAgenda();
  }

  _buscarAgenda() async {
    AgendaModel agenda = new AgendaModel(2,2,"teste","tse",1);
    agendaLista3 = await agenda.buscarTruncado() ;

    setState(() {
      agendaLista3;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Lista de Serviços"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {},
          child: Icon(Icons.add),
        ),
        body: ListView.builder(
          itemCount: agendaLista3.length,
          itemBuilder: (BuildContext context, int index) {
            return _cardExibirConteudo(context, index);
          },
        )
    );
  }

  _cardExibirConteudo(BuildContext context,int index){
      return Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: <Widget>[
                Icon(Icons.person),
                Text(agendaLista3[index].cliente, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),),
              ],
            ),
            Row(
              children: <Widget>[
                Icon(Icons.calendar_today),
                Text(agendaLista3[index].data),
                Text(" - "),
                Text(agendaLista3[index].hora),
              ],
            ),
            Row(
              children: <Widget>[
                Icon(Icons.star),
                Text(agendaLista3[index].servico),
              ],
            ),
          ],
        ),
      );

  }
}
