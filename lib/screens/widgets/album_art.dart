import 'package:cached_network_image/cached_network_image.dart';
import 'package:digisalad_task/constants/constant.dart';
import 'package:flutter/material.dart';

// Format the pictures of the album art
class AlbumArt extends StatefulWidget {
  const AlbumArt({Key? key, required this.size, required this.imageURL})
      : super(key: key);
  // Pass in the size of the output widget and the URL of the image
  final double size;
  final String imageURL;

  @override
  State<AlbumArt> createState() => _AlbumArtState();
}

class _AlbumArtState extends State<AlbumArt> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      // Set the Rounded corner of the image
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(widget.size / 12)),
        child: Container(
          color: AppColor.imageBGColor,
          // Cache the network image for later use
          child: CachedNetworkImage(
            imageUrl: widget.imageURL,
            fit: BoxFit.fitWidth,
            // Display an error icon when nothing is loaded
            errorWidget: (context, url, error) => const Icon(Icons.warning),
          ),
        ),
      ),
    );
  }
}
