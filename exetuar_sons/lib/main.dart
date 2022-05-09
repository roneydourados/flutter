import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() => runApp(
      const MaterialApp(
        home: Home(),
      ),
    );

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AudioCache playerCache = AudioCache(prefix: 'assets/audios/');
  AudioPlayer audioPlayer = AudioPlayer();
  bool firstExecution = true;
  double _volume = 0.5;

  _playCache() async {
    if (firstExecution) {
      audioPlayer.setVolume(_volume);
      audioPlayer = await playerCache.play('som.mp3');
      firstExecution = false;
    } else {
      await audioPlayer.resume();
    }
  }

  _stop() async {
    await audioPlayer.stop();
    firstExecution = true;
  }

  _pause() async {
    await audioPlayer.pause();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Executando cons'),
      ),
      body: Column(
        children: [
          Slider(
            value: _volume,
            min: 0,
            max: 1,
            // divisions: 10,
            onChanged: (newVolume) {
              setState(() {
                _volume = newVolume;
              });

              audioPlayer.setVolume(newVolume);
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: GestureDetector(
                  onTap: () {
                    _playCache();
                  },
                  child: Image.asset('assets/images/executar.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: GestureDetector(
                  onTap: () {
                    _pause();
                  },
                  child: Image.asset('assets/images/pausar.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: GestureDetector(
                  onTap: () {
                    _stop();
                  },
                  child: Image.asset('assets/images/parar.png'),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
