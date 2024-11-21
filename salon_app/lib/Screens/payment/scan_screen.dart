import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salon_app/utils/colors.dart';
import 'dart:io';

import '../../widget/custom_button.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  XFile? _image;

  // Function to pick image from gallery
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white, // White app bar background
        elevation: 0, // Removes app bar shadow
        leading: IconButton(
          icon: const Icon(Icons.close, color:fabricColor), // Close icon
          onPressed: () {
            Navigator.pop(context); // Action for closing the screen
          },
        ),
        toolbarHeight: 50, // App bar height
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 40.0,
            horizontal: 20.0), // Adjusting padding around the screen
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Box for Image Preview (with a square border)
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.black,
                      width: 2), // Border matching the image
                ),
                child: _image == null
                    ? Center(
                        child: Container(
                          color: Colors.grey[
                              200], // Light grey background for the placeholder
                          child: const Icon(Icons.photo,
                              size: 100,
                              color: Colors.black26), // Placeholder icon
                        ),
                      )
                    : Image.file(File(_image!.path), fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 20), // Spacing between image box and button
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                margin: const EdgeInsets.only(left: 30,right: 30),
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xffEDF6F6),
                ),
                child: const Center(
                  child: Text(
                    "Upload From Gallery",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
