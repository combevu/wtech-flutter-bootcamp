import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final TextStyle textStyle;
  final bool? border;
  const CustomElevatedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.color,
    required this.textStyle,
    this.border,
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
                    ? const BorderSide(color: Colors.black54, width: 2)
                    : null,
              ),
              child: Text(
                text,
                style: textStyle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
