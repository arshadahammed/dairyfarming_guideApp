import 'package:cached_network_image/cached_network_image.dart';
import 'package:dairyfarm_guide/models/course_details.dart';
import 'package:dairyfarm_guide/theme/color.dart';
import 'package:flutter/material.dart';

class FeatureItem extends StatelessWidget {
  const FeatureItem(
      {Key? key,
      required this.data,
      this.width = 280,
      this.height = 290,
      this.onTap})
      : super(key: key);
  final Courses data;
  final double width;
  final double height;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 5, top: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: shadowColor.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(1, 1), // changes position of shadow
            ),
          ],
        ),
        child: Stack(
          children: [
            // CustomImage(
            //   data["image"],
            //   width: double.infinity,
            //   height: 190,
            //   radius: 15,
            // ),
            Hero(
                tag: data.id.toString() + data.image,
                // ignore: sized_box_for_whitespace
                child: Container(
                  width: double.infinity,
                  height: 190,
                  child: CachedNetworkImage(
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover)),
                    ),
                    imageUrl: data.image,
                  ),
                )),
            Positioned(
              top: 170,
              right: 15,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: shadowColor.withOpacity(0.05),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: Text(
                  data.price,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Positioned(
              top: 210,
              child: Container(
                width: width - 20,
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 17,
                          color: textColor,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        getAttribute(Icons.play_circle_outlined, labelColor,
                            data.session),
                        const SizedBox(
                          width: 12,
                        ),
                        getAttribute(
                            Icons.schedule_rounded, labelColor, data.duration),
                        const SizedBox(
                          width: 12,
                        ),
                        getAttribute(Icons.star, yellow, data.review),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  getAttribute(IconData icon, Color color, String info) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: color,
        ),
        const SizedBox(
          width: 3,
        ),
        Text(
          info,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: labelColor, fontSize: 13),
        ),
      ],
    );
  }
}
