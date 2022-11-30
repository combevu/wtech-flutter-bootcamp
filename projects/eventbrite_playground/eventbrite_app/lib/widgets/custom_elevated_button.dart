import 'package:eventbrite_app/core/constants/app/color_constants.dart';
import 'package:eventbrite_app/core/constants/app/padding_constants.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget with PaddingConstants {
  final String text;
  final VoidCallback? onPressed;
  final Color color;
  final TextStyle textStyle;
  final bool? border;
  final bool? hasImage;
  final String? imagePath;
  CustomElevatedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.color,
    required this.textStyle,
    this.border,
    this.hasImage,
    this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 40,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                side: border == true
                    ? const BorderSide(color: ColorConstants.customElevatedButtonOutlineColor, width: 2)
                    : null,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  hasImage == true
                      ? Container(
                          padding: defaultRightPadding * 2,
                          child: Image.asset(
                            imagePath!,
                            height: 20,
                          ),
                        )
                      : const SizedBox(),
                  Text(
                    text,
                    style: textStyle,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
