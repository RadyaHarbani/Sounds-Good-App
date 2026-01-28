import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:sounds_good_app/app/api/data/music/music_model.dart';
import 'package:sounds_good_app/app/api/data/music/music_repository.dart';
import 'package:sounds_good_app/app/api/data/user/user_model.dart';
import 'package:sounds_good_app/app/api/data/user/user_repository.dart';
import 'package:sounds_good_app/app/global/global-controllers/audio_controller.dart';
import 'package:sounds_good_app/app/pages/favorite-page/favorite_page_controller.dart';
import 'package:sounds_good_app/app/pages/library-page/library_page_controller.dart';
import 'package:sounds_good_app/common/routes/app_pages.dart';

class HomePageController extends GetxController {
  final LibraryPageController libraryController =
      Get.find<LibraryPageController>();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final UserRepository _userRepo = UserRepository();
  final user = Rxn<UserModel>();

  final MusicRepository _musicRepo = MusicRepository();
  final musics = <MusicModel>[].obs;
  final isLoadingMusic = false.obs;
  final isLoadingLogout = false.obs;

  final isDrawerOpen = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCurrentUser();
    fetchMusic();
  }

  Future<void> fetchCurrentUser() async {
    user.value = await _userRepo.getCurrentUser();
  }

  Future<void> fetchMusic() async {
    isLoadingMusic.value = true;
    try {
      musics.value = await _musicRepo.getAllMusic();
    } catch (_) {
      musics.value = _musicRepo.getCachedMusic();
    }
    isLoadingMusic.value = false;
  }

  Future<void> logout() async {
    isLoadingLogout.value = true;

    if (Get.isRegistered<AudioController>()) {
      final audio = Get.find<AudioController>();
      await audio.player.stop();
      audio.player.dispose();
      Get.delete<AudioController>(force: true);
    }

    Get.find<FavoritePageController>().clear();

    final authBox = Hive.box('authBox');
    await authBox.clear();

    Get.offAllNamed(Routes.ONBOARDING_PAGE);

    isLoadingLogout.value = false;
  }

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }
}
