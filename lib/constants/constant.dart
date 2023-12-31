import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// Color of the components in the app
class AppColor {
  static const Color primaryColor = Color(0xFF7C73F6);
  static const Color textBoxBackground = Color(0xFFF3F3FF);
  static const Color secondaryColor = Color(0xFF7C73F6);
  static const Color backgroundColor = Color(0xFFFFFFFF);
  static const Color appBarColor = Color(0xFFFFFFFF);
  static const Color shadowColor = Color(0x40000000);
  static const Color cardBackgroundColor = Color(0xFFFFFFFF);
  static const Color cardBorderColor = Color(0xFFFFFFFF);
  static const Color imageBGColor = Color(0xFFCCCCCC);
  static const Color textInputColor = Color(0xFF555555);
  static const Color accentColor = Color(0xFF4D5FFF);
  static const Color errorColor = Color(0xFF8F2525);
}

// Text box style for the app
class TextBox {
  // Text widget for listview title
  static Text listTitle(content) {
    return Text(
      content,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  // Text widget for listview subtitle
  static Text listSubtitle(content) {
    return Text(
      content,
      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  // Text widget for the song name in the audio player
  static Text playerTitle(content) {
    return Text(
      content,
      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  // Text widget for the artist name in the audio player
  static Text playerSubtitle(content) {
    return Text(
      content,
      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  // Text widget for app name in settings page
  static Text settingsAppName(content) {
    return Text(
      content,
      style: const TextStyle(
          fontSize: 27,
          fontWeight: FontWeight.w700,
          color: AppColor.primaryColor),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

ButtonStyle buttonStyle() {
  return ButtonStyle(
    elevation: MaterialStateProperty.all(0),
    textStyle:
        MaterialStateProperty.all<TextStyle>(const TextStyle(fontSize: 16)),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}

// Formatting numbers to 2-digit strings
String durationToString(Duration duration) {
  String twoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
  }

  final twoDigitMinutes =
      twoDigits(duration.inMinutes.remainder(Duration.minutesPerHour));
  final twoDigitSeconds =
      twoDigits(duration.inSeconds.remainder(Duration.secondsPerMinute));
  return '$twoDigitMinutes:$twoDigitSeconds';
}

// Widget for loading indicator
const spinKit = SpinKitWave(
  color: AppColor.accentColor,
  size: 50.0,
);
