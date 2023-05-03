import 'package:dairyfarm_guide/theme/color.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final GestureTapCallback onTap;
  final double fsize;
  final Color textcolor;
  final double width;
  final double height;
  final double radious;
  final Color bgColor;
  final IconData? icon;
  final bool disableButton;
  final bool isLoading;

  const CustomButton({
    super.key,
    this.title = "",
    required this.onTap,
    this.fsize = 14,
    this.textcolor = Colors.white,
    this.width = double.infinity,
    this.height = 45,
    this.radious = 10,
    this.bgColor = primary,
    this.icon,
    this.disableButton = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: disableButton,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radious),
              color: disableButton ? bgColor.withOpacity(0.3) : bgColor,
              boxShadow: [
                BoxShadow(
                    color: shadowColor.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(0, 1))
              ]),
          width: width,
          height: height,
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: isLoading
                  ? [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: textcolor,
                          strokeWidth: 3,
                        ),
                      )
                    ]
                  : (icon == null)
                      ? [
                          Text(
                            title,
                            style: TextStyle(
                                fontSize: fsize,
                                color: disableButton
                                    ? textcolor.withOpacity(0.3)
                                    : textcolor,
                                fontWeight: FontWeight.w600),
                          ),
                        ]
                      : [
                          Icon(
                            icon,
                            size: fsize + 7,
                            color: disableButton
                                ? textcolor.withOpacity(0.3)
                                : textcolor,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            title,
                            style: TextStyle(
                                fontSize: fsize,
                                color: disableButton
                                    ? textcolor.withOpacity(0.3)
                                    : textcolor,
                                fontWeight: FontWeight.w600),
                          ),
                        ]),
        ),
      ),
    );
  }
}
