import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_slidy/app/shared/models/listas_model.dart';
import 'package:projeto_slidy/app/shared/repositories/database_helper.dart';

class ListaDeProdutosRepository extends Disposable {
  final helper = DatabaseHelper;
  static const table = 'lista';

  void insert(name, place) async {
    final dbHelper = DatabaseHelper.instance;
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnName: name,
      DatabaseHelper.columnDate: DateTime.now().toString(),
      DatabaseHelper.columnPlace: place
    };

    final id = await dbHelper.insert(row);
    print(')(*&¨%@! -> inserted row id: $id');
  }

  void updateLista(id, name, place) async {
    // get a reference to the database
    // because this is an expensive operation we use async and await
    final dbHelper = DatabaseHelper.instance;

    // row to update
    Map<String, dynamic> row = {
      DatabaseHelper.columnId: id,
      DatabaseHelper.columnName: name,
      DatabaseHelper.columnPlace: place
    };

    // do the update and get the number of affected rows
    await dbHelper.update(table, row);

    // show the results: print all rows in the db
    //print(await dbHelper.query(DatabaseHelper.table));
  }

  Future<List<ListasModel>> buscarListas() async {
    final dbHelper = DatabaseHelper.instance;
    final allRows = await dbHelper.queryAllRows(table);
    List<ListasModel> retorno = List<ListasModel>();
    allRows.forEach((row) {
      retorno.add(ListasModel.fromJson(row));
    });
    return retorno;
  }

  Future<List<ListasModel>> buscarListasPorId(int id) async {
    final dbHelper = DatabaseHelper.instance;
    final allRows = await dbHelper.queryById(id);
    List<ListasModel> retorno = List<ListasModel>();
    allRows.forEach((row) {
      retorno.add(ListasModel.fromJson(row));
    });
    return retorno;
  }

  // Ajustar essa função pra buscar os produtos dentro da lista.
  Future<List<ListasModel>> buscarItensdaLista(id) async {
    final dbHelper = DatabaseHelper.instance;
    final allRows = await dbHelper.queryAllRows(table);
    List<ListasModel> retorno = List<ListasModel>();
    allRows.forEach((row) {
      retorno.add(ListasModel.fromJson(row));
    });
    return retorno;
  }

  apagarListas(id) async {
    final dbHelper = DatabaseHelper.instance;
    await dbHelper.delete(id);
  }
  //dispose will be called automatically
  @override
  void dispose() {}
}
