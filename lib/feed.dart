import 'package:flutter/material.dart';
import 'main.dart';

class FeedPage extends StatefulWidget {
  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  List<Map<String, dynamic>> posts = [
    {
      'usuario': 'joao_silva',
      'imagem': 'https://picsum.photos/400/400?random=1',
      'legenda': 'Que dia lindo!',
      'curtidas': 10,
      'curtido': false,
    },
    {
      'usuario': 'maria_souza',
      'imagem': 'https://picsum.photos/400/400?random=2',
      'legenda': 'Bom dia pessoal!',
      'curtidas': 25,
      'curtido': false,
    },
    {
      'usuario': 'pedro_santos',
      'imagem': 'https://picsum.photos/400/400?random=3',
      'legenda': 'Fim de semana chegando!',
      'curtidas': 42,
      'curtido': false,
    },
    {
      'usuario': 'ana_lima',
      'imagem': 'https://picsum.photos/400/400?random=4',
      'legenda': 'Natureza é tudo de bom.',
      'curtidas': 18,
      'curtido': false,
    },
  ];

  List<bool> _mostrarCoracao = [false, false, false, false];

  void _curtirDuploToque(int index) {
    if (!posts[index]['curtido']) {
      setState(() {
        posts[index]['curtido'] = true;
        posts[index]['curtidas'] += 1;
      });
    }

    setState(() => _mostrarCoracao[index] = true);

    Future.delayed(Duration(milliseconds: 800), () {
      setState(() => _mostrarCoracao[index] = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Feed'))),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header do post
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      child: Text(posts[index]['usuario'][0].toUpperCase()),
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      posts[index]['usuario'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),

              // Duplo clique para curtir
              GestureDetector(
                onDoubleTap: () => _curtirDuploToque(index),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.network(
                      posts[index]['imagem'],
                      width: double.infinity,
                      height: 300.0,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),

              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      posts[index]['curtido']
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: posts[index]['curtido'] ? Colors.red : null,
                    ),
                    onPressed: () {
                      setState(() {
                        posts[index]['curtido'] = !posts[index]['curtido'];
                        posts[index]['curtidas'] += posts[index]['curtido']
                            ? 1
                            : -1;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.comment_outlined),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/comentarios',
                        arguments: posts[index],
                      );
                    },
                  ),
                ],
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  '${posts[index]['curtidas']} curtidas',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),

              // Legenda
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: '${posts[index]['usuario']} ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: posts[index]['legenda']),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 12.0),
              Divider(),
            ],
          );
        },
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Feed'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.pushNamed(context, '/perfil');
          }
        },
      ),
    );
  }
}
