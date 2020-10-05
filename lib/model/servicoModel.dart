import 'package:flutter_carwashing/helper/database.dart';

class ServicoModel {

  int id;
  String descricao;

  final dbHelper = DatabaseHelper.instance;
  final String tabela = "servico";

  ServicoModel({this.id, this.descricao});

  factory ServicoModel.fromJson(Map<String, dynamic> json) {
    return ServicoModel(id: json['id'] , descricao: json['descricao'] );
  }

  ServicoModel.fromMap(Map map){
    id = map['_id'];
    descricao = map['descricao'];
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'nome': descricao,
    };
  }
  Map toJson() {
    return {'id': id, 'descricao': descricao };
  }

  @override
  toString(){
    return "$id - $descricao";
  }

  // CRUD - INICIO
  Future<void> insert() async {
    this.id = null ;
    return await dbHelper.insert( tabela , this.toMap()  );
  }

  Future udpate() async {
    var map = this.toMap();
    return await dbHelper.update( tabela , " _id " ,map);
  }

  Future delete(int id) async {
    return await dbHelper.delete( tabela , id);
  }

  buscar() async {
    final linhas = await dbHelper.queryAllRows(tabela);
    List<ServicoModel> lista = List<ServicoModel>();
    for(int i=0;i< linhas.length ; i++){
      ServicoModel objeto = ServicoModel(id : linhas[i]['_id'], descricao: linhas[i]['descricao']);
      lista.add(objeto);
    }
    return lista;
  }

  buscarID( int id) async {
    var linhas = await dbHelper.Where( tabela , " _id = $id " );
    ServicoModel objeto;
    if(linhas.length > 0 || linhas != null){
      objeto = new ServicoModel(id: linhas[0]['_id'], descricao: linhas[0]['descricao']);
    }
    return objeto;
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