import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class Bichos extends StatefulWidget {
  const Bichos({Key? key}) : super(key: key);

  @override
  State<Bichos> createState() => _BichosState();
}

class _BichosState extends State<Bichos> {
  final AudioCache _audioCache = AudioCache(prefix: 'assets/audios/');

  _executarAudio(String audio) async {
    await _audioCache.play(audio + '.mp3');
  }

  @override
  void initState() {
    super.initState();
    _audioCache.loadAll([
      'cao.mp3',
      'gato.mp3',
      'leao.mp3',
      'macaco.mp3',
      'ovelha.mp3',
      'vaca.mp3'
    ]);
  }

  @override
  Widget build(BuildContext context) {
    // media query captura a largura e a altura do dispositivo que esta rodando o app
    // double largura = MediaQuery.of(context).size.width;
    // double altura = MediaQuery.of(context).size.height;

    // Medidas do aparelho que esta rodando o app
    double aspectRatio = MediaQuery.of(context).size.aspectRatio * 2;

    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: aspectRatio,
      children: [
        InkWell(
          onTap: () {
            _executarAudio('cao');
          },
          child: Image.asset('assets/images/cao.png'),
        ),
        InkWell(
          onTap: () {
            _executarAudio('leao');
          },
          child: Image.asset('assets/images/leao.png'),
        ),
        InkWell(
          onTap: () {
            _executarAudio('macaco');
          },
          child: Image.asset('assets/images/macaco.png'),
        ),
        InkWell(
          onTap: () {
            _executarAudio('ovelha');
          },
          child: Image.asset('assets/images/ovelha.png'),
        ),
        InkWell(
          onTap: () {
            _executarAudio('vaca');
          },
          child: Image.asset('assets/images/vaca.png'),
        ),
        InkWell(
          onTap: () {
            _executarAudio('gato');
          },
          child: Image.asset('assets/images/gato.png'),
        ),
      ],
    );
  }
}
