import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../models/booking.dart';
import '../models/categories.dart';
import '../models/count.dart';
import '../models/favorite.dart';
import '../models/panel.dart';
import '../models/salon_services.dart';
import '../models/salon_timing.dart';
import '../models/services.dart';
import '../utils/common_variables.dart';
import '../utils/constants.dart';

class ApiService {

  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse('$BASE_URL/login'),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // Parse and return the response body
      return jsonDecode(response.body);
    } else {
      throw Exception('Login failed: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> loginPartner(String email, String password) async {
    final response = await http.post(
      Uri.parse('$BASE_URL/loginpartner'),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // Parse and return the response body
      return jsonDecode(response.body);
    } else {
      throw Exception('Login failed: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> updateServiceProviderDocuments({
    required int id,
    required String panCard,
    required String gstIn,
    required String bankAccountNumber,
    required String bankIfscCode,
  }) async {
    final url = Uri.parse('$BASE_URL/update_service_provider_bank_details/$id');

    try {
      final body = {
        'pan_card': panCard,
        'gst_in': gstIn,
        'bank_account_number': bankAccountNumber,
        'bank_ifsc_code': bankIfscCode,
      };

      // Make the PUT request
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      // Handle the response
      if (response.statusCode == 200) {
        return jsonDecode(response.body); // Return response data
      } else {
        return {
          'error': true,
          'message': 'Error: ${response.body}',
        };
      }
    } catch (error) {
      return {
        'error': true,
        'message': 'Error: $error',
      };
    }
  }

  Future<Map<String, dynamic>> addService({
    required String category,
    required String name,
    required double price,
    required String imageUrl,
    required int serviceProviderId,
  }) async {
    final url = Uri.parse('$BASE_URL/services/servicespartner');

    // Prepare request body
    final body = {
      'name': name,
      'category': category,
      'price': price,
      'promo_image': imageUrl,
      'rating': 0, // Default rating
      'category_type': category,
      'service_provider_id': serviceProviderId,
    };

    try {
      // Make POST request
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      // Handle response
      if (response.statusCode == 201) {
        return jsonDecode(response.body); // Success
      } else {
        return {
          'error': true,
          'message': jsonDecode(response.body)['error'],
        }; // Error
      }
    } catch (error) {
      return {
        'error': true,
        'message': 'Error occurred: $error',
      };
    }
  }

  Future<Map<String, dynamic>> addSalonTiming({
    required int salonId,
    required String day,
    required String startTime,
    required String endTime,
    String? lunchStart,
    String? lunchEnd,
  }) async {
    final url = Uri.parse('$BASE_URL/addSalonTiming');

    try {
      // Prepare request body
      final body = {
        'salon_id': salonId,
        'day': day,
        'start_time': startTime,
        'end_time': endTime,
        'lunch_start': lunchStart,
        'lunch_end': lunchEnd,
      };

      // Make POST request
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      // Handle response
      if (response.statusCode == 201) {
        return jsonDecode(response.body); // Success: return response data
      } else {
        return {
          'error': true,
          'message': jsonDecode(response.body)['error'],
        }; // Error: return error message
      }
    } catch (error) {
      return {
        'error': true,
        'message': 'Error occurred: $error',
      };
    }
  }



  Future<void> updateServiceProvider(int id, String name, String salonName, String address, String email, String mobileNumber) async {
    final url = Uri.parse('$BASE_URL/update_service_provider_info/$id');

    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': name,
        'salon_name': salonName,
        'address': address,
        'email': email,
        'mobile_number': mobileNumber,
      }),
    );

    if (response.statusCode == 200) {
      // Handle success
    } else {
      // Handle error
      throw Exception('Failed to update service provider: ${response.body}');
    }
  }


  // Method to fetch subcategories from the API
  Future<List<Subcategories>> subcategories() async {
    final response = await http.get(Uri.parse('$BASE_URL/subcategories'));

    if (response.statusCode == 200) {
      print("SubCategories response: ${response.body}");
      // Parse the response and map it to the model
      return allTestFromJson(response.body);
    } else {
      throw Exception('Failed to fetch subcategories: ${response.statusCode}');
    }
  }


  // Method to fetch subcategories from the API
  Future<List<Favorite>> getMyFavorite() async {
    final response = await http.get(Uri.parse('$BASE_URL/getmyfavorite?user_id=$userId'));

    if (response.statusCode == 200) {
      // Parse the response and map it to the model
      return favoriteFromJson(response.body);
    } else {
      throw Exception('Failed to fetch subcategories: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> addToFavorite({required int serviceProviderId}) async {
    final url = Uri.parse('$BASE_URL/addmyfavorite');
    try {
      final body = {'user_id': userId, 'service_provider_id': serviceProviderId };
      final response = await http.post(url, headers: {'Content-Type': 'application/json',},body: jsonEncode(body),
      );

      print(body);
      print('Response Status Code: ${response.statusCode}');
      if (response.statusCode == 200) {
        print(response.statusCode);
        return jsonDecode(response.body); // Success: return response data
      } else {
        print('Error');
        return {
          'error': true,
          'message': jsonDecode(response.body)['error'],
        }; // Error: return error message
      }
    } catch (error) {
      return {
        'error': true,
        'message': 'Error occurred: $error',
      };
    }
  }





  // Method to fetch service providers
  Future<List<ServicesProvider>> fetchSalonServiceProviders() async {
    final url = Uri.parse('$BASE_URL/salon_service_providers');
    final response = await http.get(url);

    // Print the status code and response body for debugging
    print('Status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((service) => ServicesProvider.fromJson(service)).toList();
    } else {
      throw Exception('Failed to load service providers: ${response.statusCode}');
    }
  }


  Future<List<ServicesProvider>> fetchSalonServiceProviderById(int id) async {
    final url = Uri.parse('$BASE_URL/get_service_provider_by_id/$id');
    final response = await http.get(url);

    // Print the status code and response body for debugging
    print('Status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((service) => ServicesProvider.fromJson(service)).toList();
    } else {
      throw Exception('Failed to load service providers: ${response.statusCode}');
    }
  }


  // Method to fetch services from the API
  Future<List<Services>> services() async {
    final response = await http.get(Uri.parse('$BASE_URL/services'));

    if (response.statusCode == 200) {
      // Parse the response and map it to the model
      print(response.body);
      return servicesFromJson(response.body);
    } else {
      throw Exception('Failed to fetch services: ${response.statusCode}');
    }
  }

  Future<void> increaseViewCount(int service_provider_id) async {
    final url = '$BASE_URL/increase_view_count/$service_provider_id';
    final response = await http.put(Uri.parse(url));

    if (response.statusCode != 200) {
      throw Exception('Failed to increase view count');
    }
  }


  Future<List<Panel>> fetchPanels(int serviceProviderId) async {
    final response = await http.get(Uri.parse('$BASE_URL/panels/$serviceProviderId'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((json) => Panel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load panels: ${response.statusCode}');
    }
  }

  Future<Count> getBookingCount(int panelId) async {
    DateTime now = DateTime.now();
    String scheduledDate = DateFormat('yyyy-MM-dd').format(now);
    final response = await http.get(Uri.parse('$BASE_URL/bookings/count?scheduled_date=$scheduledDate&panel_id=$panelId'));

    if (response.statusCode == 200) {
      return countFromJson(response.body); // Parse JSON to Count object
    } else {
      throw Exception('Failed to load booking count');
    }
  }

  Future<List<SalonTiming>> fetchSalonTimings(String salonId) async {
    String day = _getDayOfWeek(DateTime.now().weekday);
    final response = await http.get(Uri.parse('$BASE_URL/salon_timings/$salonId/$day'));

    if (response.statusCode == 200) {
      // Decode the response body to List and map to SalonTiming objects
      List<dynamic> jsonResponse = json.decode(response.body);
      return List<SalonTiming>.from(jsonResponse.map((json) => SalonTiming.fromJson(json)));
    } else {
      throw Exception('Failed to load salon timings');
    }
  }

  String _getDayOfWeek(int weekday) {
    switch (weekday) {
      case 1: return "Monday";
      case 2: return "Tuesday";
      case 3: return "Wednesday";
      case 4: return "Thursday";
      case 5: return "Friday";
      case 6: return "Saturday";
      case 7: return "Sunday";
      default: return "";
    }
  }

  Future<List<Booking>> fetchBookings(int serviceProviderId) async {
    // Construct the query parameters
    DateTime now = DateTime.now();
    String scheduledDate = DateFormat('yyyy-MM-dd').format(now);
    final Uri uri = Uri.parse('$BASE_URL/booking')
        .replace(queryParameters: {
      'scheduled_date': scheduledDate,
      'service_provider_id': serviceProviderId.toString()
    });

    // Make the GET request
    final response = await http.get(uri);

    // Check if the request was successful
    if (response.statusCode == 200) {
      // Parse the JSON response and map it to a list of Booking objects
      print(response.body);
      return bookingFromJson(response.body);
    } else {
      // If the request fails, throw an exception with the error message
      throw Exception('Failed to load bookings: ${response.body}');
    }
  }

  Future<List<Booking>> fetchPastBooking() async {
    final Uri uri = Uri.parse('$BASE_URL/past_booking');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      print(response.body);
      return bookingFromJson(response.body);
    } else {
      throw Exception('Failed to load bookings: ${response.body}');
    }
  }

  Future<List<Booking>> bookingPending(int userId) async {
    DateTime now = DateTime.now();
    String scheduledDate = DateFormat('yyyy-MM-dd').format(now);
    final Uri uri = Uri.parse('$BASE_URL/booking_pending?scheduled_date=$scheduledDate&userId=$userId');
    print("http call");
    final response = await http.get(uri);
    print(response);
    if (response.statusCode == 200) {
      print(response.body);
      return bookingFromJson(response.body);
    } else {
      throw Exception('Failed to load bookings: ${response.body}');
    }
  }



  Future<void> cancelBooking(int bookingId) async {
    final response = await http.put(
      Uri.parse('$BASE_URL/cancel_booking/$bookingId/status'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to cancel booking: ${response.body}');
    }
  }

  Future<void> updateBookingStarted(int id) async {
    final url = Uri.parse('$BASE_URL/update_booking_started/$id');

    // Create the request payload
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    // Handle the response
    if (response.statusCode == 200) {
      // Booking updated successfully
      print('Booking updated successfully');
    } else if (response.statusCode == 404) {
      throw Exception('Booking not found');
    } else {
      throw Exception('Failed to update booking');
    }
  }

  Future<void> updateBookingFinished(int id) async {
    final url = Uri.parse('$BASE_URL/update_booking_finished/$id');

    // Create the request payload
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    // Handle the response
    if (response.statusCode == 200) {
      // Booking updated successfully
      print('Booking updated successfully');
    } else if (response.statusCode == 404) {
      throw Exception('Booking not found');
    } else {
      throw Exception('Failed to update booking');
    }
  }

  Future<bool> uploadServiceProviderImage(int serviceProviderId, String imageUrl) async {
    final url = Uri.parse('$BASE_URL/service_provider_image');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'service_provider_id': serviceProviderId,
          'image_url': imageUrl,
        }),
      );

      if (response.statusCode == 200) {
        print("Response: ${response.body}");
        return true;
      } else {
        print("Error: ${response.body}");
        return false;
      }
    } catch (error) {
      print("Exception: $error");
      return false;
    }
  }

  Future<bool> uploadServiceProviderBanner(int serviceProviderId, String imageUrl) async {
    final url = Uri.parse('$BASE_URL/service_provider_banner');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'service_provider_id': serviceProviderId,
          'image_url': imageUrl,
        }),
      );

      if (response.statusCode == 200) {
        print("Response: ${response.body}");
        return true;
      } else {
        print("Error: ${response.body}");
        return false;
      }
    } catch (error) {
      print("Exception: $error");
      return false;
    }
  }

  Future<bool> updateUserPhoto(String photo) async {
    final url = Uri.parse('$BASE_URL/update_user_photo');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'id': userId,
          'photo': photo,
        }),
      );

      if (response.statusCode == 200) {
        print("Response: ${response.body}");
        return true;
      } else {
        print("Error: ${response.body}");
        return false;
      }
    } catch (error) {
      print("Exception: $error");
      return false;
    }
  }

  // Future<List<ServiceProviderImage>> fetchServiceProviderImages() async {
  //   final url = Uri.parse('$BASE_URL/get_service_provider_images');
  //   try {
  //     final response = await http.get(url);
  //
  //     if (response.statusCode == 200) {
  //       // Decode response body and map to list of ServiceProviderImage objects
  //       final List<dynamic> data = json.decode(response.body);
  //       return data.map((item) => ServiceProviderImage.fromJson(item)).toList();
  //     } else {
  //       throw Exception(
  //         'Failed to fetch service provider images. Status code: ${response.statusCode}',
  //       );
  //     }
  //   } catch (e) {
  //     throw Exception('Failed to fetch service provider images: $e');
  //   }
  // }

}
