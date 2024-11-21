import 'package:flutter/material.dart';

import '../../../utils/app_strings.dart';
import '../../../utils/colors.dart';
import '../../../widget/custom_button.dart';

class PaymentMiddle extends StatefulWidget {
  const PaymentMiddle({super.key});

  @override
  _PaymentMiddleState createState() => _PaymentMiddleState();
}

class _PaymentMiddleState extends State<PaymentMiddle> {
  String? _selectedUPIOption = 'Google Pay'; // Default selected option
  bool _isUpiOptionsVisible = false; // Control visibility of UPI options

  void _setSelectedUPIOption(String? option) {
    setState(() {
      _selectedUPIOption = option;
    });
  }

  void _toggleUpiOptions() {
    setState(() {
      _isUpiOptionsVisible = !_isUpiOptionsVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // UPI Pay Dropdown
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: GestureDetector(
            onTap: _toggleUpiOptions, // Toggle UPI options visibility
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(
                    color: _isUpiOptionsVisible ? Colors.teal : const Color(0xffD1D1D1)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset('assets/icons/upi.png', width: 30), // Replace with the UPI logo path
                      const SizedBox(width: 10),
                      Text(AppString.cardSelection), // Use AppString
                    ],
                  ),
                  Icon(
                    _isUpiOptionsVisible ? Icons.expand_less : Icons.expand_more,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
          ),
        ),
        // UPI Options (Google Pay and Add new UPI ID) - shown when tapped
        if (_isUpiOptionsVisible)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: fabricColor,
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  // Google Pay Option
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      children: [
                        Radio<String>(
                          value: 'Google Pay',
                          groupValue: _selectedUPIOption,
                          onChanged: _setSelectedUPIOption,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Google Pay',
                                style: TextStyle(fontSize: 15, color: Color(0xff727272)),
                              ),
                              Image.asset('assets/icons/gpay.png', width: 30), // Replace with the Google Pay logo path
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (_selectedUPIOption == 'Google Pay')
                    Container(
                      width: double.infinity,
                      child: Container(
                        margin: const EdgeInsets.only(left: 40, right: 15),
                        width: double.infinity,
                        child: CustomButtonWidget(
                          text: AppString.payButton, // Use AppString
                          onPressed: () {},
                          buttonHeight: 40,
                          buttonColor: fabricColor,
                        ),
                      ),
                    ),
                  // Divider Line
                  const Divider(
                    color: fabricColor,
                    thickness: 1,
                  ),
                  // Add new UPI ID Option
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Row(
                      children: [
                        Radio<String>(
                          value: 'Add new UPI ID',
                          groupValue: _selectedUPIOption,
                          onChanged: _setSelectedUPIOption,
                        ),
                        const Text('Add new UPI ID', style: TextStyle(color: Color(0xff727272)),),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
