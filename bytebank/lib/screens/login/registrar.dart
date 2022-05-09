import 'dart:io';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:bytebank/components/biometria.dart';
import 'package:bytebank/models/cliente.dart';
import 'package:bytebank/screens/dashboard/dashboard.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flux_validator_dart/flux_validator_dart.dart';
import 'package:image_picker/image_picker.dart';

class Registrar extends StatefulWidget {
  const Registrar({Key? key}) : super(key: key);

  @override
  _RegistrarState createState() => _RegistrarState();
}

class _RegistrarState extends State<Registrar> {
  //step 1
  final _formUserData = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _celuarController = TextEditingController();
  final TextEditingController _nascimentoController = TextEditingController();

  //step 2
  final _formUserAdderess = GlobalKey<FormState>();
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _logradouroController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();

  //step 3
  final _formUserAuth = GlobalKey<FormState>();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmarSenhaController =
      TextEditingController();
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final Color backColor = Theme.of(context).colorScheme.secondary;

    return Scaffold(
      //backgroundColor: backColor,
      appBar: AppBar(
        title: const Text('Novo cliente'),
        backgroundColor: backColor,
      ),
      body: Consumer<Cliente>(
        builder: (context, cliente, child) {
          return Stepper(
            currentStep: cliente.stepAtual,
            onStepContinue: () {
              final functions = [
                _salvarStep1,
                _salvarStep2,
                _salvarStep3,
              ];

              // ignore: void_checks
              return functions[cliente.stepAtual](context);
            },
            onStepCancel: () {
              cliente.stepAtual =
                  cliente.stepAtual > 0 ? cliente.stepAtual - 1 : 0;
            },
            steps: _construirSteps(context, cliente),
            controlsBuilder: (context, stepFunctions) {
              return Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: stepFunctions.onStepContinue,
                      child: const Text('Salvar'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: stepFunctions.onStepCancel,
                      child: const Text('Voltar'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  _salvarStep1(context) {
    if (_formUserData.currentState!.validate()) {
      Cliente stateCliente = Provider.of<Cliente>(context, listen: false);

      stateCliente.nome = _nomeController.text;
      stateCliente.email = _emailController.text;
      stateCliente.cpf = _cpfController.text;
      stateCliente.celular = _celuarController.text;
      stateCliente.nascimento = _nascimentoController.text;

      _proximoStep(context);
    }
  }

  _salvarStep2(context) {
    if (_formUserAdderess.currentState!.validate()) {
      Cliente stateCliente = Provider.of<Cliente>(context, listen: false);

      stateCliente.cep = _celuarController.text;
      stateCliente.estado = _estadoController.text;
      stateCliente.cidade = _cidadeController.text;
      stateCliente.bairro = _bairroController.text;
      stateCliente.logradouro = _logradouroController.text;
      stateCliente.numero = _numeroController.text;

      _proximoStep(context);
    }
  }

  _salvarStep3(context) {
    if (_formUserAuth.currentState!.validate()) {
      Cliente stateCliente = Provider.of<Cliente>(context, listen: false);
      FocusScope.of(context).unfocus(); //remove o foco do ultimo campo

      stateCliente.senha = _senhaController.text;
      stateCliente.stepAtual = 0;

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const Dashboard(),
        ),
        (route) => false,
      );
    }
  }

  List<Step> _construirSteps(context, cliente) {
    List<Step> step = [
      Step(
        title: const Text('Seus dados'),
        isActive: cliente.stepAtual >= 0,
        content: SingleChildScrollView(
          child: Form(
            key: _formUserData,
            child: Column(
              children: [
                TextFormField(
                  controller: _nomeController,
                  keyboardType: TextInputType.text,
                  maxLength: 255,
                  decoration: const InputDecoration(labelText: 'Nome'),
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'Nome inválido!';
                    }

                    if (value.length < 3) {
                      return 'Nome inválido!';
                    }

                    if (!value.contains(" ")) {
                      return 'Informe sobrenome!';
                    }

                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  maxLength: 255,
                  decoration: const InputDecoration(labelText: 'Email'),
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  validator: (value) =>
                      Validator.email(value) ? 'Email inválido' : null,
                ),
                TextFormField(
                  controller: _cpfController,
                  keyboardType: TextInputType.number,
                  maxLength: 14,
                  decoration: const InputDecoration(labelText: 'CPF'),
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  validator: (value) =>
                      Validator.cpf(value) ? 'CPF Inválido' : null,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CpfInputFormatter(),
                  ],
                ),
                TextFormField(
                  controller: _celuarController,
                  keyboardType: TextInputType.number,
                  maxLength: 16,
                  decoration: const InputDecoration(labelText: 'Celular'),
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  validator: (value) =>
                      Validator.phone(value) ? 'Telefone inválido' : null,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    TelefoneInputFormatter(),
                  ],
                ),
                DateTimePicker(
                  controller: _nascimentoController,
                  type: DateTimePickerType.date,
                  firstDate: DateTime(1899),
                  lastDate: DateTime(20100),
                  dateLabelText: 'Nascimento',
                  dateMask: 'dd/MM/yyyy',
                  validator: (value) {
                    if (value == null) {
                      return 'Data inválida!';
                    }

                    if (value.isEmpty) {
                      return 'Data inválida!';
                    }

                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      Step(
        title: const Text('Endereço'),
        isActive: cliente.stepAtual >= 1,
        content: SingleChildScrollView(
          child: Form(
            key: _formUserAdderess,
            child: Column(
              children: [
                TextFormField(
                  controller: _cepController,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  decoration: const InputDecoration(labelText: 'Cep'),
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  validator: (value) {
                    if (value != null && value.length != 10) {
                      return 'Cep Inválido!';
                    }

                    return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CepInputFormatter(),
                  ],
                ),
                DropdownButtonFormField(
                  isExpanded: true,
                  decoration: const InputDecoration(
                    labelText: 'Estado',
                  ),
                  items: Estados.listaEstadosSigla
                      .map<DropdownMenuItem<String>>((String estado) {
                    return DropdownMenuItem<String>(
                      child: Text(estado),
                      value: estado,
                    );
                  }).toList(),
                  onChanged: (String? novoEstado) {
                    if (novoEstado != null) {
                      _estadoController.text = novoEstado;
                    }
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Selecione um estado!';
                    }

                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _cidadeController,
                  keyboardType: TextInputType.text,
                  maxLength: 255,
                  decoration: const InputDecoration(labelText: 'Cidade'),
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  validator: (value) {
                    if (value!.length < 3) {
                      return 'Cidade Inválida!';
                    }

                    return null;
                  },
                ),
                TextFormField(
                  controller: _bairroController,
                  keyboardType: TextInputType.text,
                  maxLength: 255,
                  decoration: const InputDecoration(labelText: 'Bairro'),
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  validator: (value) {
                    if (value!.length < 3) {
                      return 'Bairro Inválida!';
                    }

                    return null;
                  },
                ),
                TextFormField(
                  controller: _logradouroController,
                  keyboardType: TextInputType.text,
                  maxLength: 255,
                  decoration: const InputDecoration(labelText: 'Logradouro'),
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  validator: (value) {
                    if (value!.length < 3) {
                      return 'Logradouro Inválido!';
                    }

                    return null;
                  },
                ),
                TextFormField(
                  controller: _numeroController,
                  keyboardType: TextInputType.text,
                  maxLength: 10,
                  decoration: const InputDecoration(labelText: 'Número'),
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      Step(
        title: const Text('Senha'),
        isActive: cliente.stepAtual >= 2,
        content: SingleChildScrollView(
          child: Form(
            key: _formUserAuth,
            child: Column(
              children: [
                TextFormField(
                  controller: _senhaController,
                  keyboardType: TextInputType.text,
                  maxLength: 8,
                  decoration: const InputDecoration(labelText: 'Senha'),
                  obscureText: true,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  validator: (value) {
                    if (value!.length < 8) {
                      return 'senha fraca!';
                    }

                    return null;
                  },
                ),
                TextFormField(
                  controller: _confirmarSenhaController,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  maxLength: 8,
                  decoration:
                      const InputDecoration(labelText: 'Confirmar Senha'),
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  validator: (value) {
                    if (value != _senhaController.text) {
                      return 'senhas não conferem!';
                    }

                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Para prosseguir com seu cadastro é ' +
                      'necessário que tenhamos uma foto de' +
                      ' um documento oficial.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () => _capturarDocumento(cliente),
                    child: const Text('Tirar foto do documento'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                _jaEnviouDocmumento(context)
                    ? _imagemDocumento(context)
                    : _documentoPendente(context),
                Biometria(),
              ],
            ),
          ),
        ),
      ),
    ];

    return step;
  }

  void _proximoStep(context) {
    Cliente cliente = Provider.of<Cliente>(context, listen: false);
    irPara(cliente.stepAtual + 1, cliente);
  }

  void irPara(int step, cliente) {
    cliente.stepAtual = step;
  }

  void _capturarDocumento(cliente) async {
    final pickedImage = await _picker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      cliente.imagemDocumento = File(pickedImage.path);
    }
  }

  bool _jaEnviouDocmumento(context) {
    return Provider.of<Cliente>(context, listen: false).imagemDocumento.path !=
        'assets/images/logo.png';
  }

  Image _imagemDocumento(context) {
    return Image.file(
      Provider.of<Cliente>(context, listen: false).imagemDocumento,
    );
  }

  Text _documentoPendente(context) {
    return Text(
      _jaEnviouDocmumento(context) ? 'Documento' : 'Foto pendente!',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: _jaEnviouDocmumento(context) ? Colors.black : Colors.red,
      ),
    );
  }
}
