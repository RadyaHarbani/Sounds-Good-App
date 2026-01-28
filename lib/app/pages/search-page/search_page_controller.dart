import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sounds_good_app/app/api/data/music/music_model.dart';
import 'package:sounds_good_app/app/api/data/music/music_repository.dart';
import 'package:sounds_good_app/app/pages/favorite-page/favorite_page_controller.dart';
import 'package:sounds_good_app/app/pages/library-page/library_page_controller.dart';

class SearchPageController extends GetxController {
  final FavoritePageController favoriteController =
      Get.find<FavoritePageController>();
  final LibraryPageController libraryController =
      Get.find<LibraryPageController>();

  final MusicRepository _musicRepo = MusicRepository();
  TextEditingController searchController = TextEditingController();

  final allDefaultMusics = <MusicModel>[].obs;
  final allUserMusics = <MusicModel>[].obs;

  final shownDefaultMusics = <MusicModel>[].obs;
  final shownUserMusics = <MusicModel>[].obs;

  final allFavoriteMusics = <MusicModel>[].obs;
  final shownFavoriteMusics = <MusicModel>[].obs;

  final isLoading = false.obs;
  final isSearching = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initData();

    ever<List<MusicModel>>(favoriteController.favorites, (fav) {
      allFavoriteMusics.assignAll(fav);
      if (!isSearching.value) {
        shownFavoriteMusics.assignAll(fav);
      }
    });

    ever<List<MusicModel>>(libraryController.userMusics, (list) {
      allUserMusics.assignAll(list);

      if (!isSearching.value) {
        shownUserMusics.assignAll(list);
      } else {
        search(searchController.text);
      }
    });
  }

  Future<void> _initData() async {
    isLoading.value = true;
    try {
      final defaultMusic = await _musicRepo.getAllMusic();
      final userMusic = await _musicRepo.fetchMyMusic();

      allDefaultMusics.assignAll(defaultMusic);
      allUserMusics.assignAll(userMusic);
      allFavoriteMusics.assignAll(favoriteController.favorites);

      shownDefaultMusics.assignAll(defaultMusic);
      shownUserMusics.assignAll(userMusic);
      shownFavoriteMusics.assignAll(allFavoriteMusics);
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
    isSearching.value = true;

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

    shownFavoriteMusics.assignAll(
      allFavoriteMusics.where(
        (music) =>
            music.title.toLowerCase().contains(q) ||
            music.artist.toLowerCase().contains(q),
      ),
    );
  }
}
