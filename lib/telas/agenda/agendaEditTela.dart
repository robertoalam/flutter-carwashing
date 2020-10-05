import 'dart:async';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carwashing/model/horarioModel.dart';
import 'package:flutter_carwashing/model/agendaModel.dart';
import 'package:flutter_carwashing/model/clienteModel.dart';
import 'package:flutter_carwashing/model/servicoModel.dart';
import 'package:intl/intl.dart';
import 'dart:core';

class agendaEditTela extends StatefulWidget {

  final AgendaModel agenda;
  agendaEditTela({this.agenda});

  @override
  _agendaEditTelaState createState() => _agendaEditTelaState();
}

class _agendaEditTelaState extends State<agendaEditTela> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _agendaId = TextEditingController();

  // CLIENTES
  ClienteModel cliente = new ClienteModel();
  var _clientesLista = new List<ClienteModel>();
  List<DropdownMenuItem<String>> _dropDownMenuItemsClientes;  
  String _clienteSelecionado;
  
  // DATA
  final _agendaDataController = TextEditingController();
  Map<String, dynamic> data;
  
  // HORARIO
  HorarioModel horario = HorarioModel();
  var _horariosLista = new List<HorarioModel>();
  List<DropdownMenuItem<String>> _dropDownMenuItemsHorarios;
  String _horarioSelecionado ;
  
  // SERVICO
  ServicoModel servico = new ServicoModel();
  var _servicosLista = new List<ServicoModel>();
  List<DropdownMenuItem<String>> _dropDownMenuItemsServicos;
  String _servicoSelecionado;

  @override
  void initState() {
    super.initState();
    _carregarSelect();

    // SE VIAR UM OBJETO PARA ESSA TELA, CARREGAR DADOS NOS CONTROLLERS
    if(widget.agenda != null){
      _carregarDadosTela(widget.agenda);
    }
  }

  _carregarDadosTela( objeto ){
    _agendaId.text = objeto.id.toString();
    _clienteSelecionado = objeto.cliente.id.toString();
    _agendaDataController.text = objeto.data.toString();
    _horarioSelecionado = objeto.hora.id.toString();
    _servicoSelecionado = objeto.servico.id.toString();
  }

  _carregarSelect() async {
    _clientesLista = await cliente.buscar();
    _servicosLista = await servico.buscar();
    _horariosLista = await horario.buscar();
    _servicosLista = await servico.buscar();
    setState(() {
      _dropDownMenuItemsClientes = getDropDownMenuItemsClientes(_clientesLista);
      _dropDownMenuItemsHorarios = getDropDownMenuItemsHorarios(_horariosLista);
      _dropDownMenuItemsServicos = getDropDownMenuItemsHorarios(_servicosLista);
    });
  }

  final format = DateFormat("dd/MM/yyyy");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Agendar Servico"),
      ),
      body:SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.person,),
                    Text("Cliente:"),
                  ],
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child:  Column(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: MediaQuery.of(context).size.width - 20,
                          padding:EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: new DropdownButton(
                            items: _dropDownMenuItemsClientes,
                            value: _clienteSelecionado,
                            onChanged: _clienteOnChanged,
                            hint: Text("Selecione um CLIENTE"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.calendar_today_sharp,),
                    Text("Data:"),
                  ],
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child:Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: DateTimeField(
                          controller: _agendaDataController,
                          decoration: new InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: '01/01/2020',
                            labelText: 'Data de Aplicação'
                          ),
                          format: format,
                          onShowPicker: (context, currentValue) {
                            return showDatePicker(
                                context: context,
                                firstDate: DateTime(2000),
                                initialDate: currentValue ?? DateTime.now(),
                                lastDate: DateTime(2100)
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.lock_clock,),
                    Text("Horario:"),
                  ],
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child:  Column(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: MediaQuery.of(context).size.width - 20,
                          padding:EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: new DropdownButton(
                            items: _dropDownMenuItemsHorarios,
                            value: _horarioSelecionado,
                            onChanged: _horarioOnChanged,
                            hint: Text("Selecione um HORÁRIO"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.work,),
                    Text("Serviço:"),
                  ],
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child:  Column(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: MediaQuery.of(context).size.width - 20,
                          padding:EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: new DropdownButton(
                            items: _dropDownMenuItemsServicos,
                            value: _servicoSelecionado,
                            onChanged: _servicoOnChanged,
                            hint: Text("Selecione um SERVIÇO"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: ButtonTheme(
                    buttonColor: Colors.blue,
                    child: RaisedButton(
                      onPressed: () async {
                        await _salvar( context );
                      },
                      child: Text("SALVAR"),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
      ),
    );
  }



  void _clienteOnChanged(String selecionado) {
    setState(() {
      _clienteSelecionado = selecionado;
    });
  }
  void _horarioOnChanged(String selecionado) {
    setState(() {
      _horarioSelecionado = selecionado;
    });
  }
  void _servicoOnChanged(String selecionado) {
    setState(() {
      _servicoSelecionado = selecionado;
    });
  }

  List<DropdownMenuItem<String>> getDropDownMenuItemsClientes( clientes ) {
    List<DropdownMenuItem<String>> items = new List();
    for (var cliente in clientes) {
      items.add(new DropdownMenuItem(
        value: cliente.id.toString(), child: new Text(cliente.nome)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getDropDownMenuItemsHorarios( horarios ) {
    List<DropdownMenuItem<String>> items = new List();
    for (var horario in horarios) {
      items.add(new DropdownMenuItem(
        value: horario.id.toString(), child: new Text(horario.descricao)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getDropDownMenuItemsServicos( servicos ) {
    List<DropdownMenuItem<String>> items = new List();
    for (var servico in servicos) {
      items.add(new DropdownMenuItem(
        value: servico.id.toString(), child: new Text(servico.descricao)));
    }
    return items;
  }

  _salvar( BuildContext context ) async {
    _agendaId.text = (_agendaId.text.toString().isNotEmpty ) ? _agendaId.text.toString() : "0" ;
    cliente = await cliente.buscarID( int.parse( _clienteSelecionado ) );
    horario = await horario.buscarID( int.parse( _horarioSelecionado ) );
    servico = await servico.buscarID( int.parse( _servicoSelecionado ) );

    AgendaModel objeto;

    if( _agendaId.text.toString() == "0" ){
      objeto = new AgendaModel(
        cliente: cliente ,
        data: _agendaDataController.text.toString() ,
        hora: horario ,
        servico: servico ,
      );
    }else{
      objeto = new AgendaModel(
        id: int.parse( _agendaId.text ),
        cliente: cliente ,
        data: _agendaDataController.text.toString() ,
        hora: horario ,
        servico: servico ,
      );
    }
    var retorno = objeto.salvar();
    String msg = ( retorno ) ? "Sucesso !!!": "Erro :( ";
    final snackBar = SnackBar(content: Text( msg ));
    _scaffoldKey.currentState.showSnackBar(snackBar);

    //SE GRAVOU COM SUCESSO VOLTA UMA TELA
    if( retorno ){
      Timer( Duration(seconds: 2) , ()=>
          Navigator.pop(context,objeto),
      );
    }

  }
}