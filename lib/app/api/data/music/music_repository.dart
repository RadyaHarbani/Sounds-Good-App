import 'package:hive/hive.dart';
import 'package:sounds_good_app/app/api/data/music/create_music_request.dart';
import 'package:sounds_good_app/app/api/data/music/update_music_request.dart';
import 'package:sounds_good_app/app/api/service/music/music_service.dart';
import 'music_model.dart';

class MusicRepository {
  final MusicService _service = MusicService();

  Future<List<MusicModel>> getAllMusic() async {
    final List<dynamic> response = await _service.fetchAllMusic();

    final musics = response.map((e) => MusicModel.fromJson(e)).toList();

    final box = Hive.box<MusicModel>('musicBox');
    await box.clear();
    await box.addAll(musics);

    return musics;
  }

  List<MusicModel> getCachedMusic() {
    final box = Hive.box<MusicModel>('musicBox');
    return box.values.toList();
  }

  Future<List<MusicModel>> fetchMyMusic() async {
    final List<dynamic> response = await _service.fetchMyMusic();

    final musics = response.map((e) => MusicModel.fromJson(e)).toList();

    final box = Hive.box<MusicModel>('myMusicBox');
    await box.clear();
    await box.addAll(musics);

    return musics;
  }

  List<MusicModel> getCachedMyMusic() {
    final box = Hive.box<MusicModel>('myMusicBox');
    return box.values.toList();
  }

  Future<MusicModel> createMusic(CreateMusicRequest req) async {
    final data = await _service.createMusic(req);
    final music = MusicModel.fromJson(data);

    final box = Hive.box<MusicModel>('myMusicBox');
    await box.add(music);

    return music;
  }

  Future<MusicModel> updateMusic(String id, UpdateMusicRequest req) async {
    final data = await _service.updateMusic(id, req);
    final updated = MusicModel.fromJson(data);

    final box = Hive.box<MusicModel>('myMusicBox');
    final index = box.values.toList().indexWhere((e) => e.id == id);
    if (index != -1) {
      await box.putAt(index, updated);
    }

    return updated;
  }

  Future<void> deleteMusic(String id) async {
    await _service.deleteMusic(id);

    final box = Hive.box<MusicModel>('myMusicBox');
    final index = box.values.toList().indexWhere((e) => e.id == id);
    if (index != -1) {
      await box.deleteAt(index);
    }
  }
}
