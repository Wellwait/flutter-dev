import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import '../../common_widgets/custom_button.dart';
import '../../utils/app_strings.dart';
import '../../utils/app_text_style.dart';
import '../../utils/colors.dart';
import '../../widget/custom_textfield.dart';
import '../admin_register/admin_register_page.dart';
import 'admin_email_login_viewmodel.dart';

class AdminEmailLoginPage extends StatefulWidget {

  AdminEmailLoginPage({super.key});

  @override
  State<AdminEmailLoginPage> createState() => _AdminEmailLoginPageState();
}

class _AdminEmailLoginPageState extends State<AdminEmailLoginPage> {
  late AdminEmailLoginViewModel _viewModel;
  void initState() {
    super.initState();
    // Use addPostFrameCallback to avoid calling during build
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Fetch data methods
      _viewModel.tryAutoLogin();
    });
  }


  @override
  Widget build(BuildContext context) {
    _viewModel = context.watch<AdminEmailLoginViewModel>();
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // Main content
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  // Logo or Image
                  Center(
                    child: SvgPicture.asset(
                      'assets/login.svg',
                      height: MediaQuery.of(context).size.height * 0.30,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Form section inside a Container
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: primaryColor07,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: Form(
                      key: _viewModel.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppString.loginYourAccount,
                            style: AppTextStyle.getTextStyle18FontWeightw600PrimaryColor,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            AppString.makeSure,
                            style: AppTextStyle.getTextStyle14FontWeightHintTextColor,
                          ),
                          const SizedBox(height: 15),

                          // Email TextField
                          CustomTextField(
                            controller: _viewModel.emailAddressController,
                            hintText: AppString.enterYourEmail,
                            title: AppString.enterYourEmail,
                            titleColor: fabricColor,
                            borderRadius: 25,
                            borderColor: fabricColor,
                            borderWidth: 1,
                            textFieldColor: const Color(0xFFE0F7F8),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 15),

                          // Password TextField
                          CustomTextField(
                            controller: _viewModel.passwordController,
                            hintText: AppString.enterYourPassword,
                            title: AppString.enterYourPassword,
                            titleColor: fabricColor,
                            borderRadius: 25,
                            borderColor: fabricColor,
                            borderWidth: 1,
                            textFieldColor: const Color(0xFFE0F7F8),
                            obscureText: _viewModel.obscurePassword,
                            showPasswordToggle: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your Password';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 20),

                          // Login Button
                          SizedBox(
                            width: double.infinity,
                            child: CustomButton(
                              text: AppString.login,
                              color: primaryColor,
                              textColor: Colors.white,
                              isBordered: false,
                              onPressed: () {
                                if (_viewModel.formKey.currentState!.validate()) {
                                  _viewModel.loginAdminPartner(context);
                                }
                              },
                            ),
                          ),
                          const SizedBox(height: 6),

                          // Sign Up Link
                          Align(
                            alignment: Alignment.topRight,
                            child: TextButton(
                              onPressed: () {
                                Get.to(() => AdminRegisterPage());

                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => AdminRegisterPage(),
                                //   ),
                                // );
                              },
                              child: Text(
                                AppString.signUp,
                                style: AppTextStyle.getTextStyle13FontWeight,
                              ),
                            ),
                          ),

                          // Divider for 'OR'
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 0.5,
                                width: MediaQuery.of(context).size.width * 0.40,
                                color: Colors.black,
                              ),
                              Text(AppString.or, style: const TextStyle(color: hintTextColor)),
                              Container(
                                height: 0.5,
                                width: MediaQuery.of(context).size.width * 0.40,
                                color: Colors.black,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),

                          // Other Login Options (Email and Google)
                          CustomButton(
                            text: AppString.continueWithEmail,
                            icon: Icons.email_outlined,
                            isBordered: true,
                            onPressed: () {
                              // Handle Email login logic
                            },
                            color: Colors.white,
                          ),
                          const SizedBox(height: 10),
                          CustomButton(
                            isBordered: true,
                            iconWidget: SvgPicture.asset('assets/google.svg'),
                            text: AppString.loginWithGoogle,
                            onPressed: () {
                              // Handle Google login logic
                            },
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Progress bar while logging in
          Visibility(
            visible: _viewModel.showProgressbar,
            child: Center(
              child: Container(
                height: 40,
                width: 40,
                color: Colors.transparent,
                child: const CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
