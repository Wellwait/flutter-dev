import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// ignore: unused_import
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wellwait/common_widgets/custom_button.dart';
import 'package:wellwait/common_widgets/custom_text_input.dart';
import 'package:wellwait/utils/colors.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Light grey background
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            SizedBox(
              height: 30,
            ),
            Center(
                child: SvgPicture.asset(
              'assets/login.svg',
              height: MediaQuery.of(context).size.height * 0.25,
            )),
            const Spacer(),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.65,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: primaryColor07,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Login to Your Account',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Make sure that you already have an account.',
                    style: TextStyle(color: hintTextColor, fontSize: 14),
                  ),
                  // const SizedBox(height: 50),
                  Spacer(),
                  const Text(
                    'Phone Number',
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomPhoneInput(controller: TextEditingController()),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      text: 'Send OTP',
                      color: primaryColor,
                      textColor: Colors.white,
                      isBordered: false,
                      onPressed: () {
                        // Handle OTP send logic
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 0.5,
                        width: MediaQuery.of(context).size.width * 0.40,
                        color: Colors.black,
                      ),
                      const Text(
                        "  or  ",
                        style: TextStyle(color: hintTextColor),
                      ),
                      Container(
                        height: 0.5,
                        width: MediaQuery.of(context).size.width * 0.40,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: 'Continue with Email',
                    icon: Icons.email_outlined,
                    isBordered: true,
                    onPressed: () {
                      // Handle Email login logic
                    },
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    isBordered: true,
                    // icon: FontAwesomeIcons.googlePlus,
                    iconWidget: SvgPicture.asset('assets/google.svg'),
                    text: 'Login with Google',
                    onPressed: () {
                      // Handle Google login logic
                    },
                    color: Colors.white,
                  ),
                  Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
