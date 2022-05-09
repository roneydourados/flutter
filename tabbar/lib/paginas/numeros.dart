import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class Numeros extends StatefulWidget {
  const Numeros({Key? key}) : super(key: key);

  @override
  State<Numeros> createState() => _NumerosState();
}

class _NumerosState extends State<Numeros> {
  final AudioCache _audioCache = AudioCache(prefix: 'assets/audios/');

  _executarAudio(String audio) async {
    await _audioCache.play(audio + '.mp3');
  }

  @override
  void initState() {
    super.initState();
    _audioCache.loadAll(['1.mp3', '2.mp3', '3.mp3', '4.mp3', '5.mp3', '6.mp3']);
  }

  @override
  Widget build(BuildContext context) {
    // Medidas do aparelho que esta rodando o app
    double aspectRatio = MediaQuery.of(context).size.aspectRatio * 2;

    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: aspectRatio,
      children: [
        InkWell(
          onTap: () {
            _executarAudio('1');
          },
          child: Image.asset('assets/images/1.png'),
        ),
        InkWell(
          onTap: () {
            _executarAudio('2');
          },
          child: Image.asset('assets/images/2.png'),
        ),
        InkWell(
          onTap: () {
            _executarAudio('3');
          },
          child: Image.asset('assets/images/3.png'),
        ),
        InkWell(
          onTap: () {
            _executarAudio('4');
          },
          child: Image.asset('assets/images/4.png'),
        ),
        InkWell(
          onTap: () {
            _executarAudio('5');
          },
          child: Image.asset('assets/images/5.png'),
        ),
        InkWell(
          onTap: () {
            _executarAudio('6');
          },
          child: Image.asset('assets/images/6.png'),
        ),
      ],
    );
  }
}
