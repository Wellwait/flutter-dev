import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salon_app/admin/salon_service/salon_service_viewmodel.dart';
import 'package:salon_app/utils/colors.dart';
import '../../utils/app_strings.dart';
import '../../utils/app_text_style.dart';
import '../../widget/custom_button.dart';

class SalonServicePage extends StatefulWidget {
  final Function()? onNext;
  final Function()? onBack; // Add this line

  const SalonServicePage({super.key, this.onNext, this.onBack});

  @override
  State<SalonServicePage> createState() => _SalonServicePageState();
}

class _SalonServicePageState extends State<SalonServicePage> {
  late SalonServiceViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    _viewModel = context.watch<SalonServiceViewModel>();
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 30),
          Center(
            child: Text(
              AppString.salonServices,
              style: AppTextStyle.getTextStyle18FontWeightw600FabricColor,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppString.uploadSalonPhotos,
                          style: AppTextStyle.getTextStyle20FontWeightBold,
                        ),
                        const SizedBox(height: 10),
                        // Container for uploading and displaying multiple salon photos
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Colors.black54,
                              width: 1,
                            ),
                          ),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                // Display selected images as a list
                                ..._viewModel.selectedImages.map(
                                      (image) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 118,
                                      height: 117,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: FileImage(File(image.path)),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ).toList(),
                                GestureDetector(
                                  onTap: _viewModel.pickImages,
                                  child: Container(
                                    margin: const EdgeInsets.all(14),
                                    padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
                                    decoration: BoxDecoration(
                                      color: const Color(0xffEDF6F6),
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: fabricColor,
                                        width: 1,
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        const Icon(Icons.camera_alt_outlined, color: fabricColor, size: 35),
                                        const SizedBox(width: 8),
                                        Text(
                                          AppString.addPhotos,
                                          style: AppTextStyle.getTextStyle14FontWeightw400FabricColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          AppString.addBanner,
                          style: AppTextStyle.getTextStyle20FontWeightBold,
                        ),
                        const SizedBox(height: 10),
                        // Container for uploading and displaying multiple banner images
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Colors.black54,
                              width: 1,
                            ),
                          ),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                // Display selected banner images as a list
                                ..._viewModel.selectedBannerImages.map(
                                      (image) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 118,
                                      height: 117,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: FileImage(File(image.path)),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ).toList(),
                                GestureDetector(
                                  onTap: _viewModel.pickBannerImages,
                                  child: Container(
                                    margin: const EdgeInsets.all(14),
                                    padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
                                    decoration: BoxDecoration(
                                      color: const Color(0xffEDF6F6),
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: fabricColor,
                                        width: 1,
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        const Icon(Icons.camera_alt_outlined, color: fabricColor, size: 35),
                                        const SizedBox(width: 8),
                                        Text(
                                          AppString.addPhotos,
                                          style: AppTextStyle.getTextStyle14FontWeightw400FabricColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppString.addServices,
                                style: AppTextStyle.getTextStyle20FontWeightBold,
                              ),
                              const SizedBox(height: 10),
                              buildCategorySection('Women'),
                              const SizedBox(height: 10),
                              buildCategorySection('Men'),
                              const SizedBox(height: 10),
                              buildCategorySection('Kids'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 15,right: 15,bottom: 20),
            child: Row(
              children: [
                Expanded(
                  child: CustomButtonWidget(
                    text: AppString.back,
                    textColor: Colors.black,
                    onPressed: () {
                      //Navigator.pop(context);
                      widget.onBack?.call();
                    },
                    buttonColor: Colors.white,
                    borderRadius: 5,
                    buttonHeight: 40,
                    borderColor: Colors.black54,
                    buttonWidth: 1,
                  ),
                ),
                const SizedBox(width: 25),
                Expanded(
                  child: CustomButtonWidget(
                    text: AppString.next,
                    textColor: Colors.white,
                    onPressed: () {
                      widget.onNext?.call();
                    },
                    buttonColor: fabricColor,
                    borderRadius: 5,
                    buttonHeight: 40,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategorySection(String category) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          category,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ..._viewModel.services[category]!.map((service) {
                // Ensure the service contains 'name', 'price', and 'imageUrl' keys
                String serviceFor = service['name'] ?? 'Unknown Service';
                String price = service['price']?.toString() ?? 'N/A';
                String imageUrl = service['imageUrl'] ?? 'default_image_url.png'; // Replace with a default image if not available

                return buildServiceForButton(
                  serviceFor: serviceFor,
                  price: price,
                  imageUrl: imageUrl,
                  containerColor: const Color(0xffE6F4F4),
                  textColor: fabricColor,
                );
              }).toList(),
              buildServiceForButton(
                serviceFor: '+ add',
                price: '', // Add an empty price for the add button
                imageUrl: 'default_add_image_url.png', // Use a default image for the add button
                containerColor: Colors.white,
                textColor: Colors.black,
                isAddButton: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildServiceForButton({
    required String serviceFor,
    required String price,
    required String imageUrl,
    required Color containerColor,
    required Color textColor,
    FontWeight fontWeight = FontWeight.w700,
    bool isAddButton = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(right: 6),
      child: ElevatedButton(
        onPressed: () {
          if (isAddButton) {
            _openAddServiceDialog(); // Open the dialog for adding a service
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: containerColor,
          foregroundColor: textColor,
          side: const BorderSide(color: Colors.teal),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          padding: const EdgeInsets.symmetric(horizontal: 0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!isAddButton) ...[
              // textSpan('Service Name: ','$serviceFor'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  serviceFor,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Outfit',
                    fontSize: 14,
                  ),
                ),
              ),
            ],
            if (isAddButton)
              Text(
                serviceFor,
                style: AppTextStyle.getTextStyle14FontWeightw400FabricColor,
              ),
          ],
        ),
      ),
    );
  }


  Future<void> _openAddServiceDialog() async {
    String newService = '';
    String servicePrice = '';
    String promoImageUrl = '';
    String? selectedCategory = 'Women'; // Default selected category

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Add Service'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Dropdown for Category Selection
                    SizedBox(
                      width: double.infinity,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        child: DropdownButton<String>(
                          value: selectedCategory,
                          isExpanded: true,
                          underline: SizedBox(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedCategory = newValue!;
                            });
                          },
                          items: <String>['Women', 'Men', 'Kids']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // TextField for Service Name
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Service Name',
                        hintText: 'Enter service name',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          newService = value;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    // TextField for Price
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Price',
                        hintText: 'Enter price',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          servicePrice = value;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    // TextField for Promo Image URL
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Promo Image URL',
                        hintText: 'Enter image URL',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          promoImageUrl = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close dialog without adding
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (newService.isNotEmpty &&
                        servicePrice.isNotEmpty &&
                        promoImageUrl.isNotEmpty &&
                        selectedCategory != null) {
                      // Call the API to add the service
                      _viewModel.fetchData(
                        selectedCategory!,
                        newService,
                        servicePrice,
                        promoImageUrl,
                        context
                      );
                      Navigator.of(context).pop(); // Close the dialog
                    }
                  },
                  child: const Text('Add Service'),
                ),
              ],
            );
          },
        );
      },
    );
  }

}
