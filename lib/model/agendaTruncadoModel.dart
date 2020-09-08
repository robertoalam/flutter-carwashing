import 'package:flutter_carwashing/helper/database.dart';

class AgendaTruncadoModel {
  int id;
  String cliente;
  String data;
  String hora;
  String servico;

  final dbHelper = DatabaseHelper.instance;

  AgendaTruncadoModel(int id, String cliente, String data, String hora, String servico) {
    this.id = id;
    this.cliente = cliente;
    this.data = data;
    this.hora = hora;
    this.servico = servico;
  }
  factory AgendaTruncadoModel.fromJson(Map<String, dynamic> json) {
    return AgendaTruncadoModel( json['id'],json['cliente'],json['dt_servico'] ,json['hr_servico'] ,json['servico']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cliente': cliente,
      'dt_servico':data,
      'hr_servico':hora,
      'servico':servico,
    };
  }
  Map toJson() {
    return {'id': id, 'cliente': cliente, 'data': 'dt_servico','hr_servico':'hora','servico':servico};
  }
}