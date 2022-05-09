class VideoTouTube {
  final String id;
  final String titulo;
  final String descricao;
  final String imagem;
  final String canal;

  const VideoTouTube({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.imagem,
    required this.canal,
  });

  factory VideoTouTube.fromJson(Map<String, dynamic> json) {
    return VideoTouTube(
      id: json["id"]["videoId"],
      titulo: json["snippet"]["title"],
      imagem: json["snippet"]["thumbnails"]["high"]["url"],
      canal: json["snippet"]["channelId"],
      descricao: json["snippet"]["description"],
    );
  }
}
