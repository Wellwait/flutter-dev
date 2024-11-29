import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../models/booking.dart';
import '../services/services.dart';

class QueueViewModel extends ChangeNotifier {

  // Track the selected index
  int? selectedIndex;
  final ApiService apiService = ApiService();
  String formattedDate = DateFormat('d MMM yyyy').format(DateTime.now());

  List<Booking> bookings = [];
  bool isLoading = false;
  String? errorMessage;
  int selectIndex = 0;

  Future<void> fetchData(int serviceProviderId) async {
    isLoading = true;
    notifyListeners();

    try {
      bookings = await apiService.fetchBookings(serviceProviderId);
      errorMessage = null; // Clear any previous error
    } catch (e) {
      errorMessage = e.toString(); // Handle the error
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> cancelBooking(int bookingId) async {
    isLoading = true; // Start loading
    notifyListeners();

    try {
      await apiService.cancelBooking(bookingId); // Call API to cancel booking
      // Remove booking from the list
      bookings.removeWhere((booking) => booking.id == bookingId);
      errorMessage = null; // Clear any previous error
    } catch (e) {
      errorMessage = e.toString(); // Handle the error
    } finally {
      isLoading = false; // Stop loading
      notifyListeners(); // Refresh UI
    }
  }


  refreshUI() {
    notifyListeners();
  }

}
