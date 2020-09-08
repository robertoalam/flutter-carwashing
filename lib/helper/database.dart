import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {

  static final _databaseName = "CarWashing.db";
  static final _databaseVersion = 1;

  static final table = 'cliente';

  static final columnId = '_id';
  static final columnName = 'name';
  static final columnAge = 'age';

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
    await db.execute(''' CREATE TABLE IF NOT EXISTS cliente ( id INTEGER PRIMARY KEY, nome TEXT NOT NULL, telefone TEXT NOT NULL ); ''');
    await db.execute(''' CREATE TABLE IF NOT EXISTS servico ( id INTEGER PRIMARY KEY, nome TEXT NOT NULL); ''');
    await db.execute(''' CREATE TABLE IF NOT EXISTS agenda (id INTEGER PRIMARY KEY, cliente INT NOT NULL, dt_servico VARCHAR(10) NOT NULL , hr_servico VARCHAR(5) NOT NULL , cd_servico INT NOT NULL , dt_create TEXT DEFAULT CURRENT_TIMESTAMP); ''');
    popularTabelaCliente(db);
    popularTabelaServico(db);
  }

  popularTabelaCliente(db){
    db.execute(''' INSERT INTO cliente (nome,telefone) VALUES ('beto','12345');  ''');
    db.execute(''' INSERT INTO cliente (nome,telefone) VALUES ('Tonia Laura','57663'); ''');
    db.execute(''' INSERT INTO cliente (nome,telefone) VALUES ('Luisa','1029384'); ''');
    db.execute(''' INSERT INTO cliente (nome,telefone) VALUES ('José','1029384'); ''');
    db.execute(''' INSERT INTO cliente (nome,telefone) VALUES ('Valdir','1029384'); ''');
    return 1;
  }

  popularTabelaServico(db){
    db.execute(''' INSERT INTO servico (nome) VALUES ('Lavagem Simples'); ''');
    db.execute(''' INSERT INTO servico (nome) VALUES ('Lavagem Completa c/cera'); ''');
    db.execute(''' INSERT INTO servico (nome) VALUES ('Lavagem Completa s/cera'); ''');
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

  Future<int> executar(String comando) async {
    Database db = await instance.database;
    await db.execute(comando);
    return 1;
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
  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}