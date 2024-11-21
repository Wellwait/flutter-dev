import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../services/services.dart';
import '../admin_email_login/admin_email_login_viewmodel.dart';

class SalonServiceViewModel extends ChangeNotifier {
  // List to store selected images
  List<XFile> selectedImages = [];
  List<XFile> selectedBannerImages = [];
  final ImagePicker _imagePicker = ImagePicker();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();

  Map<String, List<Map<String, String>>> services = {
    'Women': [],
    'Men': [],
    'Kids': [],
  };

  final ApiService servicesAPI = ApiService();

  Future<void> pickImages() async {
    final List<XFile>? pickedFiles = await _imagePicker.pickMultiImage();
    if (pickedFiles != null) {
      selectedImages.addAll(pickedFiles); // Add the selected images to the list
      notifyListeners();
    }
  }

  Future<void> pickBannerImages() async {
    final List<XFile>? images = await _imagePicker.pickMultiImage();
    if (images != null) {
      selectedBannerImages.addAll(images);
      notifyListeners();
    }
  }


  Future<void> fetchData(
      String category,
      String name,
      String price,
      String imageUrl,
      BuildContext context,
      ) async {
    // Convert the price to double
    final parsedPrice = double.tryParse(price) ?? 0.0;
    final serviceProviderId = Provider.of<AdminEmailLoginViewModel>(context, listen: false).serviceProviderId;

    final response = await servicesAPI.addService(
      category: category,
      name: name,
      price: parsedPrice,
      imageUrl: imageUrl,
      serviceProviderId: serviceProviderId!,
    );
    if (response.containsKey('error') && response['error'] == true) {
      print('Error: ${response['message']}');
    } else {
      services[category]?.add({
        'name': name,
        'price': price,
        'imageUrl': imageUrl,
      });
      print('Service added successfully!');
    }

    notifyListeners();
  }

  void refreshUI() {
    notifyListeners();
  }
}
