import 'package:dio/dio.dart';
import 'package:sounds_good_app/app/api/api_endpoints.dart';
import 'package:sounds_good_app/app/api/data/music/create_music_request.dart';
import 'package:sounds_good_app/app/api/data/music/update_music_request.dart';
import 'package:sounds_good_app/app/api/dio_instance.dart';

class MusicService {
  final DioInstance _dioInstance = DioInstance();

  Future<List<dynamic>> fetchAllMusic() async {
    final response = await _dioInstance.getRequest(
      endpoint: ApiEndpoints.getAllSongs,
      isAuthorize: true,
    );
    return response.data;
  }

  Future<List<dynamic>> fetchMyMusic() async {
    final response = await _dioInstance.getRequest(
      endpoint: ApiEndpoints.getUserSongs,
      isAuthorize: true,
    );
    return response.data;
  }

  Future<Map<String, dynamic>> createMusic(CreateMusicRequest req) async {
    final formData = FormData.fromMap({
      'title': req.title,
      'artist': req.artist,
      'song': await MultipartFile.fromFile(req.songPath),
      'thumbnail': await MultipartFile.fromFile(req.thumbnailPath),
    });

    final res = await _dioInstance.postRequest(
      endpoint: ApiEndpoints.uploadSong,
      isAuthorize: true,
      data: formData,
    );

    return res.data;
  }

  Future<Map<String, dynamic>> updateMusic(
    String musicId,
    UpdateMusicRequest req,
  ) async {
    final res = await _dioInstance.putRequest(
      endpoint: '${ApiEndpoints.updateSong}/$musicId',
      isAuthorize: true,
      data: req.toJson(),
    );

    return res.data;
  }

  Future<void> deleteMusic(String musicId) async {
    await _dioInstance.deleteRequest(
      endpoint: '${ApiEndpoints.deleteSong}/$musicId',
      isAuthorize: true,
    );
  }
}
