import 'package:flutter/cupertino.dart';

import '../email_login/email_login_viewmodel.dart';
import '../models/booking.dart';
import '../models/salon_services.dart';
import '../services/services.dart';
import '../utils/common_variables.dart';

class BookingPendingViewModel extends ChangeNotifier {
  List<Booking> bookings = [];
  bool isLoading = false;
  String? errorMessage;
  final ApiService apiService = ApiService();
  List<ServicesProvider> serviceProvider = [];

  int selectedIndex = 0;

  Future<void> fetchData() async {
    isLoading = true;
    notifyListeners();

    try {
      bookings = await apiService.bookingPending(userId!);
      errorMessage = null; // Clear any previous error
    } catch (e) {
      errorMessage = e.toString(); // Handle the error
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchSalonServiceProvidersById(int id) async {
    isLoading = true;
    notifyListeners();
    try {
      serviceProvider = await apiService.fetchSalonServiceProviderById(id);
      print('service_provider: ${serviceProvider}');
    } catch (e) {
      print("Error fetching salon service providers: $e");
    }
    isLoading = false;
    notifyListeners();
  }

  void refreshUI() {
    notifyListeners();
  }
}