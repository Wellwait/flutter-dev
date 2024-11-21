import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:salon_app/Screens/payment/payment_screen.dart';
import 'package:salon_app/utils/common_variables.dart';
import '../utils/app_strings.dart';
import '../utils/app_text_style.dart';
import '../utils/colors.dart';
import '../widget/custom_button.dart';
import 'rating_page_viewmodel.dart';

class RatingPage extends StatefulWidget {
  const RatingPage({super.key});

  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  late RatingViewModel _viewModel;


  @override
  Widget build(BuildContext context) {
    _viewModel = context.watch<RatingViewModel>();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Top Center Section
          serviceDone(),
          // Bottom Center Section
          bottomContainer(),
        ],
      ),
    );
  }

  Widget serviceDone() {
    return Padding(
      padding: const EdgeInsets.only(top: 80), // Adds some top padding
      child: Center(
        child: Column(
          children: [
            SvgPicture.asset(
              'assets/booked_image.svg',
              height: 300,
              width: 300,
            ),
            Text(
              AppString.serviceDone, // Use the string from AppString
              style: AppTextStyle.getTextStyle35FontWeightw600,
              textAlign: TextAlign.center,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: AppString.enjoyedQuestion, // Use the string from AppString
                    style: AppTextStyle.getTextStyle12FontWeightw600G300,
                  ),
                  TextSpan(
                    text: AppString.rateNow, // Use the string from AppString
                    style: AppTextStyle.getTextStyle12FontWeightw600Black,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15), // Adds some space
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _viewModel.selectedStar = index + 1; // Update the selected star
                    });
                  },
                  child: Icon(
                    Icons.star,
                    color: index < _viewModel.selectedStar ? Colors.yellow : Colors.grey, // Change color based on selection
                    size: 25, // Size of the star
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomContainer() {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppString.billSummary, // Use the string from AppString
            style: AppTextStyle.getTextStyle14FontWeightw600Black,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppString.services, // Use the string from AppString
                style: AppTextStyle.getTextStyle14FontWeightw400,
              ),
              Text(
                "200", // Use the string from AppString
                style: AppTextStyle.getTextStyle14FontWeightw400,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppString.platformFee, // Use the string from AppString
                style: AppTextStyle.getTextStyle14FontWeightw400,
              ),
              Text(
                "50", // Use the string from AppString
                style: AppTextStyle.getTextStyle14FontWeightw400,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Divider(
            color: Colors.grey[300],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppString.totalPrice, // Use the string from AppString
                style: AppTextStyle.getTextStyle16FontWeightw600,
              ),
              Text(
                AppString.totalPriceValue, // Use the string from AppString
                style: AppTextStyle.getTextStyle14FontWeightw600Black,
              ),
            ],
          ),
          const SizedBox(height: 5),
          Divider(
            color: Colors.grey[300],
          ),
          const SizedBox(height: 15),
          Container(
            width: double.infinity,
            child: CustomButtonWidget(
              text: AppString.proceedToPay, // Use the string from AppString
              onPressed: () async {
                // Call the submitRating method before navigating
                await _viewModel.submitRating(userId!,serviceProviderId); // Replace with actual user ID and service ID
                Get.to(() => PaymentScreen());

                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const PaymentScreen()), // Navigate to the new page
                // );
              },
              buttonHeight: 40,
              borderRadius: 5,
              buttonColor: fabricColor,
            ),
          ),
        ],
      ),
    );
  }

}
