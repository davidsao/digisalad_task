import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:digisalad_task/constants/constant.dart';
import 'package:digisalad_task/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  // Intialize the notification service of the audio player
  AssetsAudioPlayer.setupNotificationsOpenAction((notification) {
    return true;
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: const HomeScreen(),
    );
  }
}
