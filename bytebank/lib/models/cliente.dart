import 'dart:io';
import 'package:flutter/material.dart';

class Cliente extends ChangeNotifier {
  String _nome = '';
  String _email = '';
  String _celular = '';
  String _cpf = '';
  String _nascimento = '';
  String _cep = '';
  String _estado = '';
  String _cidade = '';
  String _bairro = '';
  String _logradouro = '';
  String _numero = '';
  String _senha = '';
  File _imagemDocumento = File('assets/images/logo.png');
  int _stepAtual = 0;
  bool _biometria = false;

  String get nome => _nome;
  String get email => _email;
  String get celular => _celular;
  String get cpf => _cpf;
  String get nascimento => _nascimento;
  String get cep => _cep;
  String get estado => _estado;
  String get cidade => _cidade;
  String get bairro => _bairro;
  String get logradouro => _logradouro;
  String get numero => _numero;
  String get senha => _senha;
  int get stepAtual => _stepAtual;
  File get imagemDocumento => _imagemDocumento;
  bool get biometria => _biometria;

  set nome(String value) {
    _nome = value;

    notifyListeners();
  }

  set email(String value) {
    _email = value;

    notifyListeners();
  }

  set celular(String value) {
    _celular = value;

    notifyListeners();
  }

  set cpf(String value) {
    _cpf = value;

    notifyListeners();
  }

  set nascimento(String value) {
    _nascimento = value;

    notifyListeners();
  }

  set cep(String value) {
    _cep = value;

    notifyListeners();
  }

  set estado(String value) {
    _estado = value;

    notifyListeners();
  }

  set cidade(String value) {
    _cidade = value;

    notifyListeners();
  }

  set bairro(String value) {
    _bairro = value;

    notifyListeners();
  }

  set logradouro(String value) {
    _logradouro = value;

    notifyListeners();
  }

  set numero(String value) {
    _numero = value;

    notifyListeners();
  }

  set senha(String value) {
    _senha = value;

    notifyListeners();
  }

  set stepAtual(int value) {
    _stepAtual = value;

    notifyListeners();
  }

  set imagemDocumento(File value) {
    _imagemDocumento = value;

    notifyListeners();
  }

  set biometria(bool value) {
    _biometria = value;

    notifyListeners();
  }
}
