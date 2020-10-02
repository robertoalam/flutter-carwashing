import 'package:flutter_carwashing/helper/database.dart';

class ClienteModel {
  int id;
  String nome;
  String telefone;

  final dbHelper = DatabaseHelper.instance;
  final String tabela = "cliente";

  ClienteModel({this.id = 0, this.nome , this.telefone});

  factory ClienteModel.fromJson(Map<String, dynamic> json) {
    return ClienteModel(id: json['id'] , nome: json['nome'], telefone: ['telefone'].toString() );
  }

  ClienteModel.fromMap(Map map){
    id = map['_id'];
    nome = map['nome'];
    telefone = map['telefone'];
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'nome': nome,
      'telefone': telefone,
    };
  }
  Map toJson() {
    return {'id': id, 'nome': nome, 'telefone': telefone};
  }

  Future<void> insert() async {
    this.id = null ;
    await dbHelper.insert( tabela , this.toMap()  );
  }

  Future udpate() async {
    var map = this.toMap();
    return await dbHelper.update( tabela , map);
  }

  Future delete(int id) async {
    return await dbHelper.delete( tabela ,id);
  }

  query() async {
    final allRows = await dbHelper.queryAllRows( tabela );
    print('query all rows:');
    allRows.forEach((row) => print(row));
  }

  buscar() async {
    final linhas = await dbHelper.queryAllRows( tabela );
    List<ClienteModel> lista = List<ClienteModel>();
    for(int i=0;i< linhas.length ; i++){
      ClienteModel cliente = ClienteModel(id: linhas[i]['_id'], nome: linhas[i]['nome'], telefone: linhas[i]['telefone']);
      lista.add(cliente);
    }
    return lista;
  }

  salvar(){
    // INSERT
    if(this.id.toString().isEmpty || this.id == 0){
      this.insert();
    // UPDATE
    }else{
      this.udpate();
    }
    return true;
  }
}