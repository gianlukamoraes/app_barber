import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_slidy/app/shared/models/produto_model.dart';
import 'package:projeto_slidy/app/shared/repositories/database_helper.dart';

class ProdutoRepository extends Disposable {
  final helper = DatabaseHelper;
  static const table = 'produto';


  void inserirprodutonabase() async {
    final dbHelper = DatabaseHelper.instance;
    // row to insert
    Map<String, dynamic> row = {
      'nome': 'Arroz',
      'marca': 'Cristal',
      'unidademedida': 'PC',
    };

    final id = await dbHelper.inserirprodutonabase(table,row);
    print("Produto inserido na tabela de produtos -> [$id]");
  }

  Future<List<ProdutoModel>> buscarProdutos() async {
    final dbHelper = DatabaseHelper.instance;
    final allRows = await dbHelper.queryAllRows(table);
    List<ProdutoModel> retorno = List<ProdutoModel>();
    allRows.forEach((row) {
      retorno.add(ProdutoModel.fromJson(row));
    });
    return retorno;
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
