import 'package:digisalad_task/constants/constant.dart';
import 'package:digisalad_task/controllers/fetch_controller.dart';
import 'package:digisalad_task/screens/player_screen.dart';
import 'package:digisalad_task/screens/widgets/empty_image.dart';
import 'package:digisalad_task/screens/widgets/song_list_item.dart';
import 'package:digisalad_task/utils/check_internet_connection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Landing page of the app which shows the search box and search results from the iTunes search
class SearchScreen extends StatelessWidget {
  // Initiate the controller for the search text field
  final searchController = TextEditingController();
  // Keep track of the loading state (For showing loading indicator)
  var isLoading = false.obs;
  // Initiate the controller for fetching api resources
  FetchController controller = Get.put(FetchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 64,
        // Custom toolbar widget with app icon name on the left and icon on the right
        title: Row(
          children: [
            const SizedBox(width: 8),
            Text('title'.tr,
                style: const TextStyle(fontWeight: FontWeight.w700)),
            const Spacer(),
            Image.asset('assets/app_icon.png', width: 48, height: 48),
            const SizedBox(width: 8),
          ],
        ),
        scrolledUnderElevation: 0,
      ),
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 8),
                // Search box for entering keywords of the search
                searchBox(),
                const SizedBox(height: 16),
                Expanded(
                    // The center widget in the page
                    child: Obx(() => mainWidget()))
              ],
            )
          ],
        ),
      ),
    );
  }

  // A function for API call with parameter 'keyword'
  getSearchResults(String keyword) async {
    // Stop showing the loading indicator
    isLoading.value = true;
    // Input the result into the searchResult list
    controller.emptySongList();

    await controller.fetchSongs(keyword).then((value) {
      isLoading.value = false;
    });
  }

  searchBox() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 2),
      decoration: const BoxDecoration(
        color: AppColor.textBoxBackground,
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: const Icon(Icons.search),
          hintText: 'search_text'.tr,
        ),
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.search,
        // Trigger the search when the user hits the "Return" button
        onSubmitted: (value) async {
          // Check internet connection before initiating the API call
          await checkConnection().then((isConnected) {
            if (isConnected) getSearchResults(value);
          });
        },
      ),
    );
  }

  mainWidget() {
    // Case 1. Loading indicator (when doing API call)
    if (isLoading.value) {
      return spinKit;
    }
    // Case 2. Listview (when the API has response)
    return GetBuilder<FetchController>(builder: (_) {
      return controller.songList.isNotEmpty
          ? ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              physics: const BouncingScrollPhysics(),
              itemCount: controller.songList.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: TextBox.listTitle(
                        '${controller.songList.length}${'search_result_count'.tr}'),
                  );
                } else {
                  return InkWell(
                      onTap: () async {
                        // Check if internet connection is ok
                        await checkConnection().then((isConnected) {
                          if (isConnected) {
                            // Open the music player when a song is selected
                            Get.to(PlayerScreen(
                                song: controller.songList[index - 1]!));
                          }
                        });
                      },
                      child: SongListItem(controller.songList[index - 1]!));
                }
              })
          // Case 3. Empty image (when the search result is empty)
          : EmptyImage(
              icon: 'assets/empty_search.json', title: 'empty_result_text'.tr);
    });
  }
}
