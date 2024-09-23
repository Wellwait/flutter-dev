import 'package:flutter/material.dart';

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
                    color: _isUpiOptionsVisible ? Colors.teal : Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset('assets/icons/upi.png',
                          width: 30), // Replace with the UPI logo path
                      const SizedBox(width: 10),
                      const Text('UPI Pay'),
                    ],
                  ),
                  Icon(
                    _isUpiOptionsVisible
                        ? Icons.expand_less
                        : Icons.expand_more,
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
            child: Column(
              children: [
                // Google Pay Option
                Row(
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
                          const Text('Google Pay'),
                          Image.asset('assets/icons/gpay.png',
                              width:
                                  30), // Replace with the Google Pay logo path
                        ],
                      ),
                    ),
                  ],
                ),
                if (_selectedUPIOption == 'Google Pay')
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          backgroundColor: Colors.teal,
                        ),
                        onPressed: () {
                          // Handle Pay action
                        },
                        child: const Text(
                          'Pay Rs: 1250',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                // Divider Line
                const Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                // Add new UPI ID Option
                Row(
                  children: [
                    Radio<String>(
                      value: 'Add new UPI ID',
                      groupValue: _selectedUPIOption,
                      onChanged: _setSelectedUPIOption,
                    ),
                    const Text('Add new UPI ID'),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }
}
