import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:digisalad_task/constants/constant.dart';
import 'package:digisalad_task/controllers/fetch_controller.dart';
import 'package:digisalad_task/screens/widgets/album_art.dart';
import 'package:digisalad_task/screens/widgets/position_seek.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data_models/song_data_model.dart';

// The bottom modal popup player for the selected song
class PlayerScreen extends StatefulWidget {
  const PlayerScreen({Key? key, required this.song}) : super(key: key);
  // Pass in the JSON dictionary (Song info)
  final SongDataModel song;

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
    _assetsAudioPlayer
        .open(
      Audio.network(widget.song.preview,
          metas: Metas(
            title: widget.song.name,
            artist: widget.song.artist,
            album: widget.song.album,
            image: MetasImage.network(
                widget.song.albumArt), //can be MetasImage.network
          )),
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
          scrolledUnderElevation: 0),
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
        child: context.width > context.height
            ? landscapeLayoutBuilder()
            : portraitLayoutBuilder(),
      ),
    );
  }

  portraitLayoutBuilder() {
    return Container(
      color: AppColor.backgroundColor,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 32),
          AlbumArt(
              size: (context.width - 72) > (context.height - 400)
                  ? (context.height - 400)
                  : (context.width - 72),
              imageURL: widget.song.albumArt,
              isPlayer: true),
          const SizedBox(height: 32),
          TextBox.playerTitle(widget.song.name),
          const SizedBox(height: 16),
          TextBox.playerSubtitle(
              '${widget.song.artist ?? ''} - ${widget.song.album ?? ''}'),
          const SizedBox(height: 16),
          // Show loading indicator when loading, otherwise, show the audio player instead
          Obx(() => isLoading.isTrue ? spinKit : playerControl()),
        ],
      ),
    );
  }

  landscapeLayoutBuilder() {
    return Container(
      color: AppColor.backgroundColor,
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 32),
          AlbumArt(
              size: (context.width / 2 - 96) > (context.height - 144)
                  ? (context.height - 144)
                  : (context.width / 2 - 96),
              imageURL: widget.song.albumArt,
              isPlayer: true),
          const SizedBox(width: 32),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 32),
                  TextBox.playerTitle(widget.song.name),
                  const SizedBox(height: 16),
                  TextBox.playerSubtitle(
                      '${widget.song.artist} - ${widget.song.album}'),
                  const SizedBox(height: 16),
                  // Show loading indicator when loading, otherwise, show the audio player instead
                  SizedBox(
                    width: context.width,
                    height: 192,
                    child:
                        Obx(() => isLoading.isTrue ? spinKit : playerControl()),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  playerControl() {
    return _assetsAudioPlayer.builderRealtimePlayingInfos(
        builder: (context, RealtimePlayingInfos? infos) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Define the size of the seek bar
          SeekBarWidget(
            currentPosition: infos!.currentPosition,
            duration: infos.duration,
            seekTo: (to) {
              _assetsAudioPlayer.seek(to);
            },
          ),
          // Set the play or pause button
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    _assetsAudioPlayer.pause();
                    _assetsAudioPlayer.seek(const Duration(seconds: 0));
                    _assetsAudioPlayer.play();
                  },
                  icon: const Icon(
                    Icons.settings_backup_restore_rounded,
                    color: AppColor.textInputColor,
                    size: 32,
                  )),
              const SizedBox(width: 32),
              IconButton(
                  onPressed: () {
                    _assetsAudioPlayer.playOrPause();
                  },
                  icon: Icon(
                    infos!.isPlaying
                        ? Icons.pause_circle_filled_rounded
                        : Icons.play_circle_fill_rounded,
                    color: AppColor.accentColor,
                    size: 88,
                  )),
              const SizedBox(width: 32),
              // Placeholder for the button
              const SizedBox(width: 32, height: 32),
            ],
          )
        ],
      );
    });
  }
}
