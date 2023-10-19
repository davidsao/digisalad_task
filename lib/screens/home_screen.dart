import 'package:digisalad_task/constants/constant.dart';
import 'package:digisalad_task/screens/player_sreen.dart';
import 'package:digisalad_task/screens/widgets/empty_image.dart';
import 'package:digisalad_task/screens/widgets/song_list_item.dart';
import 'package:digisalad_task/utils/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Landing page of the app which shows the search box and search results from the iTunes search
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Initiate the controller for the search text field
  final searchController = TextEditingController();
  // The list for storing the search result after fetching from the iTunes API
  var searchResult = [];
  // Keep track of the loading state (For showing loading indicator)
  var isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('iTunes Explorer'),
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
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                      color: AppColor.cardBackgroundColor,
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      border: Border.all(color: Colors.black12)),
                  child: TextField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search a song from iTunes',
                    ),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.search,
                    // Trigger the search when the user hits the "Return" button
                    onSubmitted: (value) {
                      getSearchResults(value);
                    },
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Expanded(
                    // Widgets for showing
                    // 1. Loading indicator (when loading)
                    // 2. Listview (when the API has response)
                    // 3. Empty image (when the search result is empty)
                    child: isLoading
                        ? spinKit
                        : searchResult.isNotEmpty
                            ? ListView.builder(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                physics: const BouncingScrollPhysics(),
                                itemCount: searchResult.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                      onTap: () =>
                                          openModalPlayer(searchResult[index]),
                                      child: SongListItem(
                                          song: searchResult[index]));
                                })
                            : const EmptyImage(
                                icon: 'assets/empty_search.json',
                                title: 'Add a transaction')),
              ],
            )
          ],
        ),
      ),
    );
  }

  // A function for API call with parameter 'keyword'
  getSearchResults(String keyword) {
    setState(() {
      isLoading = true;
      searchResult = [];
    });

    APIServices().getSearchResult(keyword).then((song) {
      if (song != null) {
        setState(() {
          // Input the result into the searchResult list
          searchResult = song['results'];
          setState(() {
            // Stop showing the loading indicator
            isLoading = false;
          });
        });
      }
    });
  }

  // Open the modal popup music player when a song is selected
  openModalPlayer(song) {
    showCupertinoModalPopup(
        context: context,
        builder: (ctx) {
          return SizedBox(height: 288, child: PlayerScreen(song: song));
        });
  }
}
