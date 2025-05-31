import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class ContatoModel extends ParseObject implements ParseCloneable {
  ContatoModel() : super('Contato');
  ContatoModel.clone() : this();

  @override
  ContatoModel clone(Map<String, dynamic> map) =>
      ContatoModel.clone()..fromJson(map);

  String get nome => get<String>('nome') ?? '';
  set nome(String value) => set<String>('nome', value);

  String get telefone => get<String>('telefone') ?? '';
  set telefone(String value) => set<String>('telefone', value);

  String get email => get<String>('email') ?? '';
  set email(String value) => set<String>('email', value);

  String get fotoPath => get<String>('fotoPath') ?? '';
  set fotoPath(String value) => set<String>('fotoPath', value);
}
