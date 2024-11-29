import 'dart:convert';
import 'dart:typed_data'; // For Uint8List
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // For mobile image picker
import 'package:image_picker_web/image_picker_web.dart'; // For web image picker
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../services/services.dart'; // Custom service API
import '../../utils/constants.dart';
import '../admin_email_login/admin_email_login_viewmodel.dart'; // For BASE_URL or other constants


class SalonServiceViewModel extends ChangeNotifier {

  late AdminEmailLoginViewModel adminEmailLoginViewModel;
  Uint8List? selectedImage;
  List<Uint8List> selectedServiceProviderImage = [];
  List<Uint8List> selectedServiceProviderBanner = [];
  String imageName = "";
  String serviceProviderImageName = "";
  String serviceProviderBannerName = "";
  final TextEditingController priceController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();
  final ApiService servicesAPI = ApiService();

  Map<String, List<Map<String, String>>> services = {
    'Women': [],
    'Men': [],
    'Kids': [],
  };

  // Image Pick in the Upload Salon Service
  Future<void> pickServiceProviderImage() async {
    final serviceProviderId = adminEmailLoginViewModel.serviceProviderId;
    final image = await ImagePickerWeb.getImageAsBytes();
    if (image != null) {
      selectedServiceProviderImage.add(image);
      notifyListeners();
        print("Salon Services Provider Image picked successfully.");
        await uploadImageServiceProvider();
        print("call uploadImageServiceProvider api ");
        await uploadServiceProviderImage(serviceProviderId!,serviceProviderImageName);
        print("service providerId: ${serviceProviderId}");
        notifyListeners();
    }
  }

  Future<void> uploadImageServiceProvider() async {
    if (selectedServiceProviderImage.isEmpty) {
      print("No image selected");
      return;
    }

    try {
      var uri = Uri.parse('$BASE_URL/upload_image');
      var request = http.MultipartRequest('POST', uri);

      // Add the selected image file
      request.files.add(http.MultipartFile.fromBytes(
        'image', // Field name in the backend
        selectedServiceProviderImage[0],
        filename: 'uploaded_image.jpg', // Optional: set filename
      ));

      // Send the request
      var response = await request.send();
      var responseString = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        final responseData = jsonDecode(responseString);
        print("Image uploaded successfully: $responseData");

        // Extract file name from the response
        if (responseData.containsKey('filePath')) {
          final filePath = responseData['filePath'].toString();
          serviceProviderImageName = filePath.split('/').last;
          print("upload serviceProviderImageName : ${serviceProviderImageName}");
          notifyListeners();
        }
      } else {
        print("Failed to upload image: $responseString");
      }
    } catch (error) {
      print("Error occurred while uploading image: $error");
    }
    notifyListeners();
  }



  Future<void> pickServiceProviderBanner() async {
    final serviceProviderId = adminEmailLoginViewModel.serviceProviderId;
    final image = await ImagePickerWeb.getImageAsBytes();
    if (image != null) {
      selectedServiceProviderBanner.add(image);
      notifyListeners();
      print("Salon Services Provider Banner picked successfully.");
      await uploadImageServiceProviderBanner();
      print("call uploadImageServiceProviderBanner api ");
      await uploadServiceProviderBanner(serviceProviderId!,serviceProviderBannerName);
      print("service providerId: ${serviceProviderId}");
      notifyListeners();
    }
  }


  Future<void> uploadImageServiceProviderBanner() async {
    if (selectedServiceProviderBanner.isEmpty) {
      print("No image selected");
      return;
    }

    try {
      var uri = Uri.parse('$BASE_URL/upload_image');
      var request = http.MultipartRequest('POST', uri);

      // Add the selected image file
      request.files.add(http.MultipartFile.fromBytes(
        'image', // Field name in the backend
        selectedServiceProviderBanner[0],
        filename: 'uploaded_image.jpg', // Optional: set filename
      ));

      // Send the request
      var response = await request.send();
      var responseString = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        final responseData = jsonDecode(responseString);
        print("Image uploaded successfully: $responseData");

        // Extract file name from the response
        if (responseData.containsKey('filePath')) {
          final filePath = responseData['filePath'].toString();
          serviceProviderBannerName = filePath.split('/').last;
          print("upload serviceProviderBanner Name  : ${serviceProviderBannerName}");
          notifyListeners();
        }
      } else {
        print("Failed to upload image: $responseString");
      }
    } catch (error) {
      print("Error occurred while uploading image: $error");
    }
    notifyListeners();
  }


  Future<void> fetchData(
      String category,
      String name,
      String price,
      ) async {
    // Convert the price to double
    final parsedPrice = double.tryParse(price) ?? 0.0;
    final serviceProviderId = adminEmailLoginViewModel.serviceProviderId;

    final response = await servicesAPI.addService(
      category: category,
      name: name,
      price: parsedPrice,
      imageUrl: imageName,
      serviceProviderId: serviceProviderId!,
    );
    if (response.containsKey('error') && response['error'] == true) {
      print('Error: ${response['message']}');
    } else {
      services[category]?.add({
        'name': name,
        'price': price,
        'imageUrl': imageName,
      });
      print('Service added successfully!');
    }

    notifyListeners();
  }


  // Web: Pick a single image
  Future<void> pickImage() async {
    final image = await ImagePickerWeb.getImageAsBytes();
    if (image != null) {
        selectedImage = image;
        notifyListeners();
        print("Image picked successfully. Uploading...");
        await uploadImage();
        notifyListeners();
    }
  }

  // Upload image
  Future<void> uploadImage() async {
    if (selectedImage == null) {
      print("No image selected");
      return;
    }

    try {
      var uri = Uri.parse('$BASE_URL/upload_image');
      var request = http.MultipartRequest('POST', uri);

      // Add the selected image file
      request.files.add(http.MultipartFile.fromBytes(
        'image', // Field name in the backend
        selectedImage!,
        filename: 'uploaded_image.jpg', // Optional: set filename
      ));

      // Send the request
      var response = await request.send();
      var responseString = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        final responseData = jsonDecode(responseString);
        print("Image uploaded successfully: $responseData");

        // Extract file name from the response
        if (responseData.containsKey('filePath')) {
          final filePath = responseData['filePath'].toString();
          imageName = filePath.split('/').last;
          print("upload image name : ${imageName}");
          notifyListeners();
        }
      } else {
        print("Failed to upload image: $responseString");
      }
    } catch (error) {
      print("Error occurred while uploading image: $error");
    }
    notifyListeners();
  }

  Future<bool> uploadServiceProviderImage(int serviceProviderId, String imageUrl) async {
    final success = await servicesAPI.uploadServiceProviderImage(serviceProviderId, imageUrl);
    if (success) {
      notifyListeners(); // Update UI if needed
    }
    return success;
  }

  Future<bool> uploadServiceProviderBanner(int serviceProviderId, String imageUrl) async {
    final success = await servicesAPI.uploadServiceProviderBanner(serviceProviderId, imageUrl);
    if (success) {
      notifyListeners(); // Update UI if needed
    }
    return success;
  }


  void refreshUI() {
    notifyListeners();
  }
}
