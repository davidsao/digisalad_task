import 'package:digisalad_task/constants/constant.dart';
import 'package:digisalad_task/screens/widgets/album_art.dart';
import 'package:flutter/material.dart';

// Widget of the items in the search song list result
class SongListItem extends StatefulWidget {
  const SongListItem({Key? key, required this.song}) : super(key: key);

  final dynamic song;

  @override
  State<SongListItem> createState() => _SongListItemState();
}

class _SongListItemState extends State<SongListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 104,
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: AppColor.cardBackgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            border: Border.all(color: AppColor.textInputColor.withAlpha(30))),
        child: Row(
          children: [
            AlbumArt(size: 80, imageURL: widget.song['artworkUrl100'] ?? ''),
            const SizedBox(width: 16),
            SizedBox(
              width: MediaQuery.of(context).size.width - 160,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextBox.listTitle(widget.song['trackName'] ?? ''),
                  TextBox.listSubtitle(widget.song['collectionName'] ?? ''),
                  const SizedBox(height: 8),
                  TextBox.listSubtitle(widget.song['artistName'] ?? ''),
                ],
              ),
            ),
            const Spacer(),
          ],
        ));
  }
}
