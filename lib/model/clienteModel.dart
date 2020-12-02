import 'dart:convert';

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
    return await dbHelper.update( tabela , " _id " , map);
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
      ClienteModel objeto = ClienteModel(id: linhas[i]['_id'], nome: linhas[i]['nome'], telefone: linhas[i]['telefone']);
      lista.add(objeto);
    }
    return lista;
  }

  fetchById(int id) async {
    var linha = await dbHelper.query("cliente", where: "_id = ?", whereArgs: [id]);
    return linha.isNotEmpty ? ClienteModel.fromMap(linha.first) : Null ;
  }

  buscarID( int id) async {
    var linhas = await dbHelper.Where( tabela , " _id = $id " );
    ClienteModel objeto;
    if(linhas.length > 0 || linhas != null){
      objeto = new ClienteModel(id: linhas[0]['_id'], nome: linhas[0]['nome'], telefone: linhas[0]['telefone']);
    }
    return objeto;
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