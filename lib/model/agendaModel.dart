import 'package:flutter_carwashing/helper/database.dart';

import 'agendaTruncadoModel.dart';
import 'agendaTruncadoModel.dart';
import 'agendaTruncadoModel.dart';

class AgendaModel {
  int id;
  int cliente;
  String data;
  String hora;
  int servico;

  final dbHelper = DatabaseHelper.instance;

  AgendaModel(int id, int cliente , String data ,String hora, int servico) {
    this.id = id;
    this.cliente = cliente;
    this.data = data;
    this.hora = hora;
    this.servico = servico;
  }

  factory AgendaModel.fromJson(Map<String, dynamic> json) {
    return AgendaModel( json['id'],json['cliente'],json['data'] ,json['hora'] ,json['servico']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cliente': cliente,
      'data':data,
      'hora':hora,
      'servico':servico,
    };
  }
  Map toJson() {
    return {'id': id, 'cliente': cliente, 'data': 'data','hora':'hora','servico':servico};
  }

  Future<void> insert(AgendaModel objeto) async {
    await dbHelper.insert('agenda', objeto.toMap()  );
  }

  Future<void> save(AgendaModel objeto) async {
    String sql = " INSERT INTO agenda (cliente, dt_servico, hr_servico , cd_servico) VALUES ('"+objeto.cliente.toString()+"','"+objeto.data+"','"+objeto.hora+"','"+objeto.servico.toString()+"') ";
    await dbHelper.executar(sql);
  }

  query() async {
    final allRows = await dbHelper.queryAllRows('agenda');
    print('query all rows:');
    allRows.forEach((row) => print(row));
  }

  buscar() async {
    final linhas = await dbHelper.queryAllRows('agenda');
    List<AgendaModel> lista = List<AgendaModel>();
//    allRows.forEach( (row) => print( row ) );
    for(int i=0;i< linhas.length ; i++){
      print(linhas[i]['data']);
      AgendaModel agenda = AgendaModel(linhas[i]['id'],linhas[i]['cliente'],linhas[i]['data'],linhas[i]['hora'],linhas[i]['servico']);
      lista.add(agenda);
    }
    return lista;
  }

  buscarTruncado() async {
    String sql = " SELECT a.id,a.dt_servico,a.hr_servico,c.nome AS cliente,s.nome AS servico FROM agenda a LEFT JOIN cliente c ON a.cliente=c._id LEFT JOIN servico s ON a.cd_servico=s.id ";
    final linhas = await dbHelper.queryCustom(sql);
//    List<String> lista = new List<String>();
    List<AgendaTruncadoModel> lista = new List<AgendaTruncadoModel>();
    for(int i=0;i < linhas.length ; i++){
      AgendaTruncadoModel agendaTruncadoModel = new AgendaTruncadoModel(linhas[i]['id'], linhas[i]['cliente'], linhas[i]['dt_servico'], linhas[i]['hr_servico'], linhas[i]['servico']) ;
      lista.add( agendaTruncadoModel );
    }
    return lista;
  }
}