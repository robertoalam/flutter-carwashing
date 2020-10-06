import 'package:flutter/material.dart';
import 'package:flutter_carwashing/helper/database.dart';
import 'package:flutter_carwashing/model/servicoModel.dart';
import 'package:flutter_carwashing/telas/servico/servicoEditTela.dart';


class servicoListTela extends StatefulWidget {
  @override
  _servicoListTelaState createState() => _servicoListTelaState();
}

class _servicoListTelaState extends State<servicoListTela> {

  List<ServicoModel> _listagem = new List<ServicoModel>();
  ServicoModel _servico = new ServicoModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getBuscarLista();
  }

  void _getBuscarLista() async {
    _listagem = await _servico.buscar() ;
    setState(() {
      _listagem;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: ()=> _editarObjeto(),
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("Lista de Serviços"),
      ),
      body: ListView.builder(
        itemCount: _listagem.length,
        itemBuilder: (BuildContext context, int index) {
          return _cardObjeto(context, index);
        },
      )
    );
  }

  _cardObjeto(BuildContext context , int index){
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Column(
              children: [
                Container(
                  child: GestureDetector(
                    onTap: () => { _deletar( index ), },
                    child: Icon(Icons.delete,size: 36,),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  child: GestureDetector(
                    onTap: () => _editarObjeto(servico:  _listagem[index]),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(_listagem[index].id.toString()),
                              Text(" - "),
                              Text(_listagem[index].descricao ,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),),
                            ],
                          ),
                        ],
                      ),
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

  _editarObjeto({ServicoModel servico}) async {
    final retorno = await Navigator.push(context, MaterialPageRoute(builder: (context) => servicoEditTela(servico: servico ) ) );
    if(retorno != null){
      _getBuscarLista();
    }
  }

  _deletar( index ) {
    _listagem[index].delete(  _listagem[index].id );
    _listagem.removeAt(index);
    setState(() {
      _listagem;
    });
  }
}
