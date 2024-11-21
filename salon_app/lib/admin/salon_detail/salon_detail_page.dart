import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:salon_app/admin/salon_detail/solon_detail_viewmodel.dart';
import 'package:salon_app/utils/colors.dart';
import '../../utils/app_strings.dart';
import '../../utils/app_text_style.dart';
import '../../utils/sp_helper.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_textfield.dart';
import '../admin_email_login/admin_email_login_page.dart';
import '../admin_email_login/admin_email_login_viewmodel.dart';
import '../admin_queue/admin_queue_page.dart';

class SalonDetailPage extends StatefulWidget {
  final Function()? onNext;

  const SalonDetailPage({super.key, this.onNext});

  @override
  State<SalonDetailPage> createState() => _SalonDetailPageState();
}

class _SalonDetailPageState extends State<SalonDetailPage> {
  @override
  void initState() {
    super.initState();
    // Load original ID when the page is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AdminEmailLoginViewModel>(context,listen: false).loadOriginalId();
    });
  }
  late SolonDetailViewModel _viewModel;
  late AdminEmailLoginViewModel _adminEmailLoginViewModel;

  @override
  Widget build(BuildContext context) {
    _viewModel = context.watch<SolonDetailViewModel>();
    _adminEmailLoginViewModel = Provider.of<AdminEmailLoginViewModel>(context, listen: false);
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 30),
          Center(
            child: Text(
              AppString.salonDetailTitle,
              style: AppTextStyle.getTextStyle18FontWeightw600FabricColor,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    child: Form(
                      key: _viewModel.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppString.basicDetails,
                            style: AppTextStyle.getTextStyle20FontWeightBold,
                          ),
                          const SizedBox(height: 20),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Colors.black54,
                                width: 1,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomTextField(
                                    controller: _viewModel.ownerFullNameController,
                                    hintText: AppString.enterNameHintText,
                                    title: AppString.ownerFullName,
                                    titleColor: Colors.black,
                                    borderRadius: 25,
                                    borderColor: Colors.teal,
                                    borderWidth: 1,
                                    textFieldColor: Colors.white,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return AppString.enterName;
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 8),
                                  CustomTextField(
                                    controller: _viewModel.salonNameController,
                                    hintText: AppString.enterNameHintText,
                                    title: AppString.salonName,
                                    titleColor: Colors.black,
                                    borderRadius: 25,
                                    borderColor: Colors.teal,
                                    borderWidth: 1,
                                    textFieldColor: Colors.white,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your Salon Name';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 8),
                                  CustomTextField(
                                    controller: _viewModel.salonFullAddressController,
                                    hintText: AppString.enterAddressHintText,
                                    title: AppString.salonFullAddress,
                                    titleColor: Colors.black,
                                    borderRadius: 25,
                                    borderColor: Colors.teal,
                                    borderWidth: 1,
                                    textFieldColor: Colors.white,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your Salon Address';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            AppString.ownerContactDetails,
                            style: AppTextStyle.getTextStyle20FontWeightBold,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            AppString.contactDetailsDescription,
                            style: AppTextStyle.getTextStyle13FontWeightw200,
                          ),
                          const SizedBox(height: 20),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Colors.black54,
                                width: 1,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  CustomTextField(
                                    controller: _viewModel.emailController,
                                    hintText: AppString.enterEmailId,
                                    title: AppString.emailId,
                                    titleColor: Colors.black,
                                    borderRadius: 25,
                                    borderColor: Colors.teal,
                                    borderWidth: 1,
                                    textFieldColor: Colors.white,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return AppString.enterEmail;
                                      }
                                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                                        return 'Please enter a valid email address';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 8),
                                  CustomTextField(
                                    controller: _viewModel.mobileNumberController,
                                    hintText: AppString.enterMobileNumber,
                                    title: AppString.phoneNumber,
                                    titleColor: Colors.black,
                                    borderRadius: 25,
                                    borderColor: Colors.teal,
                                    borderWidth: 1,
                                    textFieldColor: Colors.white,
                                    maxLength: 10,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your Mobile Number';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
            child: Row(
              children: [
                Expanded(
                  child: CustomButtonWidget(
                    text: AppString.backButton,
                    textColor: Colors.black,
                    onPressed: () {
                      final SharedPreferenceService _sharedPreferenceService = SharedPreferenceService();
                      _sharedPreferenceService.clearCredentials();
                      Get.to(() => AdminEmailLoginPage());
                    },
                    buttonColor: Colors.white,
                    borderRadius: 5,
                    buttonHeight: 40,
                    borderColor: Colors.black54,
                    buttonWidth: 1,
                  ),
                ),
                const SizedBox(width: 25),
                Expanded(
                  child: CustomButtonWidget(
                    text: AppString.nextButton,
                    textColor: Colors.white,
                    onPressed: () async {
                      if (_viewModel.formKey.currentState!.validate()) {
                        // Ensure originalId is not null
                        if (_adminEmailLoginViewModel.serviceProviderId != null) {
                          await _viewModel.updateServiceProvider(_adminEmailLoginViewModel.serviceProviderId!);
                          widget.onNext?.call();
                          // Print the details for debugging
                          print(
                              _viewModel.ownerFullNameController.text + "\n" +
                                  _viewModel.salonNameController.text + "\n" +
                                  _viewModel.salonFullAddressController.text + "\n" +
                                  _viewModel.emailController.text + "\n" +
                                  _viewModel.mobileNumberController.text
                          );
                        } else {
                          // Handle null originalId
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Error: originalId is null, unable to proceed.')),
                          );
                        }
                      }
                    },
                    buttonColor: fabricColor,
                    borderRadius: 5,
                    buttonHeight: 40,
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
