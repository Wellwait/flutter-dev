import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:salon_app/admin/salon_documents/salon_documents_viewmodel.dart';
import '../../utils/app_strings.dart';
import '../../utils/app_text_style.dart';
import '../../utils/colors.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_textfield.dart';
import '../admin_queue/admin_queue_page.dart';

class SalonDocumentsPage extends StatefulWidget {
  final Function()? onBack; // Add this line

  const SalonDocumentsPage({this.onBack});

  @override
  State<SalonDocumentsPage> createState() => _SalonDocumentsPageState();
}

class _SalonDocumentsPageState extends State<SalonDocumentsPage> {
  late SalonDocumentsViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    _viewModel = context.watch<SalonDocumentsViewModel>();
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 30),
          Center(
            child: Text(
              AppString.salonDocumentsTitle,
              style: AppTextStyle.getTextStyle18FontWeightw600FabricColor,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 14),
                    child: Form(
                      key: _viewModel.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppString.enterPanGstinDetails,
                            style: AppTextStyle.getTextStyle20FontWeightBold,
                          ),
                          const SizedBox(height: 10),
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
                                    controller: _viewModel.panNumberController,
                                    hintText: AppString.enterPanHintText,
                                    title: AppString.businessOwnerPan,
                                    titleColor: Colors.black,
                                    borderRadius: 25,
                                    borderColor: Colors.teal,
                                    borderWidth: 1,
                                    textFieldColor: Colors.white,
                                    validator: (value) {
                                      final panRegex = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$');

                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your PAN number';
                                      }

                                      if (!panRegex.hasMatch(value)) {
                                        return 'Please enter a valid PAN number';
                                      }

                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 8),
                                  CustomTextField(
                                    controller: _viewModel.gstinController,
                                    hintText: AppString.enterGstinHintText,
                                    title: AppString.gstin,
                                    titleColor: Colors.black,
                                    borderRadius: 25,
                                    borderColor: Colors.teal,
                                    borderWidth: 1,
                                    textFieldColor: Colors.white,
                                    // validator: (value) {
                                    //   final gstinRegex = RegExp(r'^[0-9]{2}[A-Z]{4}[0-9]{4}[A-Z]{1}[0-9]{1}[Z]{1}[0-9A-Z]{1}$');
                                    //
                                    //   if (value == null || value.isEmpty) {
                                    //     return 'Please enter your GSTIN';
                                    //   }
                                    //
                                    //   if (!gstinRegex.hasMatch(value)) {
                                    //     return 'Please enter a valid GSTIN';
                                    //   }
                                    //
                                    //   return null;
                                    // },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Checkbox(
                                value: _viewModel.isChecked,
                                activeColor: Colors.teal,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _viewModel.isChecked = value ?? false;
                                  });
                                },
                              ),
                              Text(
                                AppString.dontHaveGstin,
                                style: AppTextStyle.getTextStyle14FontWeightw400Black,
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Text(
                            AppString.officialBankDetails,
                            style: AppTextStyle.getTextStyle20FontWeightBold,
                          ),
                          Text(
                            AppString.bankDetailsDescription,
                            style: AppTextStyle.getTextStyle12FontWeightw600G300,
                          ),
                          const SizedBox(height: 15),
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
                                    controller: _viewModel.accountNumberController,
                                    hintText: AppString.enterAccountNumberHintText,
                                    title: AppString.bankAccountNumber,
                                    titleColor: Colors.black,
                                    borderRadius: 25,
                                    borderColor: Colors.teal,
                                    borderWidth: 1,
                                    textFieldColor: Colors.white,
                                    validator: (value) {
                                      final accountNumberRegex = RegExp(r'^\d{10,16}$');

                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your bank account number';
                                      }

                                      if (!accountNumberRegex.hasMatch(value)) {
                                        return 'Please enter a valid bank account number (10-16 digits)';
                                      }

                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 8),
                                  CustomTextField(
                                    controller: _viewModel.bankCodeController,
                                    hintText: AppString.enterIfscCodeHintText,
                                    title: AppString.ifscCode,
                                    titleColor: Colors.black,
                                    borderRadius: 25,
                                    borderColor: Colors.teal,
                                    borderWidth: 1,
                                    textFieldColor: Colors.white,
                                    validator: (value) {
                                      final ifscRegex = RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$');

                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your IFSC code';
                                      }

                                      if (!ifscRegex.hasMatch(value)) {
                                        return 'Please enter a valid IFSC code (e.g., ABCD0123456)';
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
                      widget.onBack?.call();
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
                    text: AppString.next,
                    textColor: Colors.white,
                    onPressed: () {
                      if (_viewModel.formKey.currentState!.validate()) {
                        _viewModel.updateData(context);
                        Get.to(() => AdminQueuePage());
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
