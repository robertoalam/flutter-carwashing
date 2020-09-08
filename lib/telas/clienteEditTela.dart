import 'package:flutter/material.dart';
import 'package:flutter_carwashing/model/clienteModel.dart';

class clienteEditTela extends StatefulWidget {
  @override
  _clienteEditTelaState createState() => _clienteEditTelaState();
}

class _clienteEditTelaState extends State<clienteEditTela> {
  final TextEditingController _clienteNome = TextEditingController();
  final TextEditingController _clienteTelefone = TextEditingController();
  // snackbar
  final key = GlobalKey<ScaffoldState>();

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
                onPressed: () => _salvar(),
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
        ClienteModel objeto = new ClienteModel(1,_clienteNome.text,_clienteTelefone.text);
        objeto.insert(objeto);
        setState(() {
          _clienteNome.text = "";
          _clienteTelefone.text = "";
        });
    }
  }

}
