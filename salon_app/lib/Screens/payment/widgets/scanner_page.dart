import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/app_text_style.dart';
import '../../../utils/colors.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  String barcode = 'Tap to scan';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              child: const Text('Scan Barcode'),
              onPressed: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AiBarcodeScanner(
                      onDispose: () {
                        debugPrint("Barcode scanner disposed!");
                      },
                      hideGalleryButton: false,
                      controller: MobileScannerController(
                        detectionSpeed: DetectionSpeed.noDuplicates,
                      ),
                      onDetect: (BarcodeCapture capture) {
                        final String? scannedValue = capture.barcodes.first.rawValue;

                        if (scannedValue != null) {
                          debugPrint("Barcode scanned: $scannedValue");

                          // Close the scanner
                          Navigator.of(context).pop();

                          // Navigate to the PaymentCompletePage
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => PaymentCompletePage(),
                            ),
                          );
                        }
                      },
                      validator: (value) {
                        if (value.barcodes.isEmpty) {
                          return false;
                        }
                        return true; // Simplified for demonstration
                      },
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            Text(barcode, style: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}





class PaymentCompletePage extends StatefulWidget {
  const PaymentCompletePage({super.key});

  @override
  _PaymentCompletePageState createState() => _PaymentCompletePageState();
}

class _PaymentCompletePageState extends State<PaymentCompletePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Duration of the animation
    );

    // Define scale animation to zoom in the images
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut, // Adds a smooth zoom-in effect
    );

    // Define opacity animation to fade in the images
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    // Start the animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose(); // Clean up the controller when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.close,color: fabricColor,),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min, // Centers the content vertically
          children: [
            // Apply both scale and opacity animation
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Opacity(
                  opacity: _opacityAnimation.value, // Fade in effect
                  child: ScaleTransition(
                    scale: _scaleAnimation, // Zoom in effect
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/dorts_image.svg",
                          width: 300,
                          height: 300,
                          fit: BoxFit.cover,
                        ),
                        // Foreground image (Correct Sign)
                        SvgPicture.asset(
                          "assets/correct_sign.svg",
                          width: 200,
                          height: 200,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            Text(
              "Payment Completed\nSuccessfully!",
              textAlign: TextAlign.center, // Centers the text
              style: AppTextStyle.getTextStyle28FontWeightw600FabricColor,
            ),
          ],
        ),
      ),
    );
  }
}


