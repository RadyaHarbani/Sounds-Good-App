import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:sounds_good_app/app/api/data/music/music_model.dart';

class FavoritePageController extends GetxController {
  final RxList<MusicModel> favorites = <MusicModel>[].obs;
  final RxSet<String> favoriteIds = <String>{}.obs;

  late Box<MusicModel> favoriteMusicBox;
  late Box favoriteIdBox;

  @override
  void onInit() {
    super.onInit();
    favoriteMusicBox = Hive.box<MusicModel>('favoriteMusicBox');
    favoriteIdBox = Hive.box('favoriteBox');

    favorites.assignAll(favoriteMusicBox.values);
    favoriteIds.addAll(favoriteIdBox.keys.cast<String>());
  }

  bool isFavorite(String id) {
    return favoriteIds.contains(id);
  }

  Future<void> toggleFavorite(MusicModel music) async {
    final id = music.id;

    if (favoriteIds.contains(id)) {
      await favoriteIdBox.delete(id);
      await favoriteMusicBox.delete(id);

      favoriteIds.remove(id);
      favorites.removeWhere((m) => m.id == id);
    } else {
      final newMusic = music.copyWith();

      await favoriteIdBox.put(id, true);
      await favoriteMusicBox.put(id, newMusic);

      favoriteIds.add(id);
      favorites.add(newMusic);
    }
  }

  void clear() {
    favorites.clear();
    favoriteIdBox.clear();
    favoriteMusicBox.clear();
  }
}
