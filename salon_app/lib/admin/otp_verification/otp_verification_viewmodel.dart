import 'package:flutter/material.dart';

class OtpVerificationViewModel extends ChangeNotifier {
  final TextEditingController otpController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool showProgressbar = false;




  void refreshUI() {
    notifyListeners();
  }

}
