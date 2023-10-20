import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:digisalad_task/constants/constant.dart';
import 'package:digisalad_task/controllers/fetch_controller.dart';
import 'package:digisalad_task/screens/widgets/album_art.dart';
import 'package:digisalad_task/screens/widgets/position_seek.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// The bottom modal popup player for the selected song
class PlayerScreen extends StatefulWidget {
  const PlayerScreen({Key? key, this.song}) : super(key: key);
  // Pass in the JSON dictionary (Song info)
  final dynamic song;

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  // Asset Audio Player for streaming music
  late AssetsAudioPlayer _assetsAudioPlayer;
  // Show loading indicator when buffering
  final isLoading = true.obs;
  // Initiate the controller for fetching api resources
  FetchController controller = Get.put(FetchController());

  @override
  void initState() {
    super.initState();
    // Initiate audio player
    _assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
    // Load the URL of the preview sound track
    _assetsAudioPlayer.open(
      Audio.network(
        widget.song['previewUrl'],
        metas: Metas(
          title:  widget.song['trackName'] ?? '',
          artist: widget.song['artistName'] ?? '',
          album: widget.song['collectionName'] ?? '',
          image: MetasImage.network(widget.song['artworkUrl100'] ?? ''), //can be MetasImage.network
        )
      ),
      autoStart: true,
      showNotification: true,
    )
        .then((value) {
      isLoading.value = false;
    });
  }

  @override
  void dispose() {
    // Stop the audio player after leaving the player screen
    _assetsAudioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('player_title'.tr),
        centerTitle: true,
        scrolledUnderElevation: 0
      ),
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
         child: SingleChildScrollView(
           child: Container(
               color: AppColor.backgroundColor,
               padding: const EdgeInsets.all(16),
               child: Column(
                   crossAxisAlignment: CrossAxisAlignment.center,
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     AlbumArt(
                         size: 150, imageURL: widget.song['artworkUrl100'] ?? ''),
                     const SizedBox(height: 16),
                     TextBox.playerTitle(widget.song['trackName'] ?? ''),
                     const SizedBox(height: 8),
                     TextBox.playerSubtitle(widget.song['artistName'] ?? ''),
                     const SizedBox(height: 8),
                     TextBox.playerSubtitle(widget.song['collectionName'] ?? ''),
                     // Show loading indicator when loading, otherwise, show the audio player instead
                     Obx(() => isLoading.isTrue ? spinKit
                         : playerControl()),
                   ])
           ),
         )
    )
    );
  }

  playerControl() {
    return _assetsAudioPlayer.builderRealtimePlayingInfos(
        builder: (context, RealtimePlayingInfos? infos) {
          return SizedBox(
            width: Get.width,
            height: 172,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Set the play or pause button
                IconButton(
                    onPressed: () {
                      _assetsAudioPlayer.playOrPause();
                    },
                    icon: Icon(
                      infos!.isPlaying
                          ? Icons.pause_circle
                          : Icons.play_circle,
                      color: AppColor.accentColor,
                      size: 88,
                    )),
                // Define the size of the seek bar
                SeekBarWidget(
                  currentPosition: infos!.currentPosition,
                  duration: infos.duration,
                  seekTo: (to) {
                    _assetsAudioPlayer.seek(to);
                  },
                ),
              ],
            ),
          );
        });
  }
}
