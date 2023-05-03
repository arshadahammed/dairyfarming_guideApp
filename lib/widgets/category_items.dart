import 'package:dairyfarm_guide/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryItem extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final data;
  final Color activeColor;
  final Color bgColor;
  final bool isActive;
  final GestureTapCallback? onTap;
  const CategoryItem(
      {super.key,
      required this.data,
      this.activeColor = primary,
      this.bgColor = Colors.white,
      this.isActive = false,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
            color: isActive ? activeColor : bgColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: shadowColor.withOpacity(.05),
                blurRadius: .5,
                spreadRadius: .5,
                offset: const Offset(1, 1),
              ),
            ]),
        child: Row(
          children: [
            SvgPicture.asset(
              data["icon"],
              // ignore: deprecated_member_use
              color: isActive ? Colors.white : darker,
              width: 16,
              height: 16,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              data["name"],
              style: TextStyle(
                color: isActive ? Colors.white : darker,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
