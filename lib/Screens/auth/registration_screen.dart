import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wellwait/common_widgets/custom_button.dart';
import 'package:wellwait/common_widgets/custom_text_input.dart';
import 'package:wellwait/utils/colors.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool isAgree = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Primary color
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    // Handle skip logic
                  },
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      color: primaryColor, // Use your primary color here
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 20), // Add some padding from the edge
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: SvgPicture.asset(
                'assets/registration.svg',
                height: MediaQuery.of(context).size.height * 0.25,
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                decoration: const BoxDecoration(
                  color: primaryColor07,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: SingleChildScrollView(
                  child: SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 25),
                        const Text(
                          'Create Your Account',
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Make sure your account keep secure',
                          style: TextStyle(color: hintTextColor, fontSize: 14),
                        ),
                        const SizedBox(height: 18),
                        const Text(
                          'Full Name',
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        CustomTextInput(
                          hintText: 'Enter your username',
                          controller: TextEditingController(),
                        ),
                        const SizedBox(height: 18),
                        const Text(
                          'Email Address',
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        CustomTextInput(
                          hintText: 'Enter your email',
                          controller: TextEditingController(),
                        ),
                        const SizedBox(height: 18),
                        SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                            text: 'Create Account',
                            color: primaryColor,
                            textColor: Colors.white,
                            isBordered: false,
                            onPressed: () {
                              // Handle OTP send logic
                            },
                          ),
                        ),
                        const SizedBox(height: 18),
                      ],
                    ),
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
