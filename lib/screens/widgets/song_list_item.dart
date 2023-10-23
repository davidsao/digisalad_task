import 'package:digisalad_task/constants/constant.dart';
import 'package:digisalad_task/data_models/song_data_model.dart';
import 'package:digisalad_task/screens/widgets/album_art.dart';
import 'package:flutter/material.dart';

// Widget of the items in the search song list result
class SongListItem extends StatelessWidget {
  SongListItem(this.song);
  // Passing song information from the listview builder
  final SongDataModel song;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 104,
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            AlbumArt(size: 80, imageURL: song.albumArtSmall, isPlayer: false),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextBox.listTitle(song.name),
                  TextBox.listSubtitle(song.album),
                  const SizedBox(height: 8),
                  TextBox.listSubtitle(song.artist),
                ],
              ),
            ),
            const Icon(Icons.play_circle_fill_rounded,
                size: 40, color: AppColor.primaryColor),
            const SizedBox(width: 8),
          ],
        ));
  }
}
