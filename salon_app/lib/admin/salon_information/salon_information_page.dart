import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salon_app/admin/salon_information/salon_information_viewmodel.dart';
import 'package:salon_app/utils/colors.dart';
import '../../utils/app_strings.dart';
import '../../utils/app_text_style.dart';
import '../../widget/custom_button.dart';
import '../admin_email_login/admin_email_login_viewmodel.dart';

class SalonInformationPage extends StatefulWidget {
  final Function()? onNext;
  final Function()? onBack; // Add this line

  const SalonInformationPage({super.key, this.onNext, this.onBack});

  @override
  State<SalonInformationPage> createState() => _SalonInformationPageState();
}

class _SalonInformationPageState extends State<SalonInformationPage> {
  late SalonInformationViewModel _viewModel;
  late AdminEmailLoginViewModel _adminEmailLoginViewModel;


  @override
  Widget build(BuildContext context) {
    _viewModel = context.watch<SalonInformationViewModel>();
    _adminEmailLoginViewModel = Provider.of<AdminEmailLoginViewModel>(context, listen: false);
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 30),
          Center(
            child: Text(
              AppString.salonInformationTitle,
              style: AppTextStyle.getTextStyle18FontWeightw600FabricColor,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppString.workingDays,
                              style: AppTextStyle.getTextStyle20FontWeightBold,
                            ),
                            TextButton(
                              onPressed: () {
                                // Call a method in your view model to toggle all checkboxes
                                _viewModel.toggleSelectAll();
                                setState(() {}); // Trigger UI rebuild to reflect the changes
                              },
                              child: Text(
                                _viewModel.isAllSelected
                                    ? AppString.selectAll // Change text dynamically
                                    : AppString.selectAll, // Original text
                                style: AppTextStyle.getTextStyle15FontWeightw300FabricColor,
                              ),
                            ),
                          ],
                        ),
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
                            padding: const EdgeInsets.all(0),
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 5,
                              ),
                              itemCount: _viewModel.checkboxStates.length,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    Checkbox(
                                      activeColor: fabricColor,
                                      value: _viewModel.checkboxStates[index],
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _viewModel.checkboxStates[index] = value ?? false;
                                        });
                                        print(_viewModel.checkboxStates[index]);
                                      },
                                    ),
                                    Text(
                                      _viewModel.days[index],
                                      style: AppTextStyle.getTextStyle16FontWeightw400Black,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          AppString.openingClosingTime,
                          style: AppTextStyle.getTextStyle20FontWeightBold,
                        ),
                        const SizedBox(height: 14),
                        checkBox(),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            timePickerContainer(AppString.openingTime, _viewModel.openingTime, (time) {
                              setState(() {
                                _viewModel.openingTime = time;
                              });
                            }),
                            timePickerContainer(AppString.closingTime, _viewModel.closingTime, (time) {
                              setState(() {
                                _viewModel.closingTime = time;
                              });
                            }),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          AppString.lunchTime,
                          style: AppTextStyle.getTextStyle20FontWeightBold,
                        ),
                        const SizedBox(height: 14),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            timePickerContainer(AppString.openingTime, _viewModel.lunchStartTime, (time) {
                              setState(() {
                                _viewModel.lunchStartTime = time;
                              });
                            }),
                            timePickerContainer(AppString.closingTime, _viewModel.lunchEndTime, (time) {
                              setState(() {
                                _viewModel.lunchEndTime = time;
                              });
                            }),
                          ],
                        ),
                      ],
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
                    text: AppString.nextButton,
                    textColor: Colors.white,
                    onPressed: () {
                      // Collect all selected days
                      List<String> selectedDays = [];
                      for (int i = 0; i < _viewModel.checkboxStates.length; i++) {
                        if (_viewModel.checkboxStates[i]) {
                          selectedDays.add(_viewModel.days[i]);
                        }
                      }

                      // Check if any days are selected
                      if (selectedDays.isEmpty) {
                        print('No days selected.');
                        return; // Prevent further execution if no day is selected
                      }

                      // Ensure opening and closing times are set
                      if (_viewModel.openingTime == null || _viewModel.closingTime == null) {
                        print('Opening and/or closing time not set.');
                        return; // Prevent further execution if times are not set
                      }

                      // Call addSalonTiming with all selected days
                      for (String day in selectedDays) {
                        _viewModel.fetchData(
                          _adminEmailLoginViewModel.serviceProviderId!, // Replace with actual salon ID
                          day,
                          _viewModel.openingTime!,
                          _viewModel.closingTime!,
                          _viewModel.lunchStartTime,
                          _viewModel.lunchEndTime,
                        );
                      }
                      // Call onNext callback if provided
                      widget.onNext?.call();
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

  Widget timePickerContainer(String title, TimeOfDay? time, ValueChanged<TimeOfDay?> onTimeChanged) {
    return GestureDetector(
      onTap: () async {
        final selectedTime = await showTimePicker(
          context: context,
          initialTime: time ?? TimeOfDay.now(),
        );
        if (selectedTime != null) {
          onTimeChanged(selectedTime);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black54, width: 1),
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Row(
          children: [
            const Icon(Icons.access_time, color: fabricColor),
            const SizedBox(width: 8),
            Text(
              time != null ? time.format(context) : AppString.selectTime,
              style: AppTextStyle.getTextStyle16FontWeightw400Black,
            ),
          ],
        ),
      ),
    );
  }


  checkBox() {
    return Column(
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _viewModel.firstAdditionalCheckboxSelected = !_viewModel.firstAdditionalCheckboxSelected;
                  if (_viewModel.firstAdditionalCheckboxSelected) {
                    _viewModel.secondAdditionalCheckboxSelected = false; // Deselect the other checkbox
                  }
                });
                print(_viewModel.firstAdditionalCheckboxSelected);
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _viewModel.firstAdditionalCheckboxSelected ? fabricColor : Colors.transparent,
                  border: Border.all(color: Colors.black54, width: 2),
                ),
                width: 24,
                height: 24,
                alignment: Alignment.center,
                // Removed the check icon
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                AppString.openAndCloseMySalon,
                style: AppTextStyle.getTextStyle14FontWeightw400Black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _viewModel.secondAdditionalCheckboxSelected = !_viewModel.secondAdditionalCheckboxSelected;
                  if (_viewModel.secondAdditionalCheckboxSelected) {
                    _viewModel.firstAdditionalCheckboxSelected = false; // Deselect the other checkbox
                  }
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _viewModel.secondAdditionalCheckboxSelected ? fabricColor : Colors.transparent,
                  border: Border.all(color: Colors.black54, width: 2),
                ),
                width: 24,
                height: 24,
                alignment: Alignment.center,
                // Removed the check icon
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                AppString.separate,
                style: AppTextStyle.getTextStyle14FontWeightw400Black,
              ),
            ),
          ],
        ),
      ],
    );
  }

}
