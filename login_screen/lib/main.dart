import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtém os insets de segurança do dispositivo para a barra de status
    final EdgeInsets statusBarPadding = MediaQuery.of(context).padding;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        drawer: Drawer(
          child: ListView(
            // Define o padding superior para o valor do padding da barra de status
            padding: EdgeInsets.only(top: statusBarPadding.top),
            children: const [
              ListTile(
                leading: Icon(Icons.message),
                title: Text('Mensagens'),
              ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Perfil'),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Configurações'),
              ),
            ],
          ),
        ),
        body: Stack(children: [
          Image.asset(
            "assets/images/backgroundImage2.jpg",
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Usuário',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.7),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.7),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Não tem conta? ',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          InkWell(
                            // onTap: () {},
                            child: Text(
                              'Cadastrar',
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  decoration: TextDecoration.underline,
                                  fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Logica de autenticação
                      },
                      child: const Text('Entrar'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
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
      ),
    );
  }
}
