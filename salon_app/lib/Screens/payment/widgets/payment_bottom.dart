import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:salon_app/Screens/payment/widgets/scanner_page.dart';

import '../../../utils/app_strings.dart';

class PaymentBottom extends StatefulWidget {
  const PaymentBottom({super.key});

  @override
  _PaymentBottomState createState() => _PaymentBottomState();
}

class _PaymentBottomState extends State<PaymentBottom> {
  bool _isScanPayExpanded = false;

  void _toggleScanPay() {
    setState(() {
      _isScanPayExpanded = !_isScanPayExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Scan & Pay Dropdown
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: GestureDetector(
            onTap: () {
              _toggleScanPay();
              Get.to(() => ScannerPage());

              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => ScannerPage()), // Navigate to the new page
              // );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xffD1D1D1)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset('assets/icons/scanpay.png',
                          width: 30), // Replace with the Scan & Pay logo path
                      const SizedBox(width: 10),
                      Text(AppString.scanAndPay), // Use AppString here
                    ],
                  ),
                  Icon(
                    _isScanPayExpanded ? Icons.expand_less : Icons.expand_more,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
          ),
        ),
        if (_isScanPayExpanded)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                // Add content related to Scan & Pay if necessary
              ],
            ),
          ),
        // Other Section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            AppString.other, // Use AppString here
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xff202020),
            ),
          ),
        ),
        // Pay through Cash Option
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GestureDetector(
            onTap: () {
              // Handle cash payment action
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xffD1D1D1)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Image.asset('assets/icons/cash.png',
                      width: 30), // Replace with the cash icon path
                  const SizedBox(width: 10),
                  Text(AppString.payThroughCash), // Use AppString here
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
