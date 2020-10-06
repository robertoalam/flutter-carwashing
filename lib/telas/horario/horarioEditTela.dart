import 'package:flutter/material.dart';
import 'package:flutter_carwashing/helper/LinhaFormatter.dart';
import 'package:flutter_carwashing/model/horarioModel.dart';
import 'package:brasil_fields/brasil_fields.dart';

class horarioEditTela extends StatefulWidget {
    final HorarioModel horario;
    horarioEditTela({this.horario});

  @override
  _horarioEditTelaState createState() => _horarioEditTelaState();
}

class _horarioEditTelaState extends State<horarioEditTela> {

    final _horarioId = TextEditingController();
    final _horarioDescricao = TextEditingController();
    final _horarioFlag = TextEditingController();

    var _flags = [{'id':0 , 'descricao':'Esconder'},{'id':1 ,'descricao':'Exibir'}];
    List<DropdownMenuItem<String>> _dropDownMenuItems;
    String _flagSelecionada;

    // snackbar
    final key = GlobalKey<ScaffoldState>();
    HorarioModel _horario = new HorarioModel();

    @override
    void initState() {
        _dropDownMenuItems = getDropDownMenuItems();
        // SE VIAR UM OBJETO PARA ESSA TELA, CARREGAR DADOS NOS CONTROLLERS
        if(widget.horario != null){
            _carregarDadosTela(widget.horario);
        }
        super.initState();
    }

    _carregarDadosTela( objeto ){
        _horarioId.text =  objeto.id.toString();
        _horarioDescricao.text = objeto.descricao;
        _horarioFlag.text = objeto.flag.toString();
        if( objeto.flag.toString() == "1" ) {
            _flagSelecionada = _dropDownMenuItems[1].value;
        }else{
            _flagSelecionada = _dropDownMenuItems[0].value;
        }
    }

    List<DropdownMenuItem<String>> getDropDownMenuItems() {
        List<DropdownMenuItem<String>> items = new List();
        for (Map<String,dynamic> flag in _flags) {
            items.add(
                new DropdownMenuItem(
                    value: flag['id'].toString(),
                    child: new Text(flag['descricao'])
                )
            );
        }
        return items;
    }
    void changedDropDownItem(String selectedCity) {
        setState(() {
            _flagSelecionada = selectedCity;
        });
    }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Horario"),
      ),
        body:
        ListView(
            children: [
              Row(
                children: [
                    Container(
                        padding: EdgeInsets.all(10),
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width - 20,
                            child:
                            LinhaFormatter(
                                text: 'Hora',
                                formatter: HoraInputFormatter(),
                                controller: _horarioDescricao,
                            ),
                        ),
                    ),
                ],
              ),
              Row(
                children: [
                    Column(
                        children: [
                             Container(
                                alignment: Alignment.centerRight,
                                width: MediaQuery.of(context).size.width / 4.5 ,
                                child: Text("Flag" , style: const TextStyle(fontSize: 20), ),
                            ),

                        ],
                    ),
                    Column(
                        children: [
                            new Container(
                                width: MediaQuery.of(context).size.width / 2,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.blueAccent)
                                ),
                                child: new Center(
                                    child:
                                    new DropdownButton(
                                        value: _flagSelecionada,
                                        items: _dropDownMenuItems,
                                        onChanged: changedDropDownItem,
                                    )
                                )
                            ),
                        ],
                    )
                ],
              ),
            ],
        ),

            // Column(
            //   children: [
            //       Row(
            //           children: [
            //               TextFormField(
            //                   controller: _horarioDescricao,
            //                   decoration: InputDecoration(
            //                       hintText: 'Descrição'
            //                   ),
            //               )
            //           ],
            //       ),
            //       Row(
            //         children: [
            //             LinhaFormatter(
            //                 text: 'Horário',
            //                 formatter: HoraInputFormatter(),
            //                 controller: _horarioDescricao,
            //             ),
            //         ],
            //       ),
            //   ],
            // ),
    );
  }
}
