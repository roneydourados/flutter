import 'package:flutter/material.dart';

exibirAlerta({context, titulo, content}) {
  final Color backColor = Theme.of(context).colorScheme.secondary;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(titulo),
        content: Text(content),
        actions: [
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              // shape: StadiumBorder(), aqui deixa botão redondo
              side: BorderSide(
                color: backColor,
                width: 2,
              ),
            ),
            onPressed: () => {
              Navigator.pop(context),
            },
            child: Text(
              'OK',
              style: TextStyle(
                color: backColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      );
    },
  );
}
