import 'package:flutter/material.dart';
import 'login.dart';
import 'cadastro.dart';
import 'feed.dart';
import 'perfil.dart';
import 'comentarios.dart';

class UsuarioLogado {
  static String nome = '';
  static String email = '';
  static bool logado = false;
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram',
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login':        (context) => LoginPage(),
        '/cadastro':     (context) => CadastroPage(),
        '/feed':         (context) => UsuarioLogado.logado ? FeedPage()          : LoginPage(),
        '/perfil':       (context) => UsuarioLogado.logado ? PerfilPage()        : LoginPage(),
        '/comentarios':  (context) => UsuarioLogado.logado ? ComentariosPage()   : LoginPage(),
      },
    );
  }
}