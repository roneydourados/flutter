import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/models/contato.dart';
import 'package:bytebank/screens/contatos/novo_contato.dart';
import 'package:flutter/material.dart';

class ListaContatos extends StatelessWidget {
  const ListaContatos({Key? key}) : super(key: key); // aqui faz a consulta dos dados

  @override
  Widget build(BuildContext context) {
    final Color backColor = Theme.of(context).colorScheme.secondary;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contatos'),
        backgroundColor: backColor,
      ),
      body: FutureBuilder<List<Contato>>(
        initialData: const [],
        future: findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                    Text('Carregando...'),
                  ],
                ),
              ) ;
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (snapshot.data != null) {
                final contatos = snapshot.data;
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final Contato contato = contatos![index];
                    return _ContatoItem(contato);
                  },
                  itemCount: contatos!.length,
                );
              }
              break;
          }
          return const Text('Erro desconhecido, entre em contato com suporte!');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const NovoContatoForm();
              },
            ),
          )
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _ContatoItem extends StatelessWidget {
  final Contato contato;

  const _ContatoItem(this.contato);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          contato.nomeContato,
          style: const TextStyle(fontSize: 24),
        ),
        subtitle: Text(
          contato.numeroConta.toString(),
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
