import 'package:flutter/material.dart';

class PaymentTop extends StatefulWidget {
  const PaymentTop({super.key});

  @override
  _PaymentTopState createState() => _PaymentTopState();
}

class _PaymentTopState extends State<PaymentTop> {
  bool _isCardDetailsVisible = false;

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
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total amount',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              Text(
                'Rs: 1250',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
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
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.credit_card, color: Colors.black54),
                      SizedBox(width: 10),
                      Text('Credit / Debit / ATM Card'),
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
            child: Column(
              children: [
                // Card Number Input
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Card Number',
                    hintText: 'xxxx xxxx xxxx xxxx',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Expiry Date and CVV
                Row(
                  children: [
                    // Expiry Date Input
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                          labelText: 'Expiry Date',
                          hintText: 'MM / YY',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // CVV Input
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'CVV',
                          hintText: 'CVV',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Pay Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      backgroundColor:
                          Colors.teal, // Adjust to desired button color
                    ),
                    onPressed: () {
                      // Payment action
                    },
                    child: const Text(
                      'Pay Rs: 1250',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
