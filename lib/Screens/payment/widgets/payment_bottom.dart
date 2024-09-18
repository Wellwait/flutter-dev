import 'package:flutter/material.dart';

class PaymentBottom extends StatefulWidget {
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
            onTap: _toggleScanPay,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset('assets/icons/scanpay.png',
                          width: 30), // Replace with the Scan & Pay logo path
                      SizedBox(width: 10),
                      Text('Scan & Pay'),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
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
            'Other',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
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
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Image.asset('assets/icons/cash.png',
                      width: 30), // Replace with the cash icon path
                  SizedBox(width: 10),
                  Text('Pay through Cash'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
