import 'package:digisalad_task/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

// Landing page of the app which shows the search box and search results from the iTunes search
class SettingsScreen extends StatelessWidget {
  // Get the persistent storage
  final box = GetStorage();
  // Language Options available to choose
  Map<String, Locale> languageChoices = <String, Locale>{
    'English': const Locale('en', 'US'),
    '繁體中文': const Locale('zh', 'TW'),
    '简体中文': const Locale('zh', 'CN')
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('nav_bar_settings'.tr,
            style: const TextStyle(fontWeight: FontWeight.w700)),
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
                  padding: const EdgeInsets.all(24),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 4),
                  decoration: BoxDecoration(
                      color: AppColor.textBoxBackground,
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: [
                            const Spacer(),
                            TextBox.playerSubtitle('settings_lang'.tr),
                            const Spacer(),
                          ],
                        ),
                        const SizedBox(height: 16),
                        for (var item in languageChoices.keys)
                          Container(
                            width: 200,
                            height: 48,
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            child: FilledButton(
                              style: buttonStyle(),
                              onPressed: () {
                                box.write('lang', languageChoices[item]);
                                Locale locale = languageChoices[item]!;
                                Get.updateLocale(locale);
                              },
                              child: Text(item),
                            ),
                          )
                      ]

                      // [
                      //   Row(
                      //     children: [
                      //       const Spacer(),
                      //       TextBox.playerSubtitle('settings_lang'.tr),
                      //       const Spacer(),
                      //     ],
                      //   ),
                      //   const SizedBox(height: 16),
                      //   // Change language to US English
                      //   SizedBox(
                      //     width: 200,
                      //     height: 48,
                      //     child: FilledButton(
                      //       style: buttonStyle(),
                      //       onPressed: () {
                      //         box.write('lang', const Locale('en', 'US'));
                      //         Locale locale = const Locale('en', 'US');
                      //         Get.updateLocale(locale);
                      //       },
                      //       child: const Text('English'),
                      //     ),
                      //   ),
                      //   const SizedBox(height: 8),
                      //   // Change language to Traditional Chinese
                      //   SizedBox(
                      //     width: 200,
                      //     height: 48,
                      //     child: FilledButton(
                      //       style: buttonStyle(),
                      //       onPressed: () {
                      //         box.write('lang', const Locale('zh', 'TW'));
                      //         Locale locale = const Locale('zh', 'TW');
                      //         Get.updateLocale(locale);
                      //       },
                      //       child: const Text('繁體中文'),
                      //     ),
                      //   ),
                      //   const SizedBox(height: 8),
                      //   // Change language to Simplified Chinese
                      //   SizedBox(
                      //     width: 200,
                      //     height: 48,
                      //     child: FilledButton(
                      //       style: buttonStyle(),
                      //       onPressed: () {
                      //         box.write('lang', const Locale('zh', 'CN'));
                      //         Locale locale = const Locale('zh', 'CN');
                      //         Get.updateLocale(locale);
                      //       },
                      //       child: const Text('简体中文'),
                      //     ),
                      //   ),
                      // ],
                      ),
                ),
              ]),
        ),
      ),
    );
  }
}
