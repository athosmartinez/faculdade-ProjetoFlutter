import 'package:flutter/material.dart';

class ListaScreen extends StatefulWidget {
  final String nome;

  const ListaScreen({Key? key, required this.nome}) : super(key: key);

  @override
  _ListaScreenState createState() => _ListaScreenState();
}

class _ListaScreenState extends State<ListaScreen> {
  final List<String> _itemDescriptions = List<String>.generate(20, (index) => 'Descrição do item ${index + 1}');
  final List<String> _itemTitles = List<String>.generate(20, (index) => 'Título ${index + 1} da lista');

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
              onPressed: () {
                setState(() {
                  _itemTitles[itemNumber - 1] = _titleController.text;
                  _itemDescriptions[itemNumber - 1] = _descriptionController.text;
                });
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
      body: ListView.builder(
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
