import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {

  static final _databaseName = "CarWashing.db";
  static final _databaseVersion = 1;

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute(''' CREATE TABLE IF NOT EXISTS cliente ( _id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT NOT NULL, telefone TEXT NOT NULL ); ''');
    await db.execute(''' CREATE TABLE IF NOT EXISTS servico ( _id INTEGER PRIMARY KEY AUTOINCREMENT, descricao TEXT NOT NULL); ''');
    await db.execute(''' CREATE TABLE IF NOT EXISTS agenda ( _id INTEGER PRIMARY KEY AUTOINCREMENT, id_cliente INT NOT NULL, id_servico INT NOT NULL , dt_servico VARCHAR(10) NOT NULL , id_horario INT NOT NULL , dt_create TEXT DEFAULT CURRENT_TIMESTAMP); ''');
    await db.execute(''' CREATE TABLE IF NOT EXISTS horario ( _id INTEGER PRIMARY KEY AUTOINCREMENT, descricao TEXT NOT NULL, st_flag INTEGER ); ''');
    popularTabelaCliente(db);
    popularTabelaServico(db);
    popularTabelaHorario(db);
    //popularTabelaAgenda(db);
  }

  popularTabelaCliente(db){
    db.execute(''' INSERT INTO cliente (nome,telefone) VALUES ('Joao','12345');  ''');
    db.execute(''' INSERT INTO cliente (nome,telefone) VALUES ('Maria Laura','57663'); ''');
    db.execute(''' INSERT INTO cliente (nome,telefone) VALUES ('Antonio','1029384'); ''');
    db.execute(''' INSERT INTO cliente (nome,telefone) VALUES ('José','1029384'); ''');
    db.execute(''' INSERT INTO cliente (nome,telefone) VALUES ('Valdir','435345'); ''');
    return 1;
  }

  popularTabelaServico(db){
    db.execute(''' INSERT INTO servico (descricao) VALUES ('Lavagem Simples'); ''');
    db.execute(''' INSERT INTO servico (descricao) VALUES ('Lavagem Completa c/cera'); ''');
    db.execute(''' INSERT INTO servico (descricao) VALUES ('Lavagem Completa s/cera'); ''');
    return 1;
  }

  popularTabelaHorario(db){
    db.execute(''' INSERT INTO horario (descricao,st_flag) VALUES ('01:00',0); ''');
    db.execute(''' INSERT INTO horario (descricao,st_flag) VALUES ('02:00',0); ''');
    db.execute(''' INSERT INTO horario (descricao,st_flag) VALUES ('03:00',0); ''');
    db.execute(''' INSERT INTO horario (descricao,st_flag) VALUES ('04:00',0); ''');
    db.execute(''' INSERT INTO horario (descricao,st_flag) VALUES ('05:00',0); ''');
    db.execute(''' INSERT INTO horario (descricao,st_flag) VALUES ('06:00',0); ''');
    db.execute(''' INSERT INTO horario (descricao,st_flag) VALUES ('07:00',0); ''');
    db.execute(''' INSERT INTO horario (descricao,st_flag) VALUES ('08:00',1); ''');
    db.execute(''' INSERT INTO horario (descricao,st_flag) VALUES ('09:00',1); ''');
    db.execute(''' INSERT INTO horario (descricao,st_flag) VALUES ('10:00',1); ''');
    db.execute(''' INSERT INTO horario (descricao,st_flag) VALUES ('11:00',1); ''');
    db.execute(''' INSERT INTO horario (descricao,st_flag) VALUES ('12:00',1); ''');
    db.execute(''' INSERT INTO horario (descricao,st_flag) VALUES ('13:00',1); ''');
    db.execute(''' INSERT INTO horario (descricao,st_flag) VALUES ('14:00',1); ''');
    db.execute(''' INSERT INTO horario (descricao,st_flag) VALUES ('15:00',1); ''');
    db.execute(''' INSERT INTO horario (descricao,st_flag) VALUES ('16:00',1); ''');
    db.execute(''' INSERT INTO horario (descricao,st_flag) VALUES ('17:00',1); ''');
    db.execute(''' INSERT INTO horario (descricao,st_flag) VALUES ('18:00',1); ''');
    db.execute(''' INSERT INTO horario (descricao,st_flag) VALUES ('19:00',0); ''');
    db.execute(''' INSERT INTO horario (descricao,st_flag) VALUES ('20:00',0); ''');
    db.execute(''' INSERT INTO horario (descricao,st_flag) VALUES ('21:00',0); ''');
    db.execute(''' INSERT INTO horario (descricao,st_flag) VALUES ('22:00',0); ''');
    db.execute(''' INSERT INTO horario (descricao,st_flag) VALUES ('23:00',0); ''');
    db.execute(''' INSERT INTO horario (descricao,st_flag) VALUES ('00:00',0); ''');
    return 1;
  }

  popularTabelaAgenda(db){
    db.execute(''' INSERT INTO agenda (id_cliente , id_servico , dt_servico , id_horario ) VALUES ( 1,1,'05/10/2020',13 );  ''');
    db.execute(''' INSERT INTO agenda (id_cliente , id_servico , dt_servico , id_horario ) VALUES ( 2,1,'05/10/2020',14 );  ''');
    db.execute(''' INSERT INTO agenda (id_cliente , id_servico , dt_servico , id_horario ) VALUES ( 3,1,'06/10/2020',13 );  ''');
    return 1;
  }

  // Helper methods
  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(tabela,Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(tabela, row);
  }

  executar(String comando) async {
    Database db = await instance.database;
    return await db.execute(comando);
  }

  Where(tabela , where) async {
    Database db = await instance.database;
    return await db.query(tabela , where: where);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows(tabela) async {
    Database db = await instance.database;
    return await db.query(tabela);
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount(tabela) async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $tabela'));
  }

  Future<List<Map<String, dynamic>>> queryCustom(sql) async {
    Database db = await instance.database;
    List<Map> list = await db.rawQuery(sql);
    return list;
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(tabela , primaryKey , Map<String, dynamic> row) async {
    Database db = await instance.database;
    String primaryValue = row['_id'].toString() ;
    return await db.update(tabela, row, where:" $primaryKey = $primaryValue ");
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(tabela,int id) async {
    Database db = await instance.database;
    // return await db.delete(tabela, where: '$columnId = ?', whereArgs: [id]);
    return await db.delete(tabela, where: '_id = ?', whereArgs: ['_id']);
  }
}