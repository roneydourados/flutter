import 'package:bytebank/models/saldo.dart';
import 'package:bytebank/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/cliente.dart';
import 'models/contato.dart';
import 'models/transferencias.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => Saldo(0),
          ),
          ChangeNotifierProvider(
            create: (context) => Transferencias(),
          ),
          ChangeNotifierProvider(
            create: (context) => Cliente(),
          ),
        ],
        child: const BytebankApp(),
      ),
    );

class BytebankApp extends StatelessWidget {
  const BytebankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          // é essa cor quem vai no fundo das telas, a cor diferente da padrão do tema
          secondary: Colors.green[700],
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blueAccent[700],
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: const Login(),
    );
  }
}
