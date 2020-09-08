import 'package:flutter_carwashing/helper/database.dart';

class ClienteModel {
  int id;
  String nome;
  String telefone;

  final dbHelper = DatabaseHelper.instance;

  ClienteModel(int id, String nome , String telefone) {
    this.id = id;
    this.nome = nome;
    this.telefone = telefone;
  }

//  ClienteModel.fromJson(Map json)
//      : id = json['id'],
//        nome = json['nome'],
//        telefone = json['telefone'];
  factory ClienteModel.fromJson(Map<String, dynamic> json) {
    return ClienteModel( json['id'],json['nome'],json['telefone'] );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'telefone':telefone,
    };
  }
  Map toJson() {
    return {'id': id, 'nome': nome, 'telefone': telefone};
  }

  Future<void> insert(ClienteModel objeto) async {
    // Get a reference to the database.
    objeto.id = 0;
    await dbHelper.insert('cliente', objeto.toMap()  );
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
      ClienteModel cliente = ClienteModel(linhas[i]['id'],linhas[i]['nome'],linhas[i]['telefone']);
      lista.add(cliente);
    }
    return lista;
  }
}