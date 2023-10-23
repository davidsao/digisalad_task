import 'dart:convert';

List<SongDataModel> songModelFromJson(String str) {
  Map<String, dynamic> data = jsonDecode(str);
  return List<SongDataModel>.from(
      data["results"].map((x) => SongDataModel.fromJson(x)));
}

String songModelToJson(List<SongDataModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SongDataModel {
  SongDataModel(
      {required this.name,
      required this.artist,
      required this.album,
      required this.albumArtSmall,
      required this.albumArt,
      required this.preview,
      required this.favorite});

  String name;
  String artist;
  String album;
  String albumArtSmall;
  String albumArt;
  String preview;
  bool favorite;

  factory SongDataModel.fromJson(Map<String, dynamic> json) => SongDataModel(
        name: json["trackName"] ?? '',
        artist: json["artistName"] ?? '',
        album: json["collectionName"] ?? '',
        albumArtSmall: json["artworkUrl60"] ?? '',
        albumArt: json["artworkUrl100"] ?? '',
        preview: json["previewUrl"] ?? '',
        favorite: false,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "artist": artist,
        "album": album,
        'albumArtSmall': albumArtSmall,
        "albumArt": albumArt,
        "preview": preview,
        "favorite": favorite,
      };
}
