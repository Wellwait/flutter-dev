import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import '../../common_widgets/custom_button.dart';
import '../../utils/app_strings.dart';
import '../../utils/colors.dart';
import '../widget/top_nav_bar_widget.dart';
import 'otp_verification_viewmodel.dart';

class AdminOtpVerification extends StatelessWidget {
  AdminOtpVerification({super.key});
  late OtpVerificationViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    _viewModel = context.watch<OtpVerificationViewModel>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: SvgPicture.asset(
                'assets/verification.svg',
                height: MediaQuery.of(context).size.height * 0.35,
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.60,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: primaryColor07,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.arrow_back),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            AppString.verifyYourAccount,
                            style: const TextStyle(
                              color: Color(0xFF4A8D8A),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F1F1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.error,
                              color: Colors.black45,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              AppString.otpSentMessage,
                              maxLines: 2,
                              style: const TextStyle(
                                color: Colors.black45,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      PinCodeTextField(
                        appContext: context,
                        length: 6,
                        obscureText: false,
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(18),
                          fieldHeight: 60,
                          fieldWidth: 50,
                          activeFillColor: inputFillColor,
                          selectedFillColor: inputFillColor,
                          inactiveFillColor: inputFillColor,
                          activeColor: primaryColor,
                          inactiveColor: primaryColor,
                          selectedColor: primaryColor,
                        ),
                        cursorColor: Colors.black,
                        animationDuration: const Duration(milliseconds: 300),
                        enableActiveFill: true,
                        controller: _viewModel.otpController,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          // Auto-verify the OTP when it's fully entered
                          if (value == "123456") {
                            // Logic for auto-verification
                          }
                        },
                      ),
                      const SizedBox(height: 30),
                      CustomButton(
                        text: AppString.verify,
                        onPressed: () {
                          if (_viewModel.otpController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(AppString.pleaseEnterOtp),
                              ),
                            );
                          } else if (_viewModel.otpController.text == "111111") {
                            Get.to(() => StepperNavBar());

                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => StepperNavBar()),
                            // );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(AppString.invalidOtp),
                              ),
                            );
                          }
                        },
                        isBordered: false,
                        textColor: Colors.white,
                        color: primaryColor,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                          onPressed: () {
                            // Resend OTP logic
                          },
                          child: Text(
                            AppString.resendOtp,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
