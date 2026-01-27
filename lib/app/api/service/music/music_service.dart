import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;
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
    print("fetchMyMusic response: ${response.data}");
    return response.data;
  }

  Future<Map<String, dynamic>> createMusic(CreateMusicRequest req) async {
    final formData = FormData.fromMap({
      'song': await MultipartFile.fromFile(
        req.songPath,
        filename: path.basename(req.songPath),
        contentType: MediaType('audio', 'mpeg'),
      ),
      'thumbnail': await MultipartFile.fromFile(
        req.thumbnailPath,
        filename: path.basename(req.thumbnailPath),
        contentType: MediaType('image', 'jpeg'),
      ),
      'artist': req.artist,
      'title': req.title,
    });

    final res = await _dioInstance.postRequest(
      endpoint: ApiEndpoints.uploadSong,
      isAuthorize: true,
      data: formData,
    );

    print("createMusic response: ${res.data}");

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
