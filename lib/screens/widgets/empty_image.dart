import 'package:digisalad_task/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// Widget that shows the lottie animation when nothing is in the search result
class EmptyImage extends StatefulWidget {
  const EmptyImage({Key? key, required this.icon, required this.title})
      : super(key: key);
  // Pass in the asset directory of the animated icon
  final String icon;
  // Pass in the text that shows under the animated icon
  final String title;

  @override
  State<EmptyImage> createState() => _EmptyImageState();
}

class _EmptyImageState extends State<EmptyImage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 32),
          // Place the icon and set the size to 200
          SizedBox(
            width: 200,
            child: Lottie.asset(widget.icon),
          ),
          // Place the text under the icon
          Text(
            widget.title,
            style:
                const TextStyle(fontSize: 15, color: AppColor.textInputColor),
          ),
        ],
      ),
    );
  }
}
