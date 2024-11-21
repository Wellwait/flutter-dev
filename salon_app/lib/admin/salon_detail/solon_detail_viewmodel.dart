import 'package:flutter/material.dart';
import '../../services/services.dart';
import '../../widget/snack_bar_widget.dart';

class SolonDetailViewModel extends ChangeNotifier {
  final TextEditingController ownerFullNameController = TextEditingController();
  final TextEditingController salonNameController = TextEditingController();
  final TextEditingController salonFullAddressController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool showProgressbar = false;

  final ApiService _apiService = ApiService();


  void refreshUI() {
    notifyListeners();
  }

  Future<void> updateServiceProvider(int id) async {
    if (formKey.currentState?.validate() ?? false) {
      showProgressbar = true;
      refreshUI();

      try {
        await _apiService.updateServiceProvider(
          id,
          ownerFullNameController.text,
          salonNameController.text,
          salonFullAddressController.text,
          emailController.text,
          mobileNumberController.text,
        );
        // Optionally show a success message
        CustomSnackBar.showSnackBar("Update the salon detail is successfully!");
      } catch (error) {
        // Handle error, maybe show an error message
        CustomSnackBar.showSnackBar("Updated is Failed!");
      } finally {
        showProgressbar = false;
        refreshUI();
      }
    }
  }

}
