import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:digisalad_task/constants/constant.dart';
import 'package:digisalad_task/screens/widgets/album_art.dart';
import 'package:digisalad_task/screens/widgets/position_seek.dart';
import 'package:flutter/material.dart';

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
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Initiate audio player
    _assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
    // Load the URL of the preview sound track
    _assetsAudioPlayer
        .open(
      Audio.network(widget.song['previewUrl']),
      autoStart: true,
      showNotification: true,
    )
        .then((value) {
      setState(() {
        // Notify that the player is ready and hide the loading indicator
        isLoading = false;
      });
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
      backgroundColor: AppColor.backgroundColor,
      body: Container(
        height: 288,
        padding: const EdgeInsets.only(left: 24, top: 24, bottom: 24),
        width: MediaQuery.of(context).size.width,
        color: AppColor.backgroundColor,
        child: Column(
          children: [
            Row(
              children: [
                AlbumArt(
                    size: 88, imageURL: widget.song['artworkUrl100'] ?? ''),
                const SizedBox(width: 16),
                // Widget of the album art, track name and the artist name
                SizedBox(
                  width: MediaQuery.of(context).size.width - 168,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextBox.playerTitle(widget.song['trackName'] ?? ''),
                      const SizedBox(height: 8),
                      TextBox.playerSubtitle(widget.song['artistName'] ?? ''),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),
            // Show loading indicator when loading, otherwise, show the audio player instead
            isLoading
                ? spinKit
                : _assetsAudioPlayer.builderRealtimePlayingInfos(
                    builder: (context, RealtimePlayingInfos? infos) {
                    return Row(
                      children: [
                        // Define the size of the seek bar
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 128,
                          child: SeekBarWidget(
                            currentPosition: infos!.currentPosition,
                            duration: infos.duration,
                            seekTo: (to) {
                              _assetsAudioPlayer.seek(to);
                            },
                          ),
                        ),
                        // Set the play or pause button
                        IconButton(
                            onPressed: () {
                              _assetsAudioPlayer.playOrPause();
                            },
                            icon: Icon(
                              infos.isPlaying
                                  ? Icons.pause_circle
                                  : Icons.play_circle,
                              color: AppColor.accentColor,
                              size: 72,
                            )),
                      ],
                    );
                  }),
          ],
        ),
      ),
    );
  }
}
