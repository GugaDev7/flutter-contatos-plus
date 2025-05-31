import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/contato_provider.dart';
import '../models/contato_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart' as path;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _emailController = TextEditingController();
  String? _fotoPath;
  String? _fotoUrl;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ContatoProvider>().loadContatos();
    });
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 800,
      imageQuality: 85,
    );

    if (image != null) {
      if (kIsWeb) {
        setState(() {
          _fotoPath = image.path;
          _fotoUrl = image.path;
        });
      } else {
        final directory =
            await path_provider.getApplicationDocumentsDirectory();
        final name = path.basename(image.path);
        final imageFile = File('${directory.path}/$name');
        final newImage = await File(image.path).copy(imageFile.path);

        setState(() {
          _fotoPath = newImage.path;
          _fotoUrl = null;
        });
      }
    }
  }

  void _showContatoDialog([ContatoModel? contato]) {
    _nomeController.text = contato?.nome ?? '';
    _telefoneController.text = contato?.telefone ?? '';
    _emailController.text = contato?.email ?? '';
    _fotoPath = contato?.fotoPath;
    _fotoUrl = contato?.fotoPath;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(contato == null ? 'Novo Contato' : 'Editar Contato'),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: _getImageProvider(),
                    child: (_fotoPath == null && _fotoUrl == null)
                        ? const Icon(Icons.add_a_photo,
                            size: 30, color: Colors.grey)
                        : null,
                  ),
                ),
                TextFormField(
                  controller: _nomeController,
                  decoration: const InputDecoration(labelText: 'Nome'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o nome';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _telefoneController,
                  decoration: const InputDecoration(labelText: 'Telefone'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o telefone';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o email';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final novoContato = contato ?? ContatoModel();
                novoContato.nome = _nomeController.text;
                novoContato.telefone = _telefoneController.text;
                novoContato.email = _emailController.text;
                if (_fotoPath != null) {
                  novoContato.fotoPath = _fotoPath!;
                }

                await context.read<ContatoProvider>().saveContato(novoContato);
                if (mounted) Navigator.pop(context);
              }
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  ImageProvider? _getImageProvider() {
    if (kIsWeb) {
      if (_fotoUrl != null && _fotoUrl!.isNotEmpty) {
        return NetworkImage(_fotoUrl!);
      } else if (_fotoPath != null && _fotoPath!.isNotEmpty) {
        return NetworkImage(_fotoPath!);
      }
    } else {
      if (_fotoPath != null && _fotoPath!.isNotEmpty) {
        return FileImage(File(_fotoPath!));
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agenda de Contatos'),
      ),
      body: Consumer<ContatoProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.contatos.isEmpty) {
            return const Center(child: Text('Nenhum contato encontrado'));
          }

          return ListView.builder(
            itemCount: provider.contatos.length,
            itemBuilder: (context, index) {
              final contato = provider.contatos[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: contato.fotoPath.isNotEmpty
                      ? (kIsWeb
                          ? NetworkImage(contato.fotoPath)
                          : FileImage(File(contato.fotoPath)) as ImageProvider)
                      : null,
                  child: contato.fotoPath.isEmpty
                      ? Text(contato.nome[0].toUpperCase())
                      : null,
                ),
                title: Text(contato.nome),
                subtitle: Text('${contato.telefone}\n${contato.email}'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => provider.deleteContato(contato),
                ),
                onTap: () => _showContatoDialog(contato),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showContatoDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _telefoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
