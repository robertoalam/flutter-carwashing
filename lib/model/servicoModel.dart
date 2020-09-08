import 'package:flutter_carwashing/helper/database.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class ServicoModel {

  static final table = 'servico';
  final dbHelper = DatabaseHelper.instance;

  int id;
  String nome;

  ServicoModel(int id, String nome) {
    this.id = id;
    this.nome = nome;
  }

  ServicoModel.fromJson(Map json)
      : id = json['id'],
        nome = json['nome'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
    };
  }
  Map toJson() {
    return {'id': id, 'nome': nome};
  }

  Future<void> servicoInsert(ServicoModel objeto) async {
    // Get a reference to the database.
    await dbHelper.insert('servico', objeto.toMap()  );
  }

  buscar() async {
    final linhas = await dbHelper.queryAllRows('servico');
    List<ServicoModel> lista = List<ServicoModel>();
    for(int i=0;i< linhas.length ; i++){
      ServicoModel servico = ServicoModel(linhas[i]['id'],linhas[i]['nome']);
      lista.add(servico);
    }
    return lista;
  }

}