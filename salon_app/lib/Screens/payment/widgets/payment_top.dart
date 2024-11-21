import 'package:flutter/material.dart';

import '../../../common_widgets/custom_button.dart';
import '../../../utils/app_strings.dart';
import '../../../utils/app_text_style.dart';
import '../../../utils/colors.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/custom_textfield.dart';

class PaymentTop extends StatefulWidget {
  const PaymentTop({super.key});

  @override
  _PaymentTopState createState() => _PaymentTopState();
}

class _PaymentTopState extends State<PaymentTop> {
  bool _isCardDetailsVisible = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  String cardNumber = "";
  String expiryDate = "";
  String cvv = "";

  void _toggleCardDetails() {
    setState(() {
      _isCardDetailsVisible = !_isCardDetailsVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Total Amount
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xffEDF6F6),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total amount',
                    style: AppTextStyle.getTextStyle16FontWeightw600,
                  ),
                  Text(
                    'Rs: 1250',
                    style: AppTextStyle.getTextStyle16FontWeightw600,
                  ),
                ],
              ),
            ),
          ),
        ),
        // Dropdown for Credit/Debit/ATM card
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GestureDetector(
            onTap: _toggleCardDetails,
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
                      const Icon(Icons.credit_card, color: Colors.black54),
                      const SizedBox(width: 10),
                      Text(AppString.cardSelection),
                    ],
                  ),
                  Icon(
                    _isCardDetailsVisible
                        ? Icons.expand_less
                        : Icons.expand_more,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
          ),
        ),
        // Card Details Form (Visible when clicked)
        if (_isCardDetailsVisible)
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: fabricColor,
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    // Card Number Input
                    CustomTextField(
                      controller: cardNumberController,
                      hintText: AppString.cardNumberHint,
                      title: AppString.cardNumber,
                      titleColor: fabricColor,
                      validator: _validateCardNumber,
                      borderWidth: 1,
                      titleFontSize: 12,
                      borderColor: fabricColor,
                    ),
                    const SizedBox(height: 10),
                    // Expiry Date and CVV
                    Row(
                      children: [
                        // Expiry Date Input
                        Expanded(
                          child: CustomTextField(
                            controller: expiryDateController,
                            hintText: AppString.expiryDateHint,
                            title: 'Expiry Date',
                            titleColor: fabricColor,
                            validator: _validateExpiryDate,
                            borderWidth: 1,
                            titleFontSize: 12,
                            borderColor: fabricColor,
                          ),
                        ),
                        const SizedBox(width: 10),
                        // CVV Input

                        Expanded(
                          child: CustomTextField(
                            controller: cvvController,
                            hintText:  AppString.cvv,
                            title:  AppString.cvv,
                            titleColor: fabricColor,
                            validator: _validateCvv,
                            borderWidth: 1,
                            titleFontSize: 12,
                            borderColor: fabricColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      child: CustomButtonWidget(
                        text: AppString.payButton,
                        onPressed: () {},
                        buttonHeight: 40,
                        buttonColor: fabricColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  String? _validateCardNumber(String? value) {
    // Basic validation for card number (16 digits)
    if (value == null || value.isEmpty) {
      return AppString.enterCardNumber;
    }
    if (value.length != 16) {
      return AppString.cardNumberLength;
    }
    return null;
  }

  String? _validateExpiryDate(String? value) {
    // Basic validation for expiry date (MM/YY)
    if (value == null || value.isEmpty) {
      return AppString.enterExpiryDate;
    }
    if (!RegExp(r'^(0[1-9]|1[0-2])\/?([0-9]{2})$').hasMatch(value)) {
      return AppString.expiryDateFormat;
    }
    return null;
  }

  String? _validateCvv(String? value) {
    // Basic validation for CVV (3 digits)
    if (value == null || value.isEmpty) {
      return AppString.enterCvv;
    }
    if (value.length != 3) {
      return AppString.cvvLength;
    }
    return null;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, display a snackbar or perform any action
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );

      // You can also handle the data here
      print('Card Number: $cardNumber');
      print('Expiry Date: $expiryDate');
      print('CVV: $cvv');
    }
  }
}
