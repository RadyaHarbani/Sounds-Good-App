import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sounds_good_app/app/api/data/music/music_model.dart';
import 'package:sounds_good_app/app/api/data/user/user_model.dart';
import 'package:sounds_good_app/common/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(MusicModelAdapter());
  await Hive.openBox('authBox');
  await Hive.openBox<UserModel>('userBox');
  await Hive.openBox<MusicModel>('musicBox');
  await Hive.openBox<MusicModel>('myMusicBox');
  await Hive.openBox('favoriteBox');
  await Hive.openBox<MusicModel>('favoriteMusicBox');

  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    ),
  );
}
