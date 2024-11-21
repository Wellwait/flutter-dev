import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import '../services/services.dart';
import '../utils/common_variables.dart';
import '../utils/sp_helper.dart';
import '../widget/bottom_bar_widget.dart';
import '../widget/snack_bar_widget.dart';

class EmailLoginViewModel extends ChangeNotifier {
  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool showProgressbar = false;
  bool obscurePassword = true;

  final SharedPreferenceService _sharedPreferenceService = SharedPreferenceService();
  final ApiService _apiService = ApiService();


  setUserId(int? user_id) {
    userId = user_id;
  }


  void refreshUI() {
    notifyListeners();
  }

  Future<void> loginUser(BuildContext context) async {
    showProgressbar = true;
    refreshUI();
    final String email = emailAddressController.text;
    final String password = passwordController.text;

    try {
      // Call the login method in ApiService
      final responseBody = await _apiService.loginUser(email, password);

      userId = responseBody['userId'];
      userName = responseBody['userName'];
      userPhoneNumber = responseBody['phone_number'];
      userEmail = responseBody['email'];

      // Parse birthday if it exists and is valid
      final birthdayString = responseBody['birthday'];
      print("birthdayString ${birthdayString}");
      if (birthdayString != null && birthdayString.isNotEmpty) {
        try {
          userBirthday = DateTime.parse(birthdayString);
        } catch (e) {
          print("Error parsing birthday: $e");
          userBirthday = null;
        }
      }

      userGender = responseBody['gender'];

      print('User ID: $userId');
      print('User Name: $userName');
      print('User Phone Number: $userPhoneNumber');
      print('User Email: $userEmail');
      print('User Birthday: $userBirthday');
      print('User Gender: $userGender');

      // Save the user information
      await _sharedPreferenceService.saveUserId(userId!);
      await _sharedPreferenceService.saveUsername(userName);
      await _sharedPreferenceService.saveUserPhoneNumber(userPhoneNumber ?? '');
      await _sharedPreferenceService.saveUserEmail(userEmail);
      await _sharedPreferenceService.saveUserBirthday(userBirthday?.toIso8601String() ?? '');
      await _sharedPreferenceService.saveUserGender(userGender);
      await _sharedPreferenceService.saveUserInfo();

      showProgressbar = false;
      refreshUI();

      // Process the response and navigate to BottomBar
      await _sharedPreferenceService.saveCredentials(email, password);
      CustomSnackBar.showSnackBar("Login successful!");
      Get.to(() => BottomBar());
    } catch (e) {
      showProgressbar = false;
      refreshUI();
      CustomSnackBar.showSnackBar("Error: $e");
      print("Error: $e");
    }
  }



}
