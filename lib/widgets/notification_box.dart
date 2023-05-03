import 'package:badges/badges.dart' as badges;
import 'package:dairyfarm_guide/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationBox extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  NotificationBox(
      {Key? key, this.onTap, this.size = 5, this.notifiedNumber = 0})
      : super(key: key);
  final GestureTapCallback? onTap;
  final int notifiedNumber;
  final double size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: EdgeInsets.all(size),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: appBarColor,
            border: Border.all(color: Colors.grey.withOpacity(.3)),
          ),
          child: notifiedNumber > 0
              ? badges.Badge(
                  position: badges.BadgePosition.topEnd(top: -7, end: 0),
                  badgeContent: const Text(
                    '',
                    style: TextStyle(color: Colors.white),
                  ),
                  // ignore: sort_child_properties_last
                  child: SvgPicture.asset(
                    "assets/icons/bell.svg",
                    width: 20,
                    height: 20,
                  ),
                  badgeStyle: const badges.BadgeStyle(
                    badgeColor: actionColor,
                    padding: EdgeInsets.all(3),
                  ))
              : SvgPicture.asset("assets/icons/bell.svg")),
    );
  }
}
