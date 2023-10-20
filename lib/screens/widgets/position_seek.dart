import 'package:digisalad_task/constants/constant.dart';
import 'package:flutter/material.dart';

// Widgets for seeking the exact time for the playing song
class SeekBarWidget extends StatefulWidget {
  const SeekBarWidget({
    Key? key,
    required this.currentPosition,
    required this.duration,
    required this.seekTo,
  }) : super(key: key);

  // Pass in the current playing time for the play head position
  final Duration currentPosition;
  // Pass in the total length of the song
  final Duration duration;
  // Update the seek bar position manually by the user
  final Function(Duration) seekTo;

  @override
  State<SeekBarWidget> createState() => _SeekBarWidgetState();
}

class _SeekBarWidgetState extends State<SeekBarWidget> {
  late Duration _visibleValue;
  bool listenOnlyUserInteraction = false;
  double get percent => widget.duration.inMilliseconds == 0
      ? 0
      : _visibleValue.inMilliseconds / widget.duration.inMilliseconds;

  @override
  void initState() {
    super.initState();
    _visibleValue = widget.currentPosition;
  }

  @override
  void didUpdateWidget(SeekBarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listenOnlyUserInteraction) {
      _visibleValue = widget.currentPosition;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // Widget for showing the current play time in '00:00' format
        SizedBox(
          width: 44,
          child:
          TextBox.listSubtitle(durationToString(widget.currentPosition)),
        ),
        // Widget for the slider with play head
        Expanded(
          child: Slider(
            min: 0,
            max: widget.duration.inMilliseconds.toDouble(),
            value: percent * widget.duration.inMilliseconds.toDouble(),
            // Functions for handling seek time changes and stop the interaction state
            onChangeEnd: (newValue) {
              setState(() {
                listenOnlyUserInteraction = false;
                widget.seekTo(_visibleValue);
              });
            },
            // Functions for changing the interaction state
            onChangeStart: (_) {
              setState(() {
                listenOnlyUserInteraction = true;
              });
            },
            // Functions for notifying the seek time change with the final value
            onChanged: (newValue) {
              setState(() {
                final to = Duration(milliseconds: newValue.floor());
                _visibleValue = to;
              });
            },
          ),
        ),
        // Widget for showing the total length of the song in '00:00' format
        SizedBox(
          width: 44,
          child: TextBox.listSubtitle(durationToString(widget.duration)),
        ),
      ],
    );
  }
}
