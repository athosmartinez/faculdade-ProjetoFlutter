import 'package:flutter/material.dart';

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({Key? key}) : super(key: key);

  @override
  _CadastroScreenState createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  String _nome = ''; // Variável para armazenar o nome
  DateTime? _dataNascimento; // Variável para armazenar a data de nascimento
  String _email = '';
  String _senha = '';
  String _genero = 'Masculino';
  bool _notificacaoEmail = false;
  bool _notificacaoCelular = false;
  double _fontSize = 14;

  // Método para selecionar a data de nascimento
  Future<void> _selecionarData(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (picked != null && picked != _dataNascimento) {
      setState(() {
        _dataNascimento = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create an account', style: TextStyle(fontSize: _fontSize)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Campo Nome
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Nome'),
                  onChanged: (value) => _nome = value,
                  maxLength: 60,
                  style: TextStyle(fontSize: _fontSize),
                ),
                // Campo Data de Nascimento
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Data de Nascimento',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  onTap: () => _selecionarData(context),
                  readOnly: true, // Impede a edição direta do campo
                  controller: TextEditingController(
                    text: _dataNascimento != null
                        ? '${_dataNascimento!.day}/${_dataNascimento!.month}/${_dataNascimento!.year}'
                        : '',
                  ),
                  style: TextStyle(fontSize: _fontSize),
                ),
                // Campo E-mail
                TextFormField(
                  decoration: const InputDecoration(labelText: 'E-mail'),
                  keyboardType: TextInputType.emailAddress,
                  maxLength: 80,
                  onChanged: (value) => _email = value,
                  style: TextStyle(fontSize: _fontSize),
                ),
                // Campo Senha
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    suffixIcon: IconButton(
                      icon: Icon(_obscureText
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                  obscureText: _obscureText,
                  maxLength: 20,
                  onChanged: (value) => _senha = value,
                  style: TextStyle(fontSize: _fontSize),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Gênero:',
                      style: TextStyle(
                          fontSize: _fontSize, fontWeight: FontWeight.bold),
                    ),
                    // Seleção de Gênero
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio<String>(
                          value: 'Masculino',
                          groupValue: _genero,
                          onChanged: (value) {
                            setState(() {
                              _genero = value!;
                            });
                          },
                        ),
                        Text(
                          'Masculino',
                          style: TextStyle(fontSize: _fontSize),
                        ),
                        Radio<String>(
                          value: 'Feminino',
                          groupValue: _genero,
                          onChanged: (value) {
                            setState(() {
                              _genero = value!;
                            });
                          },
                        ),
                        Text(
                          'Feminino',
                          style: TextStyle(fontSize: _fontSize),
                        ),
                      ],
                    ),
                  ],
                ),
                // Notificações
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Notificações:',
                      style: TextStyle(
                          fontSize: _fontSize, fontWeight: FontWeight.bold),
                    ),
                    SwitchListTile(
                      title: Text(
                        'E-mail',
                        style: TextStyle(fontSize: _fontSize),
                      ),
                      value: _notificacaoEmail,
                      onChanged: (bool value) {
                        setState(() {
                          _notificacaoEmail = value;
                        });
                      },
                      secondary: const Icon(Icons.email),
                    ),
                    SwitchListTile(
                      title: Text(
                        'Celular',
                        style: TextStyle(fontSize: _fontSize),
                      ),
                      value: _notificacaoCelular,
                      onChanged: (bool value) {
                        setState(() {
                          _notificacaoCelular = value;
                        });
                      },
                      secondary: const Icon(Icons.phone_android),
                    ),
                  ],
                ),
                // Botão Registrar
                ElevatedButton(
                  child: Text(
                    'Register',
                    style: TextStyle(fontSize: _fontSize),
                  ),
                  onPressed: () {
                    // Implementar funcionalidade de registro
                  },
                ),
                // Slider FontSize
                Slider(
                  value: _fontSize,
                  min: 10,
                  max: 24,
                  divisions: 14,
                  label: _fontSize.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      _fontSize = value;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Minha conta',
          ),
        ],
      ),
    );
  }
}
