import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sounds_good_app/app/api/data/music/music_model.dart';
import 'package:sounds_good_app/app/api/data/music/music_repository.dart';

class SearchPageController extends GetxController {
  final MusicRepository _musicRepo = MusicRepository();
  TextEditingController searchController = TextEditingController();

  final allDefaultMusics = <MusicModel>[].obs;
  final allUserMusics = <MusicModel>[].obs;

  final shownDefaultMusics = <MusicModel>[].obs;
  final shownUserMusics = <MusicModel>[].obs;

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initData();
  }

  Future<void> _initData() async {
    isLoading.value = true;
    try {
      final defaultMusic = await _musicRepo.getAllMusic();
      final userMusic = await _musicRepo.fetchMyMusic();

      allDefaultMusics.assignAll(defaultMusic);
      allUserMusics.assignAll(userMusic);

      shownDefaultMusics.assignAll(defaultMusic);
      shownUserMusics.assignAll(userMusic);
    } catch (e) {
      print('Search init error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void search(String query) {
    if (query.isEmpty) {
      shownDefaultMusics.assignAll(allDefaultMusics);
      shownUserMusics.assignAll(allUserMusics);
      return;
    }

    final q = query.toLowerCase();

    shownDefaultMusics.assignAll(
      allDefaultMusics.where((music) {
        return music.title.toLowerCase().contains(q) ||
            music.artist.toLowerCase().contains(q);
      }),
    );

    shownUserMusics.assignAll(
      allUserMusics.where((music) {
        return music.title.toLowerCase().contains(q) ||
            music.artist.toLowerCase().contains(q);
      }),
    );
  }
}
