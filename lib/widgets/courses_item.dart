import 'package:cached_network_image/cached_network_image.dart';
import 'package:dairyfarm_guide/models/course_details.dart';
import 'package:dairyfarm_guide/theme/color.dart';
import 'package:dairyfarm_guide/widgets/bookmark_box.dart';

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class CourseItem extends StatefulWidget {
  final Courses data;
  final GestureTapCallback? onBookmark;
  const CourseItem({super.key, required this.data, required this.onBookmark});

  @override
  State<CourseItem> createState() => _CourseItemState();
}

class _CourseItemState extends State<CourseItem> {
  List<String> _favoriteIds = [];
  //getfav
  Future<void> _getFavorites() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _favoriteIds = prefs.getStringList('favoriteIds') ?? [];
    });
  }

  @override
  void initState() {
    super.initState();
    _getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    bool _isItemFavorite = _favoriteIds.contains(widget.data.id);
    return Container(
      width: 200,
      height: 290,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: shadowColor.withOpacity(.1),
              blurRadius: 1,
              spreadRadius: 1,
              offset: const Offset(1, 1),
            )
          ]),
      child: Stack(
        children: [
          // ignore: sized_box_for_whitespace
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
              imageUrl: widget.data.image,
            ),
          ),
          Positioned(
            top: 175,
            right: 15,
            child: BookmarkBox(
              onTap: widget.onBookmark,
              isBookmarked: _isItemFavorite,
            ),
          ),
          Positioned(
              top: 215,
              // ignore: sized_box_for_whitespace
              child: Container(
                width: MediaQuery.of(context).size.width - 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.data.name,
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
                            Icons.sell_outlined, widget.data.price, labelColor),
                        getAttributes(Icons.play_circle_fill_outlined,
                            widget.data.session, labelColor),
                        getAttributes(Icons.schedule_outlined,
                            widget.data.duration, labelColor),
                        getAttributes(
                            Icons.star, widget.data.review.toString(), yellow),
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
