import 'package:flutter/material.dart';
import 'package:flutter_carwashing/model/clienteModel.dart';
import 'package:flutter_carwashing/telas/clienteListTela.dart';

class clienteEditTela extends StatefulWidget {

  final ClienteModel cliente;
  clienteEditTela({this.cliente});

  @override
  _clienteEditTelaState createState() => _clienteEditTelaState();
}

class _clienteEditTelaState extends State<clienteEditTela> {
  final _clienteId = TextEditingController();
  final _clienteNome = TextEditingController();
  final _clienteTelefone = TextEditingController();
  // snackbar
  final key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // SE VIAR UM OBJETO PARA ESSA TELA, CARREGAR DADOS NOS CONTROLLERS
    if(widget.cliente != null){
      _carregarDadosTela(widget.cliente);
    }
    super.initState();
  }

  _carregarDadosTela( objeto ){
    _clienteId.text =  objeto.id.toString();
    _clienteNome.text = objeto.nome;
    _clienteTelefone.text = objeto.telefone.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text("Cadastro de Cliente"),
      ),body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: _clienteNome,
              decoration: InputDecoration(
                  hintText: "Nome do cliente" ,
                  border:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                  )
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: false),
              controller: _clienteTelefone,
              decoration: InputDecoration(
                  hintText: "Telefone do cliente" ,
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
                  Navigator.pop(context, MaterialPageRoute( builder: (context) => clienteListTela() ) ),
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
    if( _clienteNome.text.isEmpty || _clienteTelefone.text.isEmpty ){
      key.currentState.showSnackBar(SnackBar(
          content: Text("Nome e telefone são obrigatorios"))
      );
    }else{
        _clienteId.text = (_clienteId.text.toString().isNotEmpty ) ? _clienteId.text.toString() : "0" ;
        ClienteModel objeto;
        if( _clienteId.text.isNotEmpty ){
          objeto = new ClienteModel( nome: _clienteNome.text.toString() , telefone: _clienteTelefone.text.toString() );
        }else{
          objeto = new ClienteModel(id: int.parse( _clienteId.text.toString() ) , nome: _clienteNome.text.toString() , telefone: _clienteTelefone.text.toString() );
        }
        objeto.salvar();
    }
  }

}
