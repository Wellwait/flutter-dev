import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:salon_app/Screens/registration/registration_viewmodel.dart';
import '../../common_widgets/custom_button.dart';
import '../../email_login/email_login_page.dart';
import '../../home_screen/home_screen_page.dart';
import '../../utils/colors.dart';
import '../../widget/bottom_bar_widget.dart';
import '../../widget/custom_textfield.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late RegistrationViewModel _viewModel;



  @override
  Widget build(BuildContext context) {
    _viewModel = context.watch<RegistrationViewModel>();
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
                    Get.to(() => EmailLoginPage());

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) =>
                    //           EmailLoginPage()),
                    // );
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
                height: MediaQuery.of(context).size.height * 0.70,
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
                    child: Form(
                      key: _viewModel.formKey,
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
                          CustomTextField(
                            controller: _viewModel.nameController,
                            hintText: 'Enter your username',
                            title: "Full name",
                            titleColor: fabricColor,
                            borderRadius: 25,
                            borderColor: fabricColor,
                            borderWidth: 1,
                            textFieldColor: Color(0xFFE0F7F8),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null; // Valid input
                            },
                          ),
                          const SizedBox(height: 18),
                          CustomTextField(
                            controller: _viewModel.emailAddressController,
                            hintText: 'Enter your email',
                            title: "Email address",
                            titleColor: fabricColor,
                            borderRadius: 25,
                            borderColor: fabricColor,
                            borderWidth: 1,
                            textFieldColor: Color(0xFFE0F7F8),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              // Check for a valid email format
                              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                                return 'Please enter a valid email address';
                              }
                              return null; // Valid input
                            },
                          ),
                          const SizedBox(height: 18),
                          CustomTextField(
                            controller: _viewModel.passwordController,
                            hintText: 'Enter Password',
                            title: "Password",
                            titleColor: fabricColor,
                            borderRadius: 25,
                            borderColor: fabricColor,
                            borderWidth: 1,
                            textFieldColor: const Color(0xFFE0F7F8),
                            obscureText: _viewModel.obscurePassword,
                            showPasswordToggle: true,
                            iconSize: 20,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your Password';
                              }
                              return null; // Valid input
                            },
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
                                if (_viewModel.formKey.currentState!.validate()) {
                                  // If the form is valid, proceed with the next steps
                                  // ScaffoldMessenger.of(context).showSnackBar(
                                  //   const SnackBar(content: Text('Processing Data')),
                                  _viewModel.registerUser(context);
                                  // );
                                }
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
            ),
          ],
        ),
      ),
    );
  }
}
