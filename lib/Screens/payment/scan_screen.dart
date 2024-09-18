import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ScanScreen extends StatefulWidget {
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  XFile? _image;

  // Function to pick image from gallery
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // White app bar background
        elevation: 0, // Removes app bar shadow
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black), // Close icon
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
                          child: Icon(Icons.photo,
                              size: 100,
                              color: Colors.black26), // Placeholder icon
                        ),
                      )
                    : Image.file(File(_image!.path), fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: 20), // Spacing between image box and button

            // Upload Button
            Container(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _pickImage,
                icon: Icon(Icons.image,
                    color: Colors.black), // Icon for gallery upload
                label: Text(
                  'Upload from gallery',
                  style: TextStyle(color: Colors.black), // Text color
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.grey[200], // Light grey background for button
                  padding: EdgeInsets.symmetric(
                      vertical: 15), // Height of the button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        30), // Rounded corners for the button
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
