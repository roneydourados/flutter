// import 'package:flutter/material.dart';

import 'package:notas_diarias_banco_dados/helper/anotacao_helper.dart';

class Anotacao {
  late int? id;
  late String titulo;
  late String descricao;
  late String data;

  Anotacao({
    this.id,
    required this.titulo,
    required this.descricao,
    required this.data,
  });

  Anotacao.fromMap(Map mapAnotacao) {
    id = mapAnotacao[AnotacaoHelper.columnId];
    titulo = mapAnotacao[AnotacaoHelper.columnTitle];
    descricao = mapAnotacao[AnotacaoHelper.columnDescription];
    data = mapAnotacao[AnotacaoHelper.columnData];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      'titulo': titulo,
      'descricao': descricao,
      'data': data,
    };

    if (id != null) {
      map['id'] = id;
    }

    return map;
  }
}
