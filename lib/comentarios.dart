import 'package:flutter/material.dart';
import 'package:atv_insta/main.dart';

class ComentariosPage extends StatefulWidget {
  @override
  State<ComentariosPage> createState() => _ComentariosPageState();
}

class _ComentariosPageState extends State<ComentariosPage> {
  final TextEditingController _comentarioController = TextEditingController();

  final List<Map<String, String>> comentarios = [
    {'usuario': 'maria_souza', 'texto': 'Que foto incrível!'},
    {'usuario': 'pedro_santos', 'texto': 'Demais! 🔥'},
    {'usuario': 'ana_lima', 'texto': 'Adorei!'},
  ];

  void _adicionarComentario() {
    if (_comentarioController.text.isEmpty) return;

    setState(() {
      comentarios.add({
        'usuario': UsuarioLogado.nome,
        'texto': _comentarioController.text,
      });
    });

    _comentarioController.clear();
  }

  @override
  void dispose() {
    _comentarioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final post =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Comentários'))),
      body: Column(
        children: [
          // Imagem e legenda do post
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Row(
              children: [
                CircleAvatar(child: Text(post['usuario'][0].toUpperCase())),
                SizedBox(width: 8.0),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: '${post['usuario']} ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: post['legenda']),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          Divider(),

          Expanded(
            child: ListView.builder(
              itemCount: comentarios.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 8.0,
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 16.0,
                        child: Text(
                          comentarios[index]['usuario']![0].toUpperCase(),
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(color: Colors.black),
                            children: [
                              TextSpan(
                                text: '${comentarios[index]['usuario']} ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(text: comentarios[index]['texto']),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          Divider(),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _comentarioController,
                    decoration: InputDecoration(
                      hintText: 'Adicione um comentário...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: _adicionarComentario,
                  child: Text('Publicar'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
