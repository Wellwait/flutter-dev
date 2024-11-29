import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:salon_app/Screens/payment/payment_screen.dart';
import 'package:salon_app/utils/common_variables.dart';
import '../queue/queue_viewmodel.dart';
import '../utils/app_strings.dart';
import '../utils/app_text_style.dart';
import '../utils/colors.dart';
import '../widget/custom_button.dart';
import '../widget/snack_bar_widget.dart';
import 'rating_page_viewmodel.dart';

class RatingPage extends StatefulWidget {
  int? bookingId;
  double? bookingPrice;
  int? serviceProviderId;
  RatingPage({super.key,this.bookingId,this.bookingPrice,this.serviceProviderId});

  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  late RatingViewModel _viewModel;
  late QueueViewModel _queueViewModel;

  @override
  Widget build(BuildContext context) {
    _viewModel = context.watch<RatingViewModel>();
    _queueViewModel = context.watch<QueueViewModel>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new,color: Colors.black,),
        ),
      ),
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
      padding: const EdgeInsets.only(top: 0), // Adds some top padding
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/booked_image.svg',
              height: 250,
              width: 250,
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
                widget.bookingPrice.toString(), // Use the string from AppString
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
                calculateTotalPrice().toString(), // Use the string from AppString
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
                if (_viewModel.selectedStar == 0) {
                  CustomSnackBar.showSnackBar("Please select a rating star!");
                } else {
                  await _viewModel.submitRating(userId!, widget.serviceProviderId!);
                  Get.to(() => PaymentScreen());
                }
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

// Calculate the total price including platform fees
  calculateTotalPrice() {
    int basePlatformFee = 50;
    return basePlatformFee + widget.bookingPrice!.toDouble();
  }

}
