import 'package:consumo_servico_avancado/post.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<Post>> _recuperarPostagens() async {
    Uri _baseUrl = Uri.parse('https://jsonplaceholder.typicode.com/posts');

    var response = await http.get(_baseUrl);

    var dadosJson = jsonDecode(response.body);

    List<Post> postagens = [];

    for (var post in dadosJson) {
      Post p = Post(post['userId'], post['id'], post['title'], post['body']);

      postagens.add(p);
    }

    return postagens;
  }

  _post() async {
    Uri _baseUrl = Uri.parse('https://jsonplaceholder.typicode.com/posts');

    Post post = Post(2, 0, 'Título do post', 'Corpo da postatgem');

    var bodyPostagem = json.encode(post.toJson());

    var response = await http.post(
      _baseUrl,
      headers: {
        'Content-type': 'application/json; charset=UTF-8',
      },
      body: bodyPostagem,
    );

    print(response.body);
    print('Resposa: ' + response.statusCode.toString());
  }

  _put() async {
    Uri _baseUrl = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');

    var bodyPostagem = json.encode({
      "userId": 8,
      "title": "teste Atualizado",
      "body": "Criando uma postagem atualizado"
    });

    var response = await http.put(
      _baseUrl,
      headers: {
        'Content-type': 'application/json; charset=UTF-8',
      },
      body: bodyPostagem,
    );

    print(response.body);
    print('Resposa: ' + response.statusCode.toString());
  }

  _patch() async {
    Uri _baseUrl = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');

    var bodyPostagem = json.encode({"body": "Atualizando somente um campo"});

    var response = await http.put(
      _baseUrl,
      headers: {
        'Content-type': 'application/json; charset=UTF-8',
      },
      body: bodyPostagem,
    );

    print(response.body);
    print('Resposa: ' + response.statusCode.toString());
  }

  // _patch() {}
  _delete() async {
    Uri _baseUrl = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
    var response = await http.delete(
      _baseUrl,
      headers: {
        'Content-type': 'application/json; charset=UTF-8',
      },
    );

    print(response.body);
    print('Resposa: ' + response.statusCode.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Postagens'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                ElevatedButton(
                  onPressed: _post,
                  child: const Text('Post'),
                ),
                ElevatedButton(
                  onPressed: _delete,
                  child: const Text('Delete'),
                ),
                ElevatedButton(
                  onPressed: _put,
                  child: const Text('Put'),
                ),
                ElevatedButton(
                  onPressed: _patch,
                  child: const Text('Patch'),
                )
              ],
            ),
            Expanded(
              child: FutureBuilder<List<Post>>(
                future: _recuperarPostagens(),
                builder: (context, snapshot) {
                  String _erro = 'Erro desconhecido';

                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );

                    case ConnectionState.active:
                    case ConnectionState.done:
                      if (!snapshot.hasError) {
                        List<Post>? lista = snapshot.data;

                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            Post post = lista![index];

                            return ListTile(
                              title: Text(post.title),
                              subtitle: Text(post.body),
                            );
                          },
                        );
                      }
                  }

                  return Center(
                    child: Text(_erro),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
