import 'package:flutter/material.dart';
import 'package:flutter_carwashing/model/servicoModel.dart';

class servicoEditTela extends StatefulWidget {

  final ServicoModel servico;
  servicoEditTela({this.servico});

  @override
  _servicoEditTelaState createState() => _servicoEditTelaState();
}

class _servicoEditTelaState extends State<servicoEditTela> {

  final _controllerId = TextEditingController();
  final _controllerNome = TextEditingController();

  // snackbar
  final key = GlobalKey<ScaffoldState>();
  ServicoModel _servico  = ServicoModel();

  @override
  void initState() {
    // SE VIAR UM OBJETO PARA ESSA TELA, CARREGAR DADOS NOS CONTROLLERS
    if(widget.servico != null){
      _carregarDadosTela(widget.servico);
    }
    super.initState();
  }

  _carregarDadosTela( objeto ){
    _controllerId.text =  objeto.id.toString();
    _controllerNome.text = objeto.nome;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_controllerNome.text.isNotEmpty  ? _controllerNome.text.toString() : "Novo SERVIÇO"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: _controllerNome,
              decoration: InputDecoration(
                  hintText: "Nome do serviço" ,
                  border:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                  )
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: ButtonTheme(
              buttonColor: Colors.blue,
              child: RaisedButton(
                onPressed: () => {
                  _salvar(),
                  Navigator.pop(context, _servico),
                },
                child: Text("SALVAR"),
              ),
            ),
          ),
        ],
      ),
    );
  }
  _salvar(){
    if( _controllerNome.text.isEmpty ){
      key.currentState.showSnackBar(SnackBar(
          content: Text("Nome é obrigatorio!"))
      );
    }else{
      _controllerId.text = (_controllerId.text.toString().isNotEmpty ) ?_controllerId.text.toString() : "0" ;
      if( _controllerId.text.toString() == "0" ){
        _servico = new ServicoModel( nome: _controllerNome.text.toString() );
      }else{
        _servico = new ServicoModel(id: int.parse( _controllerId.text.toString() ) , nome: _controllerNome.text.toString() );
      }
      _servico.salvar();
    }
  }
}
