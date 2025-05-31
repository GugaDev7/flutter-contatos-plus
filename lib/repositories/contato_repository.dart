import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import '../models/contato_model.dart';

class ContatoRepository {
  Future<List<ContatoModel>> getContatos() async {
    QueryBuilder<ContatoModel> query =
        QueryBuilder<ContatoModel>(ContatoModel());
    return await query.find();
  }

  Future<void> saveContato(ContatoModel contato) async {
    await contato.save();
  }

  Future<void> deleteContato(ContatoModel contato) async {
    await contato.delete();
  }
}
