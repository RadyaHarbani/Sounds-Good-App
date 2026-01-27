import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sounds_good_app/app/api/data/music/create_music_request.dart';
import 'package:sounds_good_app/app/api/data/music/music_model.dart';
import 'package:sounds_good_app/app/api/data/music/music_repository.dart';
import 'package:sounds_good_app/app/api/data/music/update_music_request.dart';
import 'package:sounds_good_app/app/global/global-controllers/audio_controller.dart';

class LibraryPageController extends GetxController {
  final AudioController audioController = Get.find<AudioController>();
  final MusicRepository _musicRepo = MusicRepository();

  final userMusics = <MusicModel>[].obs;
  final isLoadingUserMusic = false.obs;

  final formKey = GlobalKey<FormState>();
  final titleUploadController = TextEditingController();
  final artistUploadController = TextEditingController();

  final isUploading = false.obs;

  final Rx<File?> selectedImage = Rx<File?>(null);
  final Rx<File?> selectedAudio = Rx<File?>(null);

  final ImagePicker _imagePicker = ImagePicker();

  final titleUpdateController = TextEditingController();
  final artistUpdateController = TextEditingController();

  final isUpdating = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserMusic();
  }

  @override
  void onClose() {
    titleUploadController.dispose();
    artistUploadController.dispose();

    titleUpdateController.dispose();
    artistUpdateController.dispose();
    super.onClose();
  }

  Future<void> addUserMusic() async {
    if (!formKey.currentState!.validate()) return;

    if (selectedImage.value == null || selectedAudio.value == null) {
      Get.snackbar('Failed to add music', 'Cover image & audio wajib dipilih');
      return;
    }

    final audioFile = selectedAudio.value!;
    final sizeInMB = audioFile.lengthSync() / (1024 * 1024);

    if (sizeInMB > 10) {
      Get.snackbar(
        'Audio terlalu besar',
        'Ukuran ${sizeInMB.toStringAsFixed(2)} MB (maks 10 MB)',
      );
    }

    isUploading.value = true;

    try {
      final req = CreateMusicRequest(
        title: titleUploadController.text,
        artist: artistUploadController.text,
        songPath: selectedAudio.value!.path,
        thumbnailPath: selectedImage.value!.path,
      );

      await _musicRepo.createMusic(req);

      Get.back();
      fetchUserMusic();

      Get.snackbar('Success', 'Music berhasil ditambahkan');
      clearForm();
    } catch (e) {
      print(e);

      Get.snackbar('Error', 'Gagal upload music');
    } finally {
      isUploading.value = false;
    }
  }

  void clearForm() {
    titleUploadController.clear();
    artistUploadController.clear();
    titleUpdateController.clear();
    artistUpdateController.clear();
    selectedImage.value = null;
    selectedAudio.value = null;
  }

  Future<void> pickImage() async {
    final XFile? image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image != null) {
      selectedImage.value = File(image.path);
    }
  }

  Future<void> pickAudio() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3', 'wav', 'm4a', 'aac', 'flac'],
    );

    if (result == null || result.files.single.path == null) return;

    final file = File(result.files.single.path!);
    final sizeInMB = file.lengthSync() / (1024 * 1024);

    if (sizeInMB > 10) {
      Get.snackbar(
        'Audio terlalu besar',
        'Ukuran ${sizeInMB.toStringAsFixed(2)} MB (maks 10 MB)',
      );
      return;
    }

    selectedAudio.value = file;
  }

  Future<void> deleteUserMusic(String musicId) async {
    try {
      final deletedIndex = userMusics.indexWhere(
        (music) => music.id == musicId,
      );

      await _musicRepo.deleteMusic(musicId);

      userMusics.removeAt(deletedIndex);

      if (userMusics.isEmpty) {
        await audioController.resetPlayer();
      } else {
        await audioController.setPlaylist(
          userMusics,
          startIndex: deletedIndex > 0 ? deletedIndex - 1 : 0,
        );
      }

      Get.back();
      Get.snackbar('Success', 'Music berhasil dihapus');
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar('Error', 'Gagal menghapus music');
    }
  }

  Future<void> updateUserMusic(
    String musicId,
    String title,
    String artist,
  ) async {
    isLoadingUserMusic.value = true;
    try {
      await _musicRepo.updateMusic(
        musicId,
        UpdateMusicRequest(title: title, artist: artist),
      );
      fetchUserMusic();
      Get.back();
      isLoadingUserMusic.value = false;
      Get.snackbar('Success', 'Music berhasil diperbarui');
      clearForm();
    } catch (e) {
      print(e);
      isLoadingUserMusic.value = false;
      Get.snackbar('Error', 'Gagal memperbarui music');
    } finally {
      isLoadingUserMusic.value = false;
    }
  }

  Future<void> fetchUserMusic() async {
    isLoadingUserMusic.value = true;
    try {
      userMusics.value = await _musicRepo.fetchMyMusic();
    } catch (_) {
      userMusics.value = _musicRepo.getCachedMyMusic();
    } finally {
      isLoadingUserMusic.value = false;
    }
  }
}
