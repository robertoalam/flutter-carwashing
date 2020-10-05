import 'package:flutter_carwashing/helper/database.dart';

class HorarioModel {
  int id;
  String descricao;
  int flag;

  final dbHelper = DatabaseHelper.instance;
  final String tabela = "horario";

  HorarioModel({this.id = 0, this.descricao , this.flag});

  factory HorarioModel.fromJson(Map<String, dynamic> json) {
    return HorarioModel(id: json['_id'] , descricao: json['descricao'], flag : json['st_flag'] );
  }

  HorarioModel.fromMap(Map map){
    id = map['_id'];
    descricao = map['descricao'];
    flag = map['st_flag'];
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'descricao': descricao,
      'st_flag': flag,
    };
  }
  Map toJson() {
    return {'_id': id, 'descricao': descricao, 'st_flag': flag};
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
    List<HorarioModel> lista = List<HorarioModel>();
    for(int i=0;i< linhas.length ; i++){
      HorarioModel objeto = HorarioModel(id: linhas[i]['_id'], descricao: linhas[i]['descricao'], flag: linhas[i]['st_flag']);
      lista.add(objeto);
    }
    return lista;
  }

  buscarID( int id) async {
    var linhas = await dbHelper.Where( tabela , " _id = $id " );
    HorarioModel objeto;
    if(linhas.length > 0 || linhas != null){
      objeto = new HorarioModel(id: linhas[0]['_id'], descricao: linhas[0]['descricao'] , flag: linhas[0]['st_flag']);
    }
    return objeto;
  }

  buscarWhere(String where) async {
    final linhas = await dbHelper.Where("agenda" , " $where AND st_flag = 1 ");
    List<HorarioModel> lista = List<HorarioModel>();
    for(int i=0;i< linhas.length ; i++){
      HorarioModel objeto = HorarioModel(id: linhas[i]['_id'], descricao: linhas[i]['descricao'], flag: linhas[i]['st_flag']);
      lista.add(objeto);
    }
    return lista;
  }



  salvar(){
    // INSERT
    if(this.id.toString().isEmpty || this.id == 0 || this.id == null){
      this.insert();
      // UPDATE
    }else{
      this.udpate();
    }
    return true;
  }
}