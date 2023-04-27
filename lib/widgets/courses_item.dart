import 'package:cached_network_image/cached_network_image.dart';
import 'package:dairyfarm_guide/models/course_details.dart';
import 'package:dairyfarm_guide/theme/color.dart';
import 'package:dairyfarm_guide/widgets/bookmark_box.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CourseItem extends StatelessWidget {
  final Courses data;
  final GestureTapCallback? onBookmark;
  const CourseItem({super.key, required this.data, required this.onBookmark});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 290,
      padding: EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: shadowColor.withOpacity(.1),
              blurRadius: 1,
              spreadRadius: 1,
              offset: Offset(1, 1),
            )
          ]),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            child: CachedNetworkImage(
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    )),
              ),
              imageUrl: data.image,
            ),
          ),
          Positioned(
            top: 175,
            right: 15,
            child: BookmarkBox(
              onTap: onBookmark,
              isBookmarked: data.is_favorited,
            ),
          ),
          Positioned(
              top: 215,
              child: Container(
                width: MediaQuery.of(context).size.width - 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        getAttributes(
                            Icons.sell_outlined, data.price, labelColor),
                        getAttributes(Icons.play_circle_fill_outlined,
                            data.session, labelColor),
                        getAttributes(
                            Icons.schedule_outlined, data.duration, labelColor),
                        getAttributes(
                            Icons.star, data.review.toString(), yellow),
                      ],
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }

  getAttributes(IconData icon, String name, Color color) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: color,
        ),
        const SizedBox(width: 5),
        Text(
          name,
          style: const TextStyle(fontSize: 13, color: labelColor),
        )
      ],
    );
  }
}
