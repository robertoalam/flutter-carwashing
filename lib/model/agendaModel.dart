import 'package:flutter_carwashing/helper/database.dart';
import 'servicoModel.dart';
import 'horarioModel.dart';
import 'clienteModel.dart';
import 'agendaTruncadoModel.dart';

class AgendaModel {
  int id;
  ClienteModel cliente;
  String data;
  HorarioModel hora;
  ServicoModel servico;

  final dbHelper = DatabaseHelper.instance;
  final String tabela = "agenda";

  AgendaModel({ this.id , this.cliente , this.data , this.hora , this.servico  }) ;

  factory AgendaModel.fromJson(Map<String, dynamic> json) {
    return AgendaModel( id:  json['_id'], cliente: json['id_cliente'], data: json['data'] , hora: json['hora'] , servico: json['id_servico'] );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'id_cliente': cliente,
      'data':data,
      'hora':hora,
      'id_servico':servico,
    };
  }

  Map<String, dynamic> toDatabase() {
    return {
      '_id': id,
      'id_cliente': cliente.id,
      'id_servico':servico.id,
      'dt_servico':data,
      'id_horario':hora.id,
    };
  }

  Map toJson() {
    return {'id': id, 'id_cliente': cliente, 'data': data,'hora':hora,'id_servico':servico};
  }

  @override
  String toString() {
    print("$id ${cliente.nome} $data $hora ${servico.descricao}");
  }

  // CRUD
  Future<void> insert() async {
    await dbHelper.insert( tabela , this.toDatabase()  );
  }

  Future udpate() async {
    return await dbHelper.update( tabela , "_id" , this.toDatabase() );
  }

  query() async {
    final allRows = await dbHelper.queryAllRows( tabela );
    allRows.forEach((row) => print(row));
  }

  buscar() async {
    final linhas = await dbHelper.queryAllRows('agenda');
    List<AgendaModel> lista = List<AgendaModel>();
    for(int i=0;i< linhas.length ; i++){
      
      ClienteModel cliente = new ClienteModel();
      cliente = await cliente.buscarID(linhas[i]['id_cliente']);
      
      HorarioModel horario = new HorarioModel();
      horario = await horario.buscarID( linhas[i]['id_horario'] );

      ServicoModel servico = new ServicoModel();
      servico = await servico.buscarID( linhas[i]['id_servico'] );
      
      AgendaModel agenda = new AgendaModel(id: linhas[i]['_id'], cliente: cliente , data : linhas[i]['dt_servico'], hora: horario , servico: servico);
      lista.add(agenda);
    }
    return lista;
  }


  buscarTruncado() async {
    String sql = " SELECT a.id,a.dt_servico,a.hr_servico,c.nome AS cliente,s.nome AS servico FROM agenda a LEFT JOIN cliente c ON a.cliente=c._id LEFT JOIN servico s ON a.cd_servico=s._id ";
    final linhas = await dbHelper.queryCustom(sql);
//    List<String> lista = new List<String>();
    List<AgendaTruncadoModel> lista = new List<AgendaTruncadoModel>();
    for(int i=0;i < linhas.length ; i++){
      AgendaTruncadoModel agendaTruncadoModel = new AgendaTruncadoModel(linhas[i]['id'], linhas[i]['cliente'], linhas[i]['dt_servico'], linhas[i]['hr_servico'], linhas[i]['servico']) ;
      lista.add( agendaTruncadoModel );
    }
    return lista;
  }

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