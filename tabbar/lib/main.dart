import 'package:flutter/material.dart';
import 'package:tabbar/home.dart';

void main() => runApp(AprendaIngles());

class AprendaIngles extends StatelessWidget {
  AprendaIngles({Key? key}) : super(key: key);

  final ThemeData theme = ThemeData();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Home(),
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: Colors.brown,
          // é essa cor quem vai no fundo das telas, a cor diferente da padrão do tema
          secondary: Colors.brown,
          outline: Colors.grey,
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blueAccent[700],
          textTheme: ButtonTextTheme.primary,
        ),
      ),
    );
  }
}
