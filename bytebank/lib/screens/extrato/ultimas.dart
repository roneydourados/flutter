import 'package:bytebank/models/transferencias.dart';
import 'package:bytebank/screens/contatos/lista.dart';
import 'package:bytebank/screens/extrato/lista.dart';

// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'item.dart';

const _titulo = 'Últimas transferências';
const _conteudoBotao = 'Visualizar todas';

class UltimasTransferencias extends StatelessWidget {
  const UltimasTransferencias({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Text(
          _titulo,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        Consumer<Transferencias>(
          builder: (context, transferencias, child) {
            final _ultimasTransferencias = transferencias.transferencias.reversed.toList();
            final _quantidade = transferencias.transferencias.length;
            int tamanho;

            if (_quantidade < 3) {
              tamanho = _quantidade;
            } else {
              tamanho = 2;
            }

            if (_quantidade == 0) {
              return const Card(
                margin: EdgeInsets.all(40),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Você ainda não tem nenhuma transferência cadastrada',
                    textAlign: TextAlign.center,
                    style: TextStyle(),
                  ),
                ),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(8),
              shrinkWrap: true,
              itemCount: tamanho,
              itemBuilder: (context, indice) {
                final _transferencia = _ultimasTransferencias[indice];
                final _valor = _transferencia.toStringValor();
                final _conta = _transferencia.toStringConta();

                return Item.transferencia(_valor, _conta);
              },
            );
          },
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.green,
          ),
          child: Text(_conteudoBotao),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return const ListaMovimentacoes();
              }),
            );
          },
        ),
        const SizedBox(
          height: 120,
        ),
        Padding(
          padding: const EdgeInsets.only(
            right: 160,
          ),
          child: Material(
            color: Colors.green[900],
            child: InkWell(
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ListaContatos(),
                  ),
                ),
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                height: 100,
                width: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Icon(
                      Icons.people,
                      color: Colors.white,
                      size: 32,
                    ),
                    Text(
                      'Contados',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
