import 'package:dairyfarm_guide/models/lessons.dart';
import 'package:dairyfarm_guide/theme/color.dart';
import 'package:dairyfarm_guide/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LessonItem extends StatefulWidget {
  final Lessons data;

  const LessonItem({super.key, required this.data});

  @override
  State<LessonItem> createState() => _LessonItemState();
}

class _LessonItemState extends State<LessonItem> {
  late YoutubePlayerController _controller;
  late String thumbnailUrl = "";
  @override
  void initState() {
    super.initState();
    final videoID = YoutubePlayer.convertUrlToId(widget.data.video_url);
    _controller = YoutubePlayerController(
        initialVideoId: videoID!,
        flags: const YoutubePlayerFlags(autoPlay: false));
    // thumbnailUrl = _controller.getThumbnail();

    thumbnailUrl = YoutubePlayer.getThumbnail(
      videoId: _controller.initialVideoId,
      quality: ThumbnailQuality.medium,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: shadowColor.withOpacity(0.07),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(1, 1),
            ),
          ]),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomImage(
            //widget.data.image,
            thumbnailUrl,
            radius: 10,
            height: 70,
            width: 70,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.data.name,
                  style: const TextStyle(
                      color: textColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(
                      Icons.schedule_outlined,
                      color: labelColor,
                      size: 18,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      widget.data.duration,
                      style: const TextStyle(
                        color: labelColor,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            color: labelColor,
            size: 15,
          )
        ],
      ),
    );
  }
}
