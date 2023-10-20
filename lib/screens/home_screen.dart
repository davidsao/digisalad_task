import 'package:digisalad_task/constants/constant.dart';
import 'package:digisalad_task/screens/player_sreen.dart';
import 'package:digisalad_task/screens/widgets/empty_image.dart';
import 'package:digisalad_task/screens/widgets/song_list_item.dart';
import 'package:digisalad_task/utils/api_services.dart';
import 'package:digisalad_task/utils/check_internet_connection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Landing page of the app which shows the search box and search results from the iTunes search
class HomeScreen extends StatelessWidget {
  // Initiate the controller for the search text field
  final searchController = TextEditingController();
  // The list for storing the search result after fetching from the iTunes API
  var searchResult = [].obs;
  // Keep track of the loading state (For showing loading indicator)
  var isLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('title'.tr),
        centerTitle: true,
        scrolledUnderElevation: 0,
      ),
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                // Search box for entering keywords of the search
                searchBox(),
                const SizedBox(
                  height: 8,
                ),
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
  getSearchResults(String keyword) {
    // Stop showing the loading indicator
    isLoading.value = true;
    // Input the result into the searchResult list
    searchResult.value = [];

    APIServices().getSearchResult(keyword).then((song) {
      if (song != null) {
        // Stop showing the loading indicator
        isLoading.value = false;
        // Input the result into the searchResult list
        searchResult.value = song['results'];
      }
    });
  }

  searchBox() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          color: AppColor.cardBackgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          border: Border.all(color: Colors.black12)),
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
    else if (searchResult.isNotEmpty) {
      return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          physics: const BouncingScrollPhysics(),
          itemCount: searchResult.length,
          itemBuilder: (context, index) {
            return InkWell(
                onTap: () async {
                  // Check if internet connection is ok
                  await checkConnection().then((isConnected) {
                    if (isConnected) {
                      openModalPlayer(searchResult[index]);
                    }
                  });
                },
                child: SongListItem(song: searchResult[index]));
          });
    }
    // Case 3. Empty image (when the search result is empty)
    else {
      return EmptyImage(
          icon: 'assets/empty_search.json', title: 'empty_result_text'.tr);
    }
  }

  // Open the modal popup music player when a song is selected
  openModalPlayer(song) {
    Get.bottomSheet(Container(
      height: 288,
      color: AppColor.backgroundColor,
      child: PlayerScreen(song: song),
    ));
  }
}
