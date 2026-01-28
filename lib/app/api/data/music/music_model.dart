import 'package:hive/hive.dart';

part 'music_model.g.dart';

@HiveType(typeId: 1)
class MusicModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String artist;

  @HiveField(3)
  final String songUrl;

  @HiveField(4)
  final String thumbnailUrl;

  @HiveField(5)
  final String userId;

  @HiveField(6)
  final DateTime? lastPlayedAt;

  MusicModel({
    required this.id,
    required this.title,
    required this.artist,
    required this.songUrl,
    required this.thumbnailUrl,
    required this.userId,
    this.lastPlayedAt,
  });

  MusicModel copyWith({String? title, String? artist, DateTime? lastPlayedAt,}) {
    return MusicModel(
      id: id,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      songUrl: songUrl,
      thumbnailUrl: thumbnailUrl,
      userId: userId,
      lastPlayedAt: lastPlayedAt ?? this.lastPlayedAt,
    );
  }

  factory MusicModel.fromJson(Map<String, dynamic> json) {
    final rawThumb = json['thumbnail_url'];

    String safeThumbnail = '';
    if (rawThumb != null &&
        rawThumb.toString().isNotEmpty &&
        rawThumb.toString() != 'null') {
      safeThumbnail = rawThumb.toString();

      if (safeThumbnail.startsWith('http://')) {
        safeThumbnail = safeThumbnail.replaceFirst('http://', 'https://');
      }

      if (safeThumbnail.startsWith('/')) {
        safeThumbnail = 'https://res.cloudinary.com/dhu5ttigh$safeThumbnail';
      }
    }

    return MusicModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      artist: json['artist'] ?? '',
      songUrl: json['song_url'] ?? '',
      thumbnailUrl: safeThumbnail,
      userId: json['user_id']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "artist": artist,
      "song_url": songUrl,
      "thumbnail_url": thumbnailUrl,
      "user_id": userId,
    };
  }
}
