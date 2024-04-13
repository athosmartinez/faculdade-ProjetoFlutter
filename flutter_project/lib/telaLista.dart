import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListaScreen extends StatefulWidget {
  final String nome;

  const ListaScreen({Key? key, required this.nome}) : super(key: key);

  @override
  _ListaScreenState createState() => _ListaScreenState();
}

class _ListaScreenState extends State<ListaScreen> {
  List<String> _itemDescriptions = [];
  List<String> _itemTitles = [];
  bool _isLoading = true; // Flag para indicar se os dados ainda estão sendo carregados

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _itemTitles = prefs.getStringList('itemTitles') ?? List<String>.generate(20, (index) => 'Título ${index + 1} da lista');
      _itemDescriptions = prefs.getStringList('itemDescriptions') ?? List<String>.generate(20, (index) => 'Descrição do item ${index + 1}');
      _isLoading = false; // Dados carregados, remova o indicador de carregamento
    });
  }

  Future<void> _saveData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('itemTitles', _itemTitles);
    await prefs.setStringList('itemDescriptions', _itemDescriptions);
  }

  void _showDialog(BuildContext context, int itemNumber) {
    TextEditingController _descriptionController = TextEditingController(text: _itemDescriptions[itemNumber - 1]);
    TextEditingController _titleController = TextEditingController(text: _itemTitles[itemNumber - 1]);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar Item $itemNumber'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(hintText: "Edite o título"),
              ),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(hintText: "Edite a descrição"),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Salvar'),
              onPressed: () async {
                setState(() {
                  _itemTitles[itemNumber - 1] = _titleController.text;
                  _itemDescriptions[itemNumber - 1] = _descriptionController.text;
                });
                await _saveData();
                Navigator.of(context).pop(); // Fecha o AlertDialog
              },
            ),
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o AlertDialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bem vindo(a), ${widget.nome}'),
      ),
      body: _isLoading
        ? Center(child: CircularProgressIndicator()) // Mostra um indicador de carregamento enquanto os dados não são carregados
        : ListView.builder(
            itemCount: 20,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text(_itemTitles[index]),
                  subtitle: Text(_itemDescriptions[index]),
                  onTap: () => _showDialog(context, index + 1), // Chama a função _showDialog quando um item é tocado.
                ),
              );
            },
          ),
    );
  }
}
