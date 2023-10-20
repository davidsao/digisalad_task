import 'package:digisalad_task/constants/constant.dart';
import 'package:digisalad_task/screens/widgets/album_art.dart';
import 'package:flutter/material.dart';

// Widget of the items in the search song list result
class SongListItem extends StatelessWidget {
  SongListItem(this.song);
  // Passing song information from the listview builder
  final dynamic song;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 104,
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(8),
        // Card decoration with rounded corners and border
        decoration: BoxDecoration(
            color: AppColor.cardBackgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            border: Border.all(color: AppColor.textInputColor.withAlpha(30))),
        child: Row(
          children: [
            AlbumArt(size: 80, imageURL: song['artworkUrl100'] ?? ''),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextBox.listTitle(song['trackName'] ?? ''),
                  TextBox.listSubtitle(song['collectionName'] ?? ''),
                  const SizedBox(height: 8),
                  TextBox.listSubtitle(song['artistName'] ?? ''),
                ],
              ),
            ),
          ],
        ));
  }
}
