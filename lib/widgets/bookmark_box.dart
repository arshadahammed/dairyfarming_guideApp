import 'package:dairyfarm_guide/theme/color.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

class BookmarkBox extends StatelessWidget {
  final GestureTapCallback? onTap;
  final bool isBookmarked;

  const BookmarkBox({super.key, this.onTap, this.isBookmarked = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
        // width: 20,
        // height: 20,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: isBookmarked ? primary : Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  color: shadowColor.withOpacity(.05),
                  spreadRadius: 0.5,
                  blurRadius: .5,
                  offset: const Offset(1, 1)),
            ]),
        child: SvgPicture.asset(
          "assets/icons/bookmark.svg",
          // ignore: deprecated_member_use
          color: isBookmarked ? Colors.white : primary,
          width: 22,
          height: 22,
        ),
      ),
    );
  }
}
