class CreateMusicRequest {
  final String title;
  final String artist;
  final String songPath;
  final String thumbnailPath;

  CreateMusicRequest({
    required this.title,
    required this.artist,
    required this.songPath,
    required this.thumbnailPath,
  });
}