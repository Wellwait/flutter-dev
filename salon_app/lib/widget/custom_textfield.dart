import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final Color borderColor;
  final Color textFieldColor;
  final double borderRadius;
  final bool obscureText;
  final bool showPasswordToggle;
  final String? title;
  final double borderWidth;
  final Color? hintTextColor;
  final IconData? prefixIcon;
  final IconData? suffixIcon; // Custom suffix icon
  final Color? iconColor;
  final double? iconSize; // New property for controlling the icon size
  final Color? titleColor;
  final double titleFontSize;
  final Function(String)? onSubmitted;
  final EdgeInsets contentPadding;
  final int? maxLength;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.title,
    this.validator,
    this.borderColor = Colors.black,
    this.textFieldColor = Colors.white,
    this.borderRadius = 10.0,
    this.obscureText = false,
    this.showPasswordToggle = false,
    this.borderWidth = 2,
    this.hintTextColor,
    this.prefixIcon,
    this.suffixIcon, // Custom suffix icon
    this.iconColor = Colors.grey,
    this.iconSize = 24, // Default size of the icon
    this.titleColor,
    this.titleFontSize = 16,
    this.onSubmitted,
    this.contentPadding = const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
    this.maxLength,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText; // Initialize the password visibility state
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          Text(
            widget.title!,
            style: TextStyle(
              fontSize: widget.titleFontSize,
              fontWeight: FontWeight.w500,
              color: widget.titleColor ?? Colors.black,
            ),
          ),
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.controller,
          obscureText: _isObscured, // Toggle password visibility
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
          maxLength: widget.maxLength,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(
              fontWeight: FontWeight.w300,
              color: widget.hintTextColor,
            ),
            filled: true,
            fillColor: widget.textFieldColor,
            contentPadding: widget.contentPadding,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(color: widget.borderColor, width: widget.borderWidth),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(color: widget.borderColor, width: widget.borderWidth),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(color: widget.borderColor, width: widget.borderWidth),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(color: Colors.red, width: widget.borderWidth),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(color: Colors.red, width: widget.borderWidth),
            ),
            prefixIcon: widget.prefixIcon != null
                ? Icon(
              widget.prefixIcon,
              color: widget.iconColor,
              size: widget.iconSize, // Use iconSize here
            )
                : null,
            suffixIcon: widget.showPasswordToggle
                ? SizedBox(
              width: widget.iconSize, // Control the width of the SizedBox to adjust the icon size
              child: IconButton(
                icon: Icon(
                  _isObscured ? Icons.visibility_off : Icons.visibility,
                  color: widget.iconColor ?? Colors.grey,
                  size: widget.iconSize, // Set the size of the eye icon
                ),
                onPressed: () {
                  setState(() {
                    _isObscured = !_isObscured; // Toggle visibility
                  });
                },
              ),
            )
                : widget.suffixIcon != null
                ? Icon(
              widget.suffixIcon,
              color: widget.iconColor,
              size: widget.iconSize, // Set custom size for suffix icon
            )
                : null,
          ),
          validator: widget.validator,
          onFieldSubmitted: widget.onSubmitted,
        ),
      ],
    );
  }
}
