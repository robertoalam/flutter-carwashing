import 'package:flutter/material.dart';
import 'package:flutter_carwashing/helper/database.dart';
import 'package:flutter_carwashing/model/clienteModel.dart';

class clienteListTela extends StatefulWidget {
  @override
  _clienteListTelaState createState() => _clienteListTelaState();
}

class _clienteListTelaState extends State<clienteListTela> {
  final dbHelper = DatabaseHelper.instance;
  var clientes = new List<ClienteModel>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getClientes();
  }

  _getClientes() async {
    ClienteModel cliente = new ClienteModel(2,"teste","teste");
    clientes = await cliente.buscar() ;
    setState(() {
      clientes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Clientes"),
      ),
        body: ListView.builder(
        itemCount: clientes.length,
        itemBuilder: (BuildContext context, int index) {
          return _cardCliente(context, index);
        },
      )
    );
  }

  _cardCliente(BuildContext context,int index){
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(clientes[index].nome,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),),
          Text(clientes[index].telefone),
        ],
      ),
    );
  }
}
