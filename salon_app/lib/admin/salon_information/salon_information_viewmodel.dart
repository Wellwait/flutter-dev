import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../services/services.dart';

class SalonInformationViewModel extends ChangeNotifier {
  bool showProgressbar = false;
  final List<String> days = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];
  List<bool> checkboxStates = List.generate(7, (index) => false);
  bool firstAdditionalCheckboxSelected = false;
  bool secondAdditionalCheckboxSelected = false;
  TimeOfDay? openingTime;
  TimeOfDay? closingTime;
  TimeOfDay? lunchStartTime;
  TimeOfDay? lunchEndTime;
  bool isAllSelected = false;
  final ApiService services = ApiService();

  // Function to toggle the selection of all checkboxes
  void toggleSelectAll() {
    isAllSelected = !isAllSelected;
    for (int i = 0; i < checkboxStates.length; i++) {
      checkboxStates[i] = isAllSelected;
    }
    notifyListeners(); // Notify listeners to rebuild UI
  }

  void refreshUI() {
    notifyListeners();
  }

  Future<void> fetchData(
      int salonId,
      String day,
      TimeOfDay startTime,
      TimeOfDay endTime,
      TimeOfDay? lunchStart,
      TimeOfDay? lunchEnd,
      ) async {
    showProgressbar = true;
    notifyListeners();
    // Convert TimeOfDay to string
    final startTimeString = '${startTime.hour}:${startTime.minute}';
    final endTimeString = '${endTime.hour}:${endTime.minute}';
    final lunchStartString = lunchStart != null ? '${lunchStart.hour}:${lunchStart.minute}' : null;
    final lunchEndString = lunchEnd != null ? '${lunchEnd.hour}:${lunchEnd.minute}' : null;

    final response = await services.addSalonTiming(
      salonId: salonId,
      day: day,
      startTime: startTimeString,
      endTime: endTimeString,
      lunchStart: lunchStartString,
      lunchEnd: lunchEndString,
    );

    if (response.containsKey('error') && response['error'] == true) {
      print('Error: ${response['message']}');
    } else {
      print('Success: Salon timing added successfully: ${response['id']}');
    }
    showProgressbar = false;
    notifyListeners();
  }
}
