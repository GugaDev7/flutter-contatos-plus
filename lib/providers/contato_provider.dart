import 'package:flutter/material.dart';
import '../models/contato_model.dart';
import '../repositories/contato_repository.dart';

class ContatoProvider extends ChangeNotifier {
  final ContatoRepository _repository = ContatoRepository();
  List<ContatoModel> _contatos = [];
  bool _isLoading = false;

  List<ContatoModel> get contatos => _contatos;
  bool get isLoading => _isLoading;

  Future<void> loadContatos() async {
    _isLoading = true;
    notifyListeners();

    _contatos = await _repository.getContatos();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> saveContato(ContatoModel contato) async {
    await _repository.saveContato(contato);
    await loadContatos();
  }

  Future<void> deleteContato(ContatoModel contato) async {
    await _repository.deleteContato(contato);
    await loadContatos();
  }
}
