// ignore_for_file: constant_identifier_names
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:youtube/model/video.dart';

const YOUTUBE_API_KEY = 'AIzaSyBs0zVWFV5uQzvcza9DO50rh6HGgzFBUec';
const YOUTUBE_CHANNEL_ID = 'UCSfwM5u0Kce6Cce8_S72olg';
const BASE_URL = 'https://www.googleapis.com/youtube/v3/';

class Api {
  Future<List<VideoTouTube>> search(String query) async {
    String urlSearch = BASE_URL +
        'search' +
        '?part=snippet' +
        '&type=video' +
        '&maxResults=20' +
        '&order=date' +
        '&key=$YOUTUBE_API_KEY' +
        '&channelId=$YOUTUBE_CHANNEL_ID' +
        '&q=$query';

    Uri url = Uri.parse(urlSearch);

    final response = await http.get(url);

    final List<VideoTouTube> videos;

    if (response.statusCode == 200) {
      Map<String, dynamic> dadosJson = json.decode(response.body);

      videos = dadosJson["items"].map<VideoTouTube>(
        (map) {
          return VideoTouTube.fromJson(map);
        },
      ).toList();

      /*
      for (var video in videos) {
        print('Título: ' + video.titulo);
      }
      */
    } else {
      throw Exception('Falha ao carregar vídeos.');
    }

    return videos;
  }
}
