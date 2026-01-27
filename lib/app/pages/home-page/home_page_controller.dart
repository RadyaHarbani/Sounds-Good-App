import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sounds_good_app/app/api/data/music/music_model.dart';
import 'package:sounds_good_app/app/api/data/music/music_repository.dart';
import 'package:sounds_good_app/app/api/data/user/user_model.dart';
import 'package:sounds_good_app/app/api/data/user/user_repository.dart';

class HomePageController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final UserRepository _userRepo = UserRepository();
  final user = Rxn<UserModel>();

  final MusicRepository _musicRepo = MusicRepository();
  final musics = <MusicModel>[].obs;
  final isLoading = false.obs;

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
    isLoading.value = true;
    try {
      musics.value = await _musicRepo.getAllMusic();
    } catch (_) {
      musics.value = _musicRepo.getCachedMusic();
    }
    isLoading.value = false;
  }

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }
}
