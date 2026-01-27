class UpdateMusicRequest {
  final String title;
  final String artist;

  UpdateMusicRequest({
    required this.title,
    required this.artist,
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'artist': artist,
  };
}