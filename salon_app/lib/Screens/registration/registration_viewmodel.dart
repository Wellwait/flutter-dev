import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import '../../email_login/email_login_page.dart';
import '../../utils/constants.dart';
import '../../widget/bottom_bar_widget.dart';
import '../../widget/snack_bar_widget.dart';

class RegistrationViewModel extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool showProgressbar = false;
  bool obscurePassword = true;

  Future<void> registerUser(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    showProgressbar = true;
    refreshUI();
    // Prepare the registration body
    Map<String, dynamic> registrationData = {
      "username": nameController.text,
      "email": emailAddressController.text,
      "password": passwordController.text,
    };

    try {
      // Send the API request
      final response = await http.post(
        Uri.parse('$BASE_URL/register'),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(registrationData),
      );

      showProgressbar = false;
      refreshUI();
      if (response.statusCode == 201) {
        // Successful registration
        CustomSnackBar.showSnackBar("User registered successfully!");
        //await getUsers(); // Call get users after successful registration
        Get.to(() => EmailLoginPage());

        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => EmailLoginPage()), // Navigate to the login page
        // );
      } else {
        // Error in registration
        CustomSnackBar.showSnackBar("Failed to register user: ${response.body}");

      }
    } catch (e) {
      // Handle exceptions
      CustomSnackBar.showSnackBar("Error: $e");
      showProgressbar = false;
      refreshUI();
    }
  }

  void refreshUI() {
    notifyListeners();
  }
}
