import 'package:digisalad_task/controllers/landing_page_controller.dart';
import 'package:digisalad_task/screens/search_screen.dart';
import 'package:digisalad_task/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/constant.dart';

class HomeScreen extends StatelessWidget {
  // Initiate the controller for selected page in the bottom bar
  final LandingPageController landingPageController =
  Get.put(LandingPageController(), permanent: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: buildBottomBar(context, landingPageController),
      backgroundColor: AppColor.backgroundColor,
      body: Obx(() => IndexedStack(
        index: landingPageController.tabIndex.value,
        children: [
          SearchScreen(),
          SettingsScreen(),
        ],
      )),
    );
  }

  buildBottomBar(context, landingPageController) {
    return Obx(() => NavigationBar(
      onDestinationSelected: (value) => landingPageController.changeTabIndex(value),
      selectedIndex: landingPageController.tabIndex.value,
      backgroundColor: AppColor.appBarColor,
      surfaceTintColor: AppColor.appBarColor,
      destinations: [
        NavigationDestination(
          icon: const Icon(Icons.home),
          label: 'nav_bar_home'.tr,
        ),
        NavigationDestination(
            icon: const Icon(Icons.settings),
            label: 'nav_bar_settings'.tr
        )
      ],
    ));
  }
}