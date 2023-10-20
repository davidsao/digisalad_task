import 'package:digisalad_task/constants/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

// Landing page of the app which shows the search box and search results from the iTunes search
class SettingsScreen extends StatelessWidget {
  // Get the persistent storage
  final box = GetStorage();
  // Choices for language selection
  Map<int, Widget> languageChoices = <int, Widget>{
    0: const Text(" Eng "),
    1: const Text(" 繁中 "),
    2: const Text(" 简中 "),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('nav_bar_settings'.tr),
        centerTitle: true,
        scrolledUnderElevation: 0,
      ),
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 32),
                // Widgets for showing the app information and version number
                TextBox.settingsAppName('title'.tr),
                const SizedBox(height: 4),
                TextBox.listSubtitle('${'version'.tr} 1.0'),
                const SizedBox(height: 16),
                // Widget for showing settings item (language selection)
                Container(
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.symmetric(horizontal: 32, vertical: 4),
                  color: AppColor.cardBackgroundColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          const Spacer(),
                          TextBox.playerSubtitle('settings_lang'.tr),
                          const Spacer(),
                        ],
                      ),
                      SizedBox(
                          width: 240,
                          height: 60,
                          child: CupertinoSegmentedControl<int>(
                            children: languageChoices,
                            onValueChanged: (value) {
                              // Change language to US English
                              if (value == 0) {
                                box.write('lang', const Locale('en','US'));
                                Locale locale = const Locale('en','US');
                                Get.updateLocale(locale);
                                // Change language to Traditional Chinese
                              } else if (value == 1) {
                                box.write('lang', const Locale('zh','TW'));
                                Locale locale = const Locale('zh','TW');
                                Get.updateLocale(locale);
                                // Change language to Simplified Chinese
                              } else if (value == 2) {
                                box.write('lang', const Locale('zh','CN'));
                                Locale locale = const Locale('zh','CN');
                                Get.updateLocale(locale);
                              }
                            },
                            padding: const EdgeInsets.all(0),
                            borderColor: AppColor.primaryColor,
                          )),
                    ],
                  ),
                ),
              ]
          ),
        ),
      ),
    );
  }
}