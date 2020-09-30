import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carwashing/model/agendaModel.dart';
import 'package:flutter_carwashing/model/clienteModel.dart';
import 'package:flutter_carwashing/model/servicoModel.dart';
import 'package:intl/intl.dart';
import 'dart:core';

class agendaEditTela extends StatefulWidget {
  @override
  _agendaEditTelaState createState() => _agendaEditTelaState();
}

class _agendaEditTelaState extends State<agendaEditTela> {

  var _clientesTeste = new List<ClienteModel>();
  final _agendaDataController = TextEditingController();
  var _servicosTeste = new List<ServicoModel>();
  int _servicoSelecionado = 0;
  List _horarios = ["selecione","08:00","09:00","10:00", "11:00", "14:00", "15:00", "16:00", "17:00"];

  List<DropdownMenuItem<String>> _dropDownMenuItemsClientes;
  List<DropdownMenuItem<String>> _dropDownMenuItemsHorarios;
  Map<String, dynamic> data;
  String _clienteSelecionado,_horarioSelecionado ;

  @override
  void initState() {
    super.initState();
    _buscarClientes();
    _dropDownMenuItemsHorarios = getDropDownMenuItemsHorarios();
    _horarioSelecionado = _dropDownMenuItemsHorarios[0].value;
    _buscarServicos();
  }

  _buscarClientes() async {
    ClienteModel cliente = new ClienteModel();
    _clientesTeste = await cliente.buscar();
    setState(() {
      _dropDownMenuItemsClientes = getDropDownMenuItemsClientes(_clientesTeste);
    });
  }

  _buscarServicos() async {
    ServicoModel servico = new ServicoModel(1, "teste");
    _servicosTeste = await servico.buscar();
    setState(() {
      _servicosTeste;

    });
  }
  final format = DateFormat("dd/MM/yyyy");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agendar Servico"),
      ),body: ListView(
      children: [
        Column(
          children: [
            new Container(
                margin: EdgeInsets.only(right: 16.0),
                color: Colors.white,
                child: new Row(
                  children: <Widget>[
                    new Icon(Icons.person),
                    new Padding(
                      padding: EdgeInsets.only(left: 12.0, right: 10.0),
                      child: new Text( "Cliente : " ),
                    ),
                    new DropdownButton(
                      items: _dropDownMenuItemsClientes,
                      value: _clienteSelecionado,
                      onChanged: _clienteOnChanged,
                      hint: Text("Selecione uma unidade"),
                    )
                  ],
                )
            ),
            SizedBox(
              height: 5.0,
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: DateTimeField(
                controller: _agendaDataController,
                decoration: new InputDecoration(
                    icon: const Icon(Icons.calendar_today),
                    hintText: '01/01/2020',
                    labelText: 'Data de Aplicação'),
                format: format,
                onShowPicker: (context, currentValue) {
                  return showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2100));
                },
              ),
            ),
            Container(
              child: Row(
                children: [
                  Icon(Icons.access_time),
                  new Padding(
                    padding: EdgeInsets.only(left: 12.0, right: 10.0),
                    child: new Text( "Horario : " ),
                  ),
                  new DropdownButton(
                    value: _horarioSelecionado,
                    items: _dropDownMenuItemsHorarios,
                    onChanged: _horarioOnChanged,
                  )
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  for (var servico in _servicosTeste)
                    Row(
                      children: [
                        Radio(
                          value: servico.id,
                          groupValue: _servicoSelecionado,
                          onChanged: _servicoRadioOnChanged,
                        ),
                        Text(servico.nome),
                      ],
                    ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: ButtonTheme(
                buttonColor: Colors.blue,
                child: RaisedButton(
                  onPressed: () => _salvar(),
                  child: Text("SALVAR"),
                ),
              ),
            ),
          ],
        )
      ],
    ),
    );
  }

  _salvar(){

    print( _clienteSelecionado );
    print( _agendaDataController.text );
    print( _horarioSelecionado );

    print( _servicoSelecionado );
    AgendaModel objeto = new AgendaModel(
        1,
        int.parse(_clienteSelecionado),
        _agendaDataController.text ,
        _horarioSelecionado,
        _servicoSelecionado
    );
    objeto.save(objeto);
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
  void _servicoRadioOnChanged(int selecionado) {
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

  List<DropdownMenuItem<String>> getDropDownMenuItemsHorarios() {
    List<DropdownMenuItem<String>> items = new List();
    for (String horario in _horarios) {
      items.add(new DropdownMenuItem(
          value: horario,
          child: new Text(horario)
      ));
    }
    return items;
  }


}