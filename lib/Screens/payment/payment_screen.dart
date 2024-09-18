import 'package:flutter/material.dart';
import 'package:wellwait/Screens/payment/widgets/payment_bottom.dart';
import 'package:wellwait/Screens/payment/widgets/payment_middle.dart';
import 'package:wellwait/Screens/payment/widgets/payment_top.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 245, 246, 246),
        elevation: 0,
        title: Text(
          'Payment Mode',
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back action
            Navigator.of(context).pop(); // Example back navigation
          },
        ),
      ),
      body: SingleChildScrollView(
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
