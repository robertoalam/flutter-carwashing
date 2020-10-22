import 'package:flutter/material.dart';
import 'package:flutter_carwashing/helper/database.dart';
import 'package:flutter_carwashing/model/clienteModel.dart';
import '../cliente/clienteEditTela.dart';

class clienteListTela extends StatefulWidget {

    @override
    _clienteListTelaState createState() => _clienteListTelaState();
}

class _clienteListTelaState extends State<clienteListTela> {

    final dbHelper = DatabaseHelper.instance;

    List<ClienteModel> _listagem = new List<ClienteModel>();
    ClienteModel cliente = new ClienteModel();
    final TextEditingController _controllerPesquisa = new TextEditingController();
    bool _IsSearching;
    String _searchText = "";

    @override
    void initState() {
        // TODO: implement initState
        super.initState();
        _getBuscarLista();
    }

    void _getBuscarLista() async {
        _listagem = await cliente.buscar() ;
        final _listaCompleta = _listagem;
        setState(() {
            _listagem;
        });
    }

    Icon cusIcon = Icon(Icons.search);
    Widget cusSearchBar = Text("Appbar");

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: ()=> _editarObjeto(),
            ),
            appBar: AppBar(
                leading: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back),
                ),
                actions: [

                    IconButton(
                        onPressed: () => teste() ,
                        icon:cusIcon,
                    ),
                ],
                title: cusSearchBar
            ),
            body:  ListView.builder(
                itemCount: _listagem.length,
                itemBuilder: (BuildContext context, int index) {
                    return _cardObjeto(context, index);
                },
            )
        );
    }

    teste(){
        setState(() {
            if( this.cusIcon.icon == Icons.search){
                this.cusIcon = Icon(Icons.cancel);
                this.cusSearchBar = TextField(
                    onChanged: (valor) {
                        _teste2(valor);
                    },
                    decoration: InputDecoration(
                        hintText: "Nome",
                        border: InputBorder.none
                    ),
                    controller: _controllerPesquisa,
                    style: TextStyle(
                        color:Colors.white , fontSize:  16.0 ,
                    ),
                );

                _IsSearching = false;
                _searchText = "";
            }else{
                this.cusIcon = Icon(Icons.search);
                this.cusSearchBar = Text("Appbar");

                _IsSearching = true;
                _searchText = _controllerPesquisa.text;
            }
            print( _searchText );
        });
        //return _controllerPesquisa.text;

    }

    _teste2(valor) async {
        if(valor.toString().length > 1) {
            _listagem = _listagem.where((item) => item.nome.toLowerCase().contains(valor)).toList();
        }else{
            _listagem = await cliente.buscar() ;
        }
        setState(() {
            _listagem;
        });
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
                                        onTap: () => _editarObjeto(cliente:  _listagem[index]),
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Column(
                                                children: [
                                                    Row(
                                                        children: [
                                                            Text(_listagem[index].id.toString()),
                                                            Text(" - "),
                                                            Text(_listagem[index].nome ,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),),
                                                        ],
                                                    ),
                                                    Text(_listagem[index].telefone.toString()),
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

    _editarObjeto({ClienteModel cliente}) async {
        final retorno = await Navigator.push(context, MaterialPageRoute(builder: (context) => clienteEditTela(cliente: cliente ) ) );
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

