import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../utils/common_variables.dart';
import '../utils/constants.dart';
import '../widget/snack_bar_widget.dart';

class EditProfileViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  String? selectedGender;
  DateTime? selectedDate;

  final ImagePicker _picker = ImagePicker();
  File? _imageFile; // Add a variable to store the selected image

  File? get imageFile => _imageFile; // Getter for the image file

  Future<void> pickImageFromGallery() async {
    try {
      final XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        _imageFile = File(pickedImage.path); // Store the selected image
        notifyListeners(); // Notify the listeners to update the UI
      }
    } catch (e) {
      print('Error picking image from gallery: $e');
    }
  }

  Future<void> updateUserProfile() async {
    final url = Uri.parse('$BASE_URL/update_user/$userId');
    String? formattedDate = selectedDate != null ? DateFormat('yyyy-MM-dd').format(selectedDate!) : '';
    int? genderValue = selectedGender == 'Male' ? 1 : (selectedGender == 'Female' ? 2 : null);
    final data = {
      'email': emailController.text,
      'username': nameController.text,
      'phone_number': phoneController.text,
      'birthday': formattedDate,
      'gender': genderValue,
    };

    try {
      // Send the PUT request
      final response = await http.put(url,
        headers: {'Content-Type': 'application/json',},
        body: json.encode(data), // Encode data as JSON
      );
      if (response.statusCode == 200) {
        print('User profile updated successfully');
        notifyListeners();
      } else {
        // Handle server error (e.g., 400, 500)
        print('Failed to update profile. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error updating profile: $error');
    }
  }

  void updateProfile() {
    userName = nameController.text;
    userEmail = emailController.text;
    userPhoneNumber = phoneController.text;
    userBirthday = selectedDate;
    userGender = selectedGender == "Male" ? 1 : (selectedGender == "Female" ? 2 : null);
    print("updated value: ${userName}");
    print("updated value: ${userEmail}");
    print("updated value: ${userPhoneNumber}");
    print("updated value: ${userBirthday}");
    print("updated value: ${userGender}");



    // Optionally update any other variables or notify listeners if needed
    notifyListeners();
  }

  void refreshUI() {
    notifyListeners();
  }
}

