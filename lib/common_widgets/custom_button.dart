import 'package:flutter/material.dart';
import 'package:wellwait/utils/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final Color? textColor;
  final bool isBordered;
  final IconData? icon;
  final Widget? iconWidget;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color,
    this.textColor,
    this.isBordered = false,
    this.icon,
    this.iconWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: isBordered
          ? ElevatedButton.icon(
              icon: iconWidget ??
                  Icon(
                    icon,
                    color: textColor ?? Colors.black,
                  ),
              label: Text(
                text,
                style: TextStyle(
                  color: textColor ?? Colors.black,
                  fontSize: 16,
                ),
              ),
              style: ElevatedButton.styleFrom(
                foregroundColor: textColor ?? Colors.black,
                backgroundColor: color ?? Colors.transparent,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: isBordered
                      ? BorderSide(color: textColor ?? hintTextColor)
                      : BorderSide.none,
                ),
              ),
              onPressed: onPressed,
            )
          : ElevatedButton(
              child: Text(
                text,
                style: TextStyle(
                  color: textColor ?? Colors.black,
                  fontSize: 16,
                ),
              ),
              style: ElevatedButton.styleFrom(
                foregroundColor: textColor ?? Colors.black,
                backgroundColor: color ?? Colors.transparent,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: isBordered
                      ? BorderSide(color: textColor ?? hintTextColor)
                      : BorderSide.none,
                ),
              ),
              onPressed: onPressed,
            ),
    );
  }
}
