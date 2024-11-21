import 'package:flutter/material.dart';
import 'package:salon_app/Screens/payment/widgets/payment_bottom.dart';
import 'package:salon_app/Screens/payment/widgets/payment_middle.dart';
import 'package:salon_app/Screens/payment/widgets/payment_top.dart';
import 'package:salon_app/utils/app_text_style.dart';

import '../../utils/app_strings.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          AppString.paymentMode,
          style: AppTextStyle.getTextStyle20FontWeightBold,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back action
            Navigator.of(context).pop(); // Example back navigation
          },
        ),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            PaymentTop(),
            PaymentMiddle(),
            PaymentBottom(),
          ],
        ),
      ),
    );
  }
}
