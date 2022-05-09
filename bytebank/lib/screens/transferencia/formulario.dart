import 'package:bytebank/components/editor.dart';
import 'package:bytebank/components/mensagem.dart';
import 'package:bytebank/models/saldo.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:bytebank/models/transferencias.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const _tituloAppBar = 'Criando Transferência';

const _rotuloCampoValor = 'Valor';
const _dicaCampoValor = '0.00';

const _rotuloCampoNumeroConta = 'Número da conta';
const _dicaCampoNumeroConta = '0000';

const _textoBotaoConfirmar = 'Confirmar';

class FormularioTransferencia extends StatelessWidget {
  FormularioTransferencia({Key? key}) : super(key: key);

  final TextEditingController _controladorCampoNumeroConta =
      TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Color backColor = Theme.of(context).colorScheme.secondary;
    return Scaffold(
        appBar: AppBar(
          title: const Text(_tituloAppBar),
          backgroundColor: backColor,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Editor(
                controlador: _controladorCampoNumeroConta,
                dica: _dicaCampoNumeroConta,
                rotulo: _rotuloCampoNumeroConta,
              ),
              Editor(
                dica: _dicaCampoValor,
                controlador: _controladorCampoValor,
                rotulo: _rotuloCampoValor,
                icone: Icons.monetization_on,
              ),
              ElevatedButton(
                child: const Text(_textoBotaoConfirmar),
                onPressed: () => _criaTransferencia(context),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                ),
              ),
            ],
          ),
        ));
  }

  void _criaTransferencia(BuildContext context) {
    final int? numeroConta = int.tryParse(_controladorCampoNumeroConta.text);
    final double? valor = double.tryParse(_controladorCampoValor.text);
    final transferenciaValida =
        _validaTransferencia(context, numeroConta, valor);

    if (transferenciaValida == '') {
      final novaTransferencia = Transferencia(valor!, numeroConta!);

      _atualizaEstado(context, novaTransferencia, valor);

      Navigator.pop(context);
    } else {
      exibirAlerta(
        context: context,
        titulo: 'ATENÇÃO',
        content: transferenciaValida,
      );
    }
  }

  String _validaTransferencia(context, numeroConta, valor) {
    String mensagem = '';

    final _camposPreenchidos = numeroConta != null && valor != null;
    final _saldoSuficiente =
        valor <= Provider.of<Saldo>(context, listen: false).valor;

    if (!_camposPreenchidos) {
      mensagem = 'Verifique os campos Numero de conta e valor!';
    }

    if (!_saldoSuficiente) {
      mensagem = mensagem +
          'Saldo insuficiente, saldo disponível é ${Provider.of<Saldo>(context, listen: false).valor.toString()}';
    }

    return mensagem; //_camposPreenchidos && _saldoSuficiente;
  }

  void _atualizaEstado(context, novaTransferencia, valor) {
    Provider.of<Transferencias>(context, listen: false)
        .adiciona(novaTransferencia);
    Provider.of<Saldo>(context, listen: false).subtrai(valor);
  }
}
