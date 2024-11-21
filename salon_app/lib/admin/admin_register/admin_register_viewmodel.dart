import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import '../../utils/constants.dart';
import '../../widget/snack_bar_widget.dart';
import '../admin_email_login/admin_email_login_page.dart';


class AdminRegisterViewModel extends ChangeNotifier {
  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool showProgressbar = false;
  bool obscurePassword = true;


  Future<void> registerAdminPartner(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    showProgressbar = true;
    refreshUI();
    // Prepare the registration body
    Map<String, dynamic> registrationData = {
      "email": emailAddressController.text,
      "password": passwordController.text,
    };

    try {
      // Send the API request
      final response = await http.post(
        Uri.parse('$BASE_URL/register_partner'),
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
        Get.to(() => AdminEmailLoginPage());
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => AdminEmailLoginPage()), // Navigate to the login page
        // );
      } else {
        // Error in registration
        CustomSnackBar.showSnackBar("Failed to register user: ${response.body}");
        print(response.body);

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
