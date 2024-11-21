import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:salon_app/service_provider_details/sp_detail_viewmodel.dart';

import '../../home_screen/home_screen_viewmodel.dart';
import '../../models/panel.dart';
import '../../utils/common_variables.dart';
import '../../utils/constants.dart';
import '../../utils/sp_helper.dart';
import '../../widget/snack_bar_widget.dart';

class BookingScreen2ViewModel extends ChangeNotifier {
  late SPDetailViewModel beautySalonViewModel;
  late HomeScreenViewModel homePageViewModel;

  final SharedPreferenceService sharedPreferenceService = SharedPreferenceService();

  int salonServicesIndex = 0;
  int serviceIndex = 0;

  // Calculate the total price of selected services
  int calculateServicesPrice() {
    int totalPrice = 0;
    for (var service in beautySalonViewModel.selectedServices) {
      totalPrice += int.tryParse(service['prices'] ?? '0') ?? 0;
    }
    return totalPrice;
  }

  // Calculate the total price including platform fees
  int calculateTotalPrice() {
    int basePlatformFee = 50;
    return basePlatformFee + calculateServicesPrice();
  }

  int? bookingId;

  // Function to make the booking API call
  Future<void> bookAppointment({
    required int userId,
    required String scheduledDate,
    required int status,
  }) async {
    if (beautySalonViewModel.selectedServices.isEmpty ) {
      print('No services selected or invalid data.');
      return;
    }

    try {
      // Loop through the selected services and make separate API requests for each
      for (var service in beautySalonViewModel.selectedServices) {
        final Map<String, dynamic> requestBody = {
          'userId': userId,
          'scheduled_date': scheduledDate,
          'service_provider_id': serviceProviderId,
          'panel_id':  service["panelId"],
          'price': service["prices"], // Send the specific service price here
          'status': status,
          'serviceId': service["id"], // Send the specific service ID here
        };

        // Make the API call
        var response = await http.post(
          Uri.parse('$BASE_URL/bookings'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(requestBody),
        );

        if (response.statusCode == 201) {
          final bookingData = jsonDecode(response.body);
          bookingId = bookingData['bookingId'];
          print(bookingId);
          print('Booking successful for : ${bookingData['bookingId']}');
        } else {
          print('Failed to create booking  Error: ${response.body}');
        }
      }
    } catch (error) {
      print('Error creating booking: $error');
    }
  }





  // Refresh the UI
  void refreshUI() {
    notifyListeners();
  }


}

//homePageViewModel.services.map((service) => service.id).toList(),