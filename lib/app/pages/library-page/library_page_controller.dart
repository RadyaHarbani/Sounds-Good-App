import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sounds_good_app/app/api/data/music/create_music_request.dart';
import 'package:sounds_good_app/app/api/data/music/music_model.dart';
import 'package:sounds_good_app/app/api/data/music/music_repository.dart';

class LibraryPageController extends GetxController {
  final MusicRepository _musicRepo = MusicRepository();

  final userMusics = <MusicModel>[].obs;
  final isLoadingUserMusic = false.obs;

  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final artistController = TextEditingController();

  final isUploading = false.obs;

  final Rx<File?> selectedImage = Rx<File?>(null);
  final Rx<File?> selectedAudio = Rx<File?>(null);

  final ImagePicker _imagePicker = ImagePicker();

  @override
  void onClose() {
    titleController.dispose();
    artistController.dispose();
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

      isUploading.value = true;

      try {
        final req = CreateMusicRequest(
          title: titleController.text,
          artist: artistController.text,
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
  }

  void clearForm() {
    titleController.clear();
    artistController.clear();
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
