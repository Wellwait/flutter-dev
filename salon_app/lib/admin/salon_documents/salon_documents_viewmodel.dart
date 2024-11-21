import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/services.dart';
import '../../widget/snack_bar_widget.dart';
import '../admin_email_login/admin_email_login_viewmodel.dart';

class SalonDocumentsViewModel extends ChangeNotifier {
  final TextEditingController panNumberController = TextEditingController();
  final TextEditingController gstinController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController bankCodeController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool showProgressbar = false;
  bool isChecked = false;
  final ApiService services = ApiService();


  Future<void> updateData(BuildContext context) async {
    if (!formKey.currentState!.validate()) return; // Validate form fields

    showProgressbar = true;
    notifyListeners();

    final int? originalId = Provider.of<AdminEmailLoginViewModel>(context, listen: false).serviceProviderId;

    final response = await services.updateServiceProviderDocuments(
      id: originalId!,
      panCard: panNumberController.text,
      gstIn: gstinController.text,
      bankAccountNumber: accountNumberController.text,
      bankIfscCode: bankCodeController.text,
    );

    if (response.containsKey('error') && response['error'] == true) {
      CustomSnackBar.showSnackBar("Failed!");
      print('Error: ${response['message']}');
    } else {
      CustomSnackBar.showSnackBar("Complete!");
      print('Success: ${response['message']}');
    }
    showProgressbar = false;
    notifyListeners();
  }


  void refreshUI() {
    notifyListeners();
  }
}
