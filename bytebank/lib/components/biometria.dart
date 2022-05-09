import 'package:bytebank/models/cliente.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';

import 'package:flutter/services.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

class Biometria extends StatelessWidget {
  Biometria({Key? key}) : super(key: key);

  final _autenticacaoLocal = LocalAuthentication();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _biometriaDisponivel(),
      builder: (context, snapshot) {
        if (snapshot.data == true) {
          return Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 15),
            child: Column(
              children: [
                const Text(
                  'Detectamos que você possui sensor biométrico, deseja cadastrar ?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    await _autenticarCliente(context);
                  },
                  child: const Text('Habilitar biometria'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                ),
              ],
            ),
          );
        }

        return Container();
      },
    );
  }

  Future<bool> _biometriaDisponivel() async {
    try {
      return await _autenticacaoLocal.canCheckBiometrics;
    } on PlatformException catch (e) {
      debugPrint('deu erro ' + e.message!);
      if (e.code == auth_error.notAvailable) {
        return false;
      }
      return false;
    }
  }

  Future<void> _autenticarCliente(context) async {
    bool autenticado = false;

    try {
      autenticado = await _autenticacaoLocal.authenticate(
        localizedReason: 'Informe biometria!',
        useErrorDialogs: true,
        biometricOnly: true,
      );

      Provider.of<Cliente>(context, listen: false).biometria = autenticado;
    } on PlatformException catch (e) {
      debugPrint('deu erro ' + e.message!);
    }
  }
}
