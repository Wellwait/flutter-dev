import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:salon_app/utils/colors.dart';
import 'package:salon_app/utils/common_variables.dart';
import '../utils/app_strings.dart';
import '../utils/app_text_style.dart';
import '../widget/custom_button.dart';
import '../widget/snack_bar_widget.dart';
import 'edit_profile_viewmodel.dart';

class EditProfilePage extends StatefulWidget {
  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late EditProfileViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    // Use addPostFrameCallback to avoid calling during build
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _viewModel.nameController.text = userName;
      _viewModel.phoneController.text = userPhoneNumber ?? '';
      _viewModel.emailController.text = userEmail;
      _viewModel.selectedGender = userGender == 1 ? 'Male' : (userGender == 2 ? 'Female' : null);
      _viewModel.selectedDate = userBirthday;
      // _viewModel.imageName = userProfileImage;
      // print('User profile image: ${userProfileImage}');
      print('gender : ${userGender}');
      print('Birthday : ${userBirthday}');
      _viewModel.refreshUI(); //1732789791741
    });
  }

  @override
  Widget build(BuildContext context) {
    _viewModel = context.watch<EditProfileViewModel>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(
          child: Text(
            AppString.editProfile,
            style: AppTextStyle.getTextStyle18FontWeightw300,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color(0xff008080),
        actions: [
          Container(
            color: Colors.transparent,
            height: 20,
            width: 30,
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 250,
            child: Stack(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xff008080),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          height: 50,
                          width: 50,
                          margin: const EdgeInsets.only(bottom: 50, left: 25),
                          child: Image.asset("assets/star.png", height: 50, width: 50),
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        margin: const EdgeInsets.only(bottom: 50, left: 25),
                        child: Image.asset("assets/star.png", height: 50, width: 50),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  top: 120,
                  left: (MediaQuery.of(context).size.width - 120) / 2, // Center horizontally
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: _viewModel.selectedImage != null
                              ? DecorationImage(
                            image: MemoryImage(_viewModel.selectedImage!),
                            fit: BoxFit.cover,
                          )
                              : const DecorationImage(
                            image: AssetImage('assets/icons/gallery2.png'), // Default image
                            fit: BoxFit.cover,
                          ),
                          border: Border.all(
                            color: Colors.transparent,
                            width: 4,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 8,
                        child: Container(
                          width: 110,
                          padding: const EdgeInsets.all(8.0),
                          decoration: const BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(60),
                              bottomRight: Radius.circular(60),
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              _viewModel.pickImage();
                            },
                            child: const Icon(
                              Icons.photo_camera,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 15, right: 15),
              child: SingleChildScrollView(
                child: Form(
                  key: _viewModel.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      buildTextField(
                        label: AppString.yourName,
                        hintText: 'Enter name',
                        controller: _viewModel.nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppString.enterName;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      buildTextField(
                        label: AppString.phoneNumber,
                        hintText: 'Enter phone number',
                        maxLength: 10,
                        controller: _viewModel.phoneController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppString.enterPhone;
                          }
                          if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                            return AppString.enterValidPhone;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      buildTextField(
                        label: AppString.email,
                        hintText: 'Email',
                        controller: _viewModel.emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppString.enterEmail;
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return AppString.enterValidEmail;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Birthday",
                        style: AppTextStyle.getTextStyle18FontWeightBold,
                      ),
                      TextField(
                        readOnly: true,
                        onTap: () => _selectDate(context),
                        decoration: InputDecoration(
                          hintText: _viewModel.selectedDate == null
                              ? "Select Date" // Placeholder text
                              : DateFormat("dd-MM-yyyy").format(_viewModel.selectedDate!),
                          border: const UnderlineInputBorder(),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                        style: const TextStyle(color: Colors.black),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Gender",
                        style: AppTextStyle.getTextStyle18FontWeightBold,
                      ),
                      DropdownButton<String>(
                        value: _viewModel.selectedGender,
                        hint: const Text("Select Gender"),
                        isExpanded: true,
                        items: ["Male", "Female"].map((String gender) {
                          return DropdownMenuItem<String>(
                            value: gender,
                            child: Text(gender),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            _viewModel.selectedGender = value;
                          });
                        },
                      ),
                      const SizedBox(height: 30),
                      Container(
                        width: double.infinity,
                        child: CustomButtonWidget(
                          text: AppString.save,
                          onPressed: () {
                            // Validate text fields
                            if (_viewModel.formKey.currentState!.validate()) {
                              // Check if the date and gender are selected
                              if (_viewModel.selectedDate == null) {
                                CustomSnackBar.showSnackBar('Please fill in the date');
                              } else if (_viewModel.selectedGender == null || _viewModel.selectedGender!.isEmpty) {
                                CustomSnackBar.showSnackBar('Please select the gender');
                              } else {
                                // Update the common variables
                                _viewModel.updateProfile();

                                // Call updateUserProfile after validating all fields
                                _viewModel.updateUserProfile().then((_) {
                                  CustomSnackBar.showSnackBar('Profile updated successfully!');
                                }).catchError((_) {
                                  CustomSnackBar.showSnackBar('Failed to update profile.');
                                });
                              }
                            } else {
                              CustomSnackBar.showSnackBar('Please fill in all fields correctly.');
                            }
                          },
                          buttonHeight: 50,
                          buttonColor: fabricColor,
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextField({
    required String label,
    required String hintText,
    required TextEditingController controller,
    required String? Function(String?) validator,
    int? maxLength,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.getTextStyle16FontWeightw600,
        ),
        TextFormField(
          controller: controller,
          maxLength: maxLength,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
            hintStyle: TextStyle(color: Colors.grey.shade400),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            counterText: '',
          ),
        ),
      ],
    );
  }


  Future<void> _selectDate(BuildContext context) async {
    // Set default date if selectedDate is invalid
    final DateTime initialDate = (_viewModel.selectedDate != null &&
        _viewModel.selectedDate!.isAfter(DateTime(2000)) &&
        _viewModel.selectedDate!.isBefore(DateTime(2100)))
        ? _viewModel.selectedDate!
        : DateTime.now();

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != _viewModel.selectedDate) {
      setState(() {
        _viewModel.selectedDate = pickedDate;
      });
    }
  }
}
