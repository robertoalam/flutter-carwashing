import 'package:flutter_carwashing/helper/database.dart';

class ServicoModel {

  int id;
  String nome;

  final dbHelper = DatabaseHelper.instance;
  final String tabela = "servico";

  ServicoModel({this.id, this.nome});

  factory ServicoModel.fromJson(Map<String, dynamic> json) {
    return ServicoModel(id: json['id'] , nome: json['nome'] );
  }

  ServicoModel.fromMap(Map map){
    id = map['_id'];
    nome = map['nome'];
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'nome': nome,
    };
  }
  Map toJson() {
    return {'id': id, 'nome': nome };
  }

  @override
  toString(){
    return "$id - $nome";
  }

  // CRUD - INICIO
  Future<void> insert() async {
    this.id = null ;
    return await dbHelper.insert( tabela , this.toMap()  );
  }

  Future udpate() async {
    var map = this.toMap();
    return await dbHelper.update( tabela ,map);
  }

  Future delete(int id) async {
    return await dbHelper.delete( tabela , id);
  }

  buscar() async {
    final linhas = await dbHelper.queryAllRows(tabela);
    List<ServicoModel> lista = List<ServicoModel>();
    for(int i=0;i< linhas.length ; i++){
      ServicoModel servico = ServicoModel(id : linhas[i]['_id'], nome: linhas[i]['nome']);
      lista.add(servico);
    }
    return lista;
  }

  // CRUD - FIM


  salvar(){
    // INSERT
    if(this.id.toString().isEmpty || this.id == 0 || this.id == null){
      this.insert();
    }else{
      this.udpate();
    }
    return true;
  }
}