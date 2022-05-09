import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _tasks = [];
  Map<String, dynamic> _lastTaskDeleted = {};
  final TextEditingController _taskTitleController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _ler().then((data) {
      setState(() {
        _tasks = json.decode(data);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tasks',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.purple,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        child: const Icon(Icons.add),
        elevation: 20,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return _dialogTasks('Nova tarefa', context);
            },
          );
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return _listTasks(context, index);
              },
              itemCount: _tasks.length,
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu),
            )
          ],
        ),
      ),
    );
  }

  Widget _listTasks(context, index) {
    // DateTime.now().microsecondsSinceEpoch.toString()
    // essa função acima serve para gerar um número aleatório sempre diferente
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
      onDismissed: (direction) {
        _lastTaskDeleted = _tasks[index];

        setState(() {
          _tasks.removeAt(index);
        });

        _salvar();

        // dar a opção de desfazer exclusão com snacbar
        final snackBar = SnackBar(
          duration: const Duration(seconds: 3),
          content: const Text('Terefa removida'),
          action: SnackBarAction(
            label: 'Desfazer',
            textColor: Colors.blue[200],
            onPressed: () {
              setState(() {
                _tasks.insert(index, _lastTaskDeleted);
              });

              _salvar();
            },
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      child: CheckboxListTile(
        title: Text(_tasks[index]['title']),
        value: _tasks[index]['conluded'],
        onChanged: (changedValue) {
          setState(() {
            _tasks[index]['conluded'] = changedValue;
          });

          _salvar();
        },
      ),
    );
  }

  Widget _dialogTasks(String title, context) {
    return AlertDialog(
      title: Text(title),
      content: TextField(
        controller: _taskTitleController,
        decoration: const InputDecoration(
          labelText: 'Tarefa',
        ),
        onChanged: (text) {},
      ),
      actions: [
        TextButton(
          child: const Text('Salvar'),
          onPressed: () {
            _taskSave();
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: const Text('Cancelar'),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/dados.json');
  }

  void _taskSave() {
    String textoDigitado = _taskTitleController.text;

    Map<String, dynamic> task = {};
    task['title'] = textoDigitado;
    task['conluded'] = false;

    setState(() {
      _tasks.add(task);
    });

    _salvar();

    _taskTitleController.text = '';
  }

  void _salvar() async {
    var data = await _getFile();
    String dados = json.encode(_tasks);
    data.writeAsString(dados);
  }

  Future<String> _ler() async {
    try {
      final file = await _getFile();
      return file.readAsString();
    } catch (e) {
      return '';
    }
  }
}
