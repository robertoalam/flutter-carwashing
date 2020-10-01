import 'package:flutter/material.dart';
import 'package:flutter_carwashing/helper/database.dart';
import 'package:flutter_carwashing/model/clienteModel.dart';
import 'package:flutter_carwashing/telas/clienteEditTela.dart';

class clienteListTela extends StatefulWidget {

  @override
  _clienteListTelaState createState() => _clienteListTelaState();
}

class _clienteListTelaState extends State<clienteListTela> {

  final dbHelper = DatabaseHelper.instance;
  List<ClienteModel> _clientes = new List<ClienteModel>();
  ClienteModel cliente = new ClienteModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getClientes();
    print('ENTROU INIT STATE');
  }

  void _getClientes() async {
    _clientes = await cliente.buscar() ;
    setState(() {
      _clientes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: ()=> Navigator.push(context, MaterialPageRoute( builder: (context) => clienteEditTela() ) ),
      ),
      appBar: AppBar(
        title: Text("Lista de Clientes"),
      ),
        body: ListView.builder(
        itemCount: _clientes.length,
        itemBuilder: (BuildContext context, int index) {
          return _cardCliente(context, index);
        },
      )
    );
  }

  _cardCliente(BuildContext context , int index){
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
                    onTap: () => _editCliente(cliente:  _clientes[index]),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(_clientes[index].id.toString()),
                              Text(" - "),
                              Text(_clientes[index].nome ,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),),
                            ],
                          ),
                          Text(_clientes[index].telefone.toString()),
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

  _editCliente({ClienteModel cliente}) async {
    final retorno = await Navigator.push(context, MaterialPageRoute(builder: (context) => clienteEditTela(cliente: cliente ) ) );
    print(retorno);
    if(retorno != null){
      _getClientes();
    }
  }

  _deletar( index ) {
    _clientes[index].delete(  _clientes[index].id );
    _clientes.removeAt(index);
    setState(() {
      _clientes;
    });
  }
}
