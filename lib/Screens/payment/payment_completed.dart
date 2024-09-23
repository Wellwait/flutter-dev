import 'package:flutter/material.dart';

class PaymentCompleted extends StatelessWidget {
  const PaymentCompleted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        toolbarHeight: 50,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Checkmark Icon with a circular background and dots
            Stack(
              alignment: Alignment.center,
              children: [
                // Dots around the icon (You can customize the decoration for better effect)
                SizedBox(
                  height: 120,
                  width: 120,
                  child: Stack(
                    children: [
                      for (var i = 0; i < 20; i++)
                        Positioned(
                          top: (i.isEven ? 40 : 20) *
                              (i % 2 == 0 ? 1 : -1).toDouble(),
                          left: (i.isEven ? 40 : 20) *
                              (i % 3 == 0 ? 1 : -1).toDouble(),
                          child: const CircleAvatar(
                            radius: 5,
                            backgroundColor: Colors.teal,
                          ),
                        ),
                    ],
                  ),
                ),
                // Circular icon with checkmark
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.teal,
                  child: Icon(Icons.check, size: 50, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Success Message
            const Text(
              'Payment Completed\nSuccessfully!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.teal,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
