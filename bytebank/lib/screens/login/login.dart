import 'package:brasil_fields/brasil_fields.dart';
import 'package:bytebank/components/mensagem.dart';
import 'package:bytebank/screens/login/registrar.dart';
import 'package:flutter/material.dart';
import 'package:bytebank/screens/dashboard/dashboard.dart';
import 'package:flutter/services.dart';
import 'package:flux_validator_dart/flux_validator_dart.dart';

const _FacaSeuLogin = 'Faça seu login';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _controladorCampoCPF = TextEditingController();
  final TextEditingController _controladorCampoSenha = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Color backColor = Theme.of(context).colorScheme.secondary;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 200,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 350,
                  height: 500,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: _construirFormulario(context),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      backgroundColor: backColor,
    );
  }

  Widget _construirFormulario(context) {
    final Color backColor = Theme.of(context).colorScheme.secondary;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const Text(
            _FacaSeuLogin,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'informe seu CPF'),
            style: const TextStyle(fontSize: 20.0),
            maxLength: 14,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CpfInputFormatter(),
            ],
            keyboardType: TextInputType.number,
            controller: _controladorCampoCPF,
            validator: (value) => Validator.cpf(value) ? 'CPF Inválido' : null,
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Senha'),
            style: const TextStyle(fontSize: 20.0),
            controller: _controladorCampoSenha,
            keyboardType: TextInputType.text,
            obscureText: true,
            maxLength: 15,
            validator: (value) {
              if (value!.length < 6) {
                return 'Senha inválida!';
              }

              return null;
            },
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                // shape: StadiumBorder(), aqui deixa botão redondo
                side: BorderSide(
                  color: backColor,
                  width: 2,
                ),
              ),
              onPressed: () => {
                if (_formKey.currentState!.validate())
                  {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Dashboard(),
                      ),
                      (route) => false,
                    )
                  }
                else
                  {
                    exibirAlerta(
                      context: context,
                      titulo: 'ATENÇÃO',
                      content: 'Dados para login inválidos!',
                    )
                  }
              },
              child: Text(
                'CONTINUAR',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: backColor,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Esqueci minha senha >',
            style: TextStyle(
              color: backColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            width: 200,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                // shape: StadiumBorder(), aqui deixa botão redondo
                side: BorderSide(
                  color: backColor,
                  width: 1.5,
                ),
              ),
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Registrar(),
                  ),
                )
              },
              child: Text(
                'Criar conta >',
                style: TextStyle(
                  fontSize: 16,
                  color: backColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
