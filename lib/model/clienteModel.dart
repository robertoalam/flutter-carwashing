import 'package:flutter_carwashing/helper/database.dart';

class ClienteModel {
  int id;
  String nome;
  String telefone;

  final dbHelper = DatabaseHelper.instance;

  ClienteModel({this.id = 0, this.nome , this.telefone});

//  ClienteModel.fromJson(Map json)
//      : id = json['id'],
//        nome = json['nome'],
//        telefone = json['telefone'];
//  factory ClienteModel.fromJson(Map<String, dynamic> json) {
//    return ClienteModel(int json['id'], String json['nome'],String json['telefone'] );
//  }

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
    // Get a reference to the database.
//    objeto.id = 0;
    this.id = null ;
    await dbHelper.insert('cliente', this.toMap()  );
  }

  Future udpate() async {
    var map = this.toMap();
    return await dbHelper.update(map);
  }

  Future delete(int id) async {
    return await dbHelper.delete(id);
  }

  query() async {
    final allRows = await dbHelper.queryAllRows('cliente');
    print('query all rows:');
    allRows.forEach((row) => print(row));
  }

  buscar() async {
    final linhas = await dbHelper.queryAllRows('cliente');
    List<ClienteModel> lista = List<ClienteModel>();
//    allRows.forEach( (row) => print( row ) );
    for(int i=0;i< linhas.length ; i++){
      ClienteModel cliente = ClienteModel(id: linhas[i]['_id'], nome: linhas[i]['nome'], telefone: linhas[i]['telefone']);
      lista.add(cliente);
    }
    return lista;
  }

  salvar(){

    // INSERT
    if(this.id.toString().isEmpty || this.id == 0){
      print('ENTROU 1');
       this.insert();
    // UPDATE
    }else{
      print('ENTROU 2');
      this.udpate();
    }
  }
}