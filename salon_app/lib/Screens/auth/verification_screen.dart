import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../common_widgets/custom_button.dart';
import '../../utils/colors.dart';
import '../registration/registration_screen.dart';

class VerificationScreen extends StatelessWidget {
  VerificationScreen({super.key});

  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Primary color
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
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(Icons.arrow_back)),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            'Verify Your Account',
                            style: TextStyle(
                              color: Color(0xFF4A8D8A),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F1F1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.error,
                              color: Colors.black45,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'We have sent you a 6-digit verification code\nto your email. Please kindly check',
                              maxLines: 2,
                              style: TextStyle(
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
                        controller: _otpController,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          // Auto-verify the OTP when it's fully entered
                          if (value == "123456") {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) =>
                            //           RegistrationScreen()),
                            // );
                          }
                        },
                      ),
                      const SizedBox(height: 30),
                      CustomButton(
                        text: "Verify",
                        onPressed: () {
                          if (_otpController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please enter the OTP.'),
                              ),
                            );
                          } else if (_otpController.text == "123456") {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) =>
                            //           RegistrationScreen()),
                            // );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Invalid OTP. Please try again.'),
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
                          child: const Text(
                            "Resend OTP",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
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
