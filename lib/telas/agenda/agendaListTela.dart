import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_carwashing/model/horarioModel.dart';
import 'package:flutter_carwashing/model/agendaModel.dart';
import 'package:flutter_carwashing/model/agendaTruncadoModel.dart';
import 'package:flutter_carwashing/model/clienteModel.dart';
import 'package:flutter_carwashing/model/servicoModel.dart';
import 'package:flutter_carwashing/telas/agenda/agendaEditTela.dart';
import '../../model/agendaTruncadoModel.dart';

class agendaListTela extends StatefulWidget {
  @override
  _agendaListTelaState createState() => _agendaListTelaState();
}

class _agendaListTelaState extends State<agendaListTela> {
  List<AgendaModel> _listagem = new List<AgendaModel>();
  AgendaModel _agenda = new AgendaModel();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getBuscarLista();
  }

  void _getBuscarLista() async {
    _listagem = await _agenda.buscar() ;
    setState(() {
      _listagem;
    });
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Agenda do Dia"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _editarObjeto(),
          child: Icon(Icons.add),
        ),
        body: ListView.builder(
          itemCount: _listagem.length,
          itemBuilder: (BuildContext context, int index) {
            return _cardExibirConteudo(context, index);
          },
        )
    );
  }

  _editarObjeto({AgendaModel agenda}) async {
    final retorno = await Navigator.push(context, MaterialPageRoute(builder: (context) => agendaEditTela(agenda: agenda ) ) );
    if(retorno != null){
      _getBuscarLista();
    }
  }
  _cardExibirConteudo(BuildContext context,int index){
      return Card(
        child: GestureDetector(
          onTap: ()=> _editarObjeto( agenda: _listagem[index] ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: <Widget>[
                  Icon(Icons.person),
                  Text(_listagem[index].cliente.nome.toString(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),),
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.calendar_today),
                  Text(_listagem[index].data),
                  Text(" - "),
                  Text(_listagem[index].hora.descricao),
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.star),
                  Text(_listagem[index].servico.descricao),
                ],
              ),
            ],
          ),
        ),
      );
  }
}
