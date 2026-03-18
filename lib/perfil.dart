import 'package:flutter/material.dart';
import 'main.dart';

class PerfilPage extends StatefulWidget {
  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  final int seguidores = 348;
  final int seguindo = 120;

  final List<String> imagens = [
    'https://picsum.photos/200/200?random=1',
    'https://picsum.photos/200/200?random=2',
    'https://picsum.photos/200/200?random=3',
    'https://picsum.photos/200/200?random=4',
    'https://picsum.photos/200/200?random=5',
    'https://picsum.photos/200/200?random=6',
    'https://picsum.photos/200/200?random=7',
    'https://picsum.photos/200/200?random=8',
    'https://picsum.photos/200/200?random=9',
    'https://picsum.photos/200/200?random=10',
    'https://picsum.photos/200/200?random=11',
    'https://picsum.photos/200/200?random=12',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Perfil'))),
      body: Column(
        children: [
          // Cabeçalho do perfil
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40.0,
                  child: Text(
                    UsuarioLogado.nome.isNotEmpty
                        ? UsuarioLogado.nome[0].toUpperCase()
                        : '?',
                    style: TextStyle(fontSize: 30.0),
                  ),
                ),
                SizedBox(width: 24.0),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildContador(imagens.length.toString(), 'Posts'),
                      _buildContador(seguidores.toString(), 'Seguidores'),
                      _buildContador(seguindo.toString(), 'Seguindo'),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    UsuarioLogado.nome,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    UsuarioLogado.email,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 12.0),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                SizedBox(width: 8.0),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      UsuarioLogado.logado = false;
                      UsuarioLogado.nome = '';
                      UsuarioLogado.email = '';
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/login',
                        (route) => false,
                      );
                    },
                    child: Text('Sair', style: TextStyle(color: Colors.red)),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 12.0),
          Divider(),

          // Grid de fotos
          Expanded(
            child: GridView.builder(
              itemCount: imagens.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 2.0,
                mainAxisSpacing: 2.0,
              ),
              itemBuilder: (context, index) {
                return Image.network(imagens[index], fit: BoxFit.cover);
              },
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Feed'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/feed');
          }
        },
      ),
    );
  }

  Widget _buildContador(String valor, String label) {
    return Column(
      children: [
        Text(
          valor,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
        ),
        Text(label),
      ],
    );
  }
}
