import 'dart:io';

import 'package:flutter/cupertino.dart';

class ScheduleViewModel extends ChangeNotifier {

  final List<Map<String, dynamic>> cardData = [
    {
      'image': 'assets/icons/gallery2.png',
      'service': 'Manicure',
      'status': 'Successfully',
      'description': 'Service Done',
      'salonName': 'Beauty Salon',
      'address': 'XYZ address',
      'rating': '4.7 (2.3k ratings)',
    },
    {
      'image': 'assets/icons/gallery3.png',
      'service': 'Pedicure',
      'status': 'Completed',
      'description': 'Service Done',
      'salonName': 'Beauty Haven',
      'address': '123 Beauty St',
      'rating': '4.8 (1.5k ratings)',
    },
    {
      'image': 'assets/icons/gallery4.png',
      'service': 'Facial',
      'status': 'Successfully',
      'description': 'Service Done',
      'salonName': 'Glow Spa',
      'address': '456 Glow Rd',
      'rating': '4.9 (3k ratings)',
    },
    // Add more card data here
  ];

  refreshUI() {
    notifyListeners();
  }

}
