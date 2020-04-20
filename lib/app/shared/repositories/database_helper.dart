import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final _databaseName = "projeto_slidy.db";
  static final _databaseVersion = 1;

  static final tablelista = 'lista';
  static final tablelistaitem = 'listaitem';
  static final tableproduto = 'produto';

  static final columnId = '_id';
  static final columnName = 'name';
  static final columnDate = 'date';
  static final columnPlace = 'place';

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
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    
    await db.execute('''
          CREATE TABLE $tablelista (
            $columnId INTEGER PRIMARY KEY,
            $columnName TEXT ,
            $columnDate TEXT ,
            $columnPlace TEXT
          )
          ''');
    print("Table [$tablelista] has created.");

    await db.execute('''
          CREATE TABLE $tablelistaitem (
            _id INTEGER PRIMARY KEY,
            idlista INTEGER ,
            idproduto INTEGER ,
            quantidade REAL
            valorunitario REAL ,
            valortotal REAL
            dtvencimento TEXT
          )
          ''');
    print("Table [$tablelistaitem] has created.");

    await db.execute('''
          CREATE TABLE $tableproduto (
            _id INTEGER PRIMARY KEY,
            nome TEXT ,
            marca TEXT ,
            unidademedida TEXT
          )
          ''');
    print("Table [$tableproduto] has created.");
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(tablelista, row);
  }

  Future<int> inserirprodutonabase(table, Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }
  
  

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows(table) async {
    Database db = await instance.database;
    return await db.query(table, orderBy: '_id desc');
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryById(id) async {
    Database db = await instance.database;
    return await db.query(tablelista,
        orderBy: '_id desc', where: '$columnId = ?', whereArgs: [id]);
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $tablelista'));
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(table, Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId]; // Como o _id não muda nas tabelas, sempre vou usar a variável.
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(tablelista, where: '$columnId = ?', whereArgs: [id]);
  }
}
