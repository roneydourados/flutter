import 'package:flutter/material.dart';
import 'package:youtube/model/video.dart';
import 'package:youtube/api.dart';
// ignore: import_of_legacy_library_into_null_safe
// import 'package:flutter_youtube/flutter_youtube.dart';

class Inicio extends StatefulWidget {
  final String pesquisa;

  const Inicio({
    Key? key,
    required this.pesquisa,
  }) : super(key: key);

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  _listVideos(String pesquisa) {
    Api api = Api();

    return api.search(pesquisa);
  }

  /* ciclo de vida do componente
  @override
  void initState() {
    super.initState();
    // inicio 1
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // quanto tem alguma alteração 2
  }

  @override
  void dispose() {
    super.dispose();

    // quando sair 4
  }
  */

  @override
  // este aqui constroi a estrutura do componente 3
  Widget build(BuildContext context) {
    return FutureBuilder<List<VideoTouTube>>(
      future: _listVideos(widget.pesquisa),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasData) {
              return ListView.separated(
                itemBuilder: (context, index) {
                  List<VideoTouTube>? videos = snapshot.data;
                  VideoTouTube video = videos![index];

                  return GestureDetector(
                    onTap: () {
                      /*
                      FlutterYoutube.playYoutubeVideoById(
                        apiKey: YOUTUBE_API_KEY,
                        videoId: video.id,
                        autoPlay: true,
                        fullScreen: true,
                      );
                      */
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: NetworkImage(video.imagem),
                            fit: BoxFit.cover,
                          )),
                        ),
                        ListTile(
                          title: Text(video.titulo),
                          subtitle: Text(video.canal),
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(
                  height: 3,
                  color: Colors.red,
                ),
                itemCount: snapshot.data!.length,
              );
            } else {
              return const Center(
                child: Text('Oops, nada encontrado!'),
              );
            }
        }
      },
    );
  }
}
