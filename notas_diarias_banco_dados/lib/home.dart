import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:notas_diarias_banco_dados/helper/anotacao_helper.dart';
import 'package:notas_diarias_banco_dados/model/anotacao.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final _db = AnotacaoHelper();
  List<Anotacao> _anotacoes = [];

  @override
  void initState() {
    super.initState();
    _recuperarAnotacoes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anotações'),
        backgroundColor: Colors.lightGreen,
      ),
      body: ListView.builder(
        itemCount: _anotacoes.length,
        itemBuilder: (context, index) {
          return _listarAnotacoes(context, index);
        },
      ),
      floatingActionButton: _floatButton(),
    );
  }

  _telaAnotacao(context, {Anotacao? anotacao}) {
    String tituloTela = 'Criar';

    if (anotacao != null) {
      _tituloController.text = anotacao.titulo;
      _descricaoController.text = anotacao.descricao;
      tituloTela = 'Atualizar';
    } else {
      _tituloController.clear();
      _descricaoController.clear();
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('$tituloTela Anotação'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _tituloController,
                autofocus: true,
                decoration: const InputDecoration(
                  label: Text('Título'),
                ),
              ),
              TextField(
                controller: _descricaoController,
                autofocus: true,
                decoration: const InputDecoration(
                  label: Text('Descrição da anotação'),
                ),
              ),
            ],
          ),
          actions: [
            Container(
              padding: const EdgeInsets.all(16),
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: TextButton(
                onPressed: () {
                  _salvarAtualizarAnotacao(anotacaoEdit: anotacao);

                  Navigator.pop(context);
                },
                child: Text(tituloTela),
              ),
            ),
          ],
        );
      },
    );
  }

  _salvarAtualizarAnotacao({Anotacao? anotacaoEdit}) async {
    String titulo = _tituloController.text;
    String descricao = _descricaoController.text;

    if (anotacaoEdit == null) {
      String dataAtual = DateTime.now().toString();

      Anotacao anotacao =
          Anotacao(titulo: titulo, descricao: descricao, data: dataAtual);

      await _db.salvar(anotacao);
    } else {
      anotacaoEdit.titulo = titulo;
      anotacaoEdit.descricao = descricao;
      anotacaoEdit.data = DateTime.now().toString();
      await _db.atualizar(anotacaoEdit);
    }

    _tituloController.clear();
    _descricaoController.clear();

    await _recuperarAnotacoes();
  }

  _salvarAnotacaoRecupedada(Anotacao anotacao) async {
    await _db.salvar(anotacao);
    await _recuperarAnotacoes();
  }

  _recuperarAnotacoes() async {
    List anotacoesRecuperadas = await _db.recuperarAnotacoes();

    List<Anotacao>? _tempAnotacoes = [];

    for (var item in anotacoesRecuperadas) {
      Anotacao anotacao = Anotacao.fromMap(item);

      _tempAnotacoes.add(anotacao);
    }

    setState(() {
      if (_tempAnotacoes != null) {
        _anotacoes = _tempAnotacoes;
      }
    });

    _tempAnotacoes = null;
  }

  _apagarAnotacao(int id) async {
    await _db.deletarAnotacao(id);
    _recuperarAnotacoes();
  }

  _formatDate(String date) {
    initializeDateFormatting('pt_BR');

    var formaterDate =
        DateFormat.yMd('pt_BR'); //DateFormat('dd/MM/yyyy HH:mm');
    DateTime dateConvert = DateTime.parse(date);
    String dateFormated = formaterDate.format(dateConvert);

    return dateFormated;
  }

  Widget _listarAnotacoes(context, index) {
    var item = _anotacoes[index];

    return Dismissible(
      key: Key(DateTime.now().microsecondsSinceEpoch.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Icon(
              Icons.delete,
              color: Colors.white,
            )
          ],
        ),
      ),
      onDismissed: (direction) async {
        // dar a opção de desfazer exclusão com snacbar
        if (item.id != null) {
          Anotacao anotacaoDeletada = Anotacao(
            titulo: item.titulo,
            descricao: item.descricao,
            data: item.data,
            id: item.id,
          );

          _apagarAnotacao(item.id!.toInt());

          final snackBar = SnackBar(
            duration: const Duration(seconds: 3),
            content: const Text('Anotação removida'),
            action: SnackBarAction(
              label: 'Desfazer',
              textColor: Colors.blue[200],
              onPressed: () async {
                await _salvarAnotacaoRecupedada(anotacaoDeletada);
              },
            ),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: Card(
        key: Key(DateTime.now().microsecondsSinceEpoch.toString()),
        child: ListTile(
          title: Text(item.titulo),
          subtitle: Text('${_formatDate(item.data)} - ${item.descricao}'),
          trailing: IconButton(
            padding: const EdgeInsets.all(8),
            onPressed: () {
              Anotacao anotacaoEditar = Anotacao(
                titulo: item.titulo,
                descricao: item.descricao,
                data: item.data,
                id: item.id,
              );

              _telaAnotacao(context, anotacao: anotacaoEditar);
            },
            icon: const Icon(Icons.edit),
            color: Colors.green,
          ),
        ),
      ),
    );
  }

  Widget _floatButton() {
    return FloatingActionButton(
      onPressed: () {
        _telaAnotacao(context);
      },
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
      child: const Icon(Icons.add),
    );
  }
}
