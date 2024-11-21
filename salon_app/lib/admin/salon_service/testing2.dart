import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker_web/image_picker_web.dart';

import '../../utils/constants.dart'; // Add this package

class ImageUploadWeb extends StatefulWidget {
  @override
  _ImageUploadWebState createState() => _ImageUploadWebState();
}

class _ImageUploadWebState extends State<ImageUploadWeb> {
  Uint8List? _selectedImage;

  // Function to pick image
  Future<void> pickImage() async {
    final image = await ImagePickerWeb.getImageAsBytes();
    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
    }
  }

  // Function to upload image
  Future<void> uploadImage() async {
    if (_selectedImage == null) return;

    var uri = Uri.parse('$BASE_URL/upload');
    var request = http.MultipartRequest('POST', uri);

    // Create a multipart file from the image bytes
    request.files.add(http.MultipartFile.fromBytes(
      'image', // Match the field name in the Node.js backend
      _selectedImage!,
      filename: 'image.jpg',
    ));

    var response = await request.send();
    // Send the request
    var responseString = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      print("Image uploaded successfully: $responseString");
    } else {
      print("Failed to upload image: $responseString");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Image"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _selectedImage != null
                ? Image.memory(_selectedImage!)
                : Text("No image selected"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: pickImage,
              child: Text("Pick Image"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: uploadImage,
              child: Text("Upload Image"),
            ),
          ],
        ),
      ),
    );
  }
}
