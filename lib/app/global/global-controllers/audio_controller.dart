import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/foundation.dart';
import 'package:sounds_good_app/app/api/data/music/music_model.dart';

class AudioController extends GetxController {
  final AudioPlayer player = AudioPlayer();

  final RxBool isPlaying = false.obs;
  final RxBool isLoadingAudio = false.obs;

  final RxString currentTitle = ''.obs;
  final RxString currentArtist = ''.obs;
  final RxString currentThumbnail = ''.obs;
  final RxString currentSongId = ''.obs;

  final RxList<MusicModel> playlist = <MusicModel>[].obs;
  final RxInt currentIndex = 0.obs;

  final RxBool hasActiveAudio = false.obs;

  @override
  void onInit() {
    super.onInit();

    player.playingStream.listen((playing) {
      isPlaying.value = playing;
    });

    player.currentIndexStream.listen((index) {
      if (index == null || index < 0 || index >= playlist.length) return;

      currentIndex.value = index;
      final song = playlist[index];

      currentTitle.value = song.title;
      currentArtist.value = song.artist;
      currentThumbnail.value = song.thumbnailUrl;
      currentSongId.value = song.id;
    });

    player.processingStateStream.listen((state) {
      if (state == ProcessingState.completed && !player.hasNext) {
        resetPlayer();
      }
    });
  }

  Future<void> setPlaylist(List<MusicModel> list, {int startIndex = 0}) async {
    if (list.isEmpty) {
      await resetPlayer();
      return;
    }

    try {
      isLoadingAudio.value = true;
      hasActiveAudio.value = true;

      playlist.assignAll(list);

      final audioSource = ConcatenatingAudioSource(
        children: list
            .map((m) => AudioSource.uri(Uri.parse(m.songUrl)))
            .toList(),
      );

      await player.stop();
      await player.setAudioSource(audioSource, initialIndex: startIndex);
      await player.play();
    } catch (e) {
      debugPrint('SET PLAYLIST ERROR: $e');
    } finally {
      isLoadingAudio.value = false;
    }
  }

  Future<void> togglePlay() async {
    if (player.playing) {
      await player.pause();
    } else {
      await player.play();
    }
  }

  Future<void> playNext() async {
    if (!player.hasNext) return;
    await player.seekToNext();
  }

  Future<void> playPrevious() async {
    if (!player.hasPrevious) return;
    await player.seekToPrevious();
  }

  Future<void> resetPlayer() async {
    await player.stop();

    playlist.clear();
    currentIndex.value = 0;

    currentTitle.value = '';
    currentArtist.value = '';
    currentThumbnail.value = '';

    isPlaying.value = false;
    hasActiveAudio.value = false;
  }

  MusicModel? get currentMusic {
    if (playlist.isEmpty) return null;
    if (currentIndex.value < 0 || currentIndex.value >= playlist.length) {
      return null;
    }
    return playlist[currentIndex.value];
  }

  @override
  void onClose() {
    player.stop();
    player.dispose();
    super.onClose();
  }
}
