import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:digisalad_task/constants/constant.dart';
import 'package:digisalad_task/screens/search_screen.dart';
import 'package:digisalad_task/screens/home_screen.dart';
import 'package:digisalad_task/utils/localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  // Intialize the notification service of the audio player
  AssetsAudioPlayer.setupNotificationsOpenAction((notification) {
    return true;
  });
  // Initialize the persistent storage
  await GetStorage.init();
  final box = GetStorage();

  runApp(GetMaterialApp(
    translations: Localization(),
    // Setup the language of the app
    locale: box.read('lang') ?? Get.deviceLocale,
    fallbackLocale: const Locale('en', 'US'),
    title: 'iTunes Explorer',
    theme: ThemeData(
      fontFamily: 'NanumGothic',
      appBarTheme: const AppBarTheme(
          color: AppColor.appBarColor,
          iconTheme: IconThemeData(color: AppColor.secondaryColor)),
      primaryColor: AppColor.primaryColor,
      colorScheme: ColorScheme.fromSeed(seedColor: AppColor.accentColor),
      useMaterial3: true,
    ),
    themeMode: ThemeMode.light,
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
  ));
}
