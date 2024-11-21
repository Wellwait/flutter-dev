import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:salon_app/service_provider_details/sp_detail_viewmodel.dart';
import 'package:salon_app/utils/colors.dart';
import '../../booked/booked_screen.dart';
import '../../email_login/email_login_viewmodel.dart';
import '../../home_screen/home_screen_viewmodel.dart';
import '../../models/panel.dart';
import '../../utils/app_text_style.dart';
import '../../utils/common_variables.dart';
import '../../widget/custom_button.dart';
import '../../widget/snack_bar_widget.dart';
import 'booking_screen2_viewmodel.dart';

class BookingScreen2Top extends StatefulWidget {
  final List<Map<String, String>> selectedServices;
  final String salonName;
  final String address;
  final String imagePath;
  final String scheduledDate;

  BookingScreen2Top({
    Key? key,
    required this.selectedServices,
    required this.salonName,
    required this.address,
    required this.imagePath,
    required this.scheduledDate,
  }) : super(key: key);

  @override
  State<BookingScreen2Top> createState() => _BookingScreen2TopState();
}

class _BookingScreen2TopState extends State<BookingScreen2Top> {
  late BookingScreen2ViewModel _viewModel;
  List<Map<String, String>> _selectedServices = [];

  @override
  void initState() {
    super.initState();
    _selectedServices = widget.selectedServices;
  }
  List<String> uniqueIds = [];

  @override
  Widget build(BuildContext context) {
    _viewModel = context.watch<BookingScreen2ViewModel>();
    _viewModel.beautySalonViewModel = context.watch<SPDetailViewModel>();
    _viewModel.homePageViewModel = Provider.of<HomeScreenViewModel>(context, listen: false);
    uniqueIds = [];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new,color: Colors.black,),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(right: 16,left: 16,bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                height: 150,
                fit: BoxFit.cover,
                imageUrl: widget.imagePath,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                        colorFilter:
                        const ColorFilter.mode(Colors.transparent, BlendMode.colorBurn)),
                  ),
                ),
                placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.salonName,
                      style: AppTextStyle.getTextStyle22FontWeightw600,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.address,
                      style: AppTextStyle.getTextStyle16FontWeightw300,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.yellow.shade600,
                      size: 24,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "4.7 (2.3k ratings)",
                      style: AppTextStyle.getTextStyle14FontWeightw400B,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30),
            Text(
              "Your Services Booking",
              style: AppTextStyle.getTextStyle18FontWeightBold,
            ),
            const SizedBox(height: 16),
            // Loop through selectedServices to display each service
            ...widget.selectedServices.map((service) => Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      service['imagePath']!, // Access image path from service map
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          service['services']!, // Access title from service map
                          style: AppTextStyle.getTextStyle16FontWeightw600,
                        ),
                        const SizedBox(height: 8),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: service['prices']!, // Access subtitle from service map
                                style: AppTextStyle.getTextStyle14FontWeightw600FabricColor,
                              ),
                              TextSpan(
                                text: " • ",
                                style: AppTextStyle.getTextStyle14FontWeightw300Black87,
                              ),
                              TextSpan(
                                text: "${service['services']!} Service", // Reuse subtitle
                                style: AppTextStyle.getTextStyle14FontWeightw300Black87,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Add remove action here
                    },
                    icon: const Icon(
                      Icons.remove_circle_outline,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            )),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                // Add "add more" action here
              },
              child:  Row(
                children: [
                  const Icon(Icons.add, color: Colors.teal),
                  const SizedBox(width: 8),
                  Text(
                    "Add more",
                    style: AppTextStyle.getTextStyle16FontWeightw300Teal,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                addItems('assets/icons/haircut.svg', "Haircut"),
                addItems('assets/icons/nails.svg', "Nails"),
                addItems('assets/icons/faicial.svg', "Facial"),
                addItems('assets/icons/massage.svg', "Massage"),
              ],
            ),
            Text(
              "Panel",
              style: AppTextStyle.getTextStyle18FontWeightBold,
            ),
            const SizedBox(height: 8),
            ...widget.selectedServices.map((service) =>
             getContainer(service)),
            const SizedBox(height: 30),
            Text(
              "Bill Summary",
              style: AppTextStyle.getTextStyle16FontWeightw600,
            ),
            const SizedBox(height: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Services", style: AppTextStyle.getTextStyle14FontWeightw3000xff,),
                    Text(
                      ' ${_viewModel.calculateServicesPrice()}',
                      style: AppTextStyle.getTextStyle14FontWeightw3000xff,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Platform fee", style: AppTextStyle.getTextStyle14FontWeightw3000xff,),
                    Text("50", style: AppTextStyle.getTextStyle14FontWeightw3000xff,),
                  ],
                ),
                const SizedBox(height: 8),
                const Padding(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: Divider(),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total price", style: AppTextStyle.getTextStyle16FontWeightw600),
                    Text(_viewModel.calculateTotalPrice().toString(), style: AppTextStyle.getTextStyle16FontWeightw600),
                  ],
                ),
                const SizedBox(height: 8),
                const Padding(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: Divider(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: CustomButtonWidget(
                text: 'Book',
                onPressed: () async {
                  // Retrieve userId from SharedPreferences
                   userId = await _viewModel.sharedPreferenceService.getUserId(); // Fetch userId
                  if (userId == null) {
                    CustomSnackBar.showSnackBar("User ID not found. Please log in again.");
                    return; // Exit if userId is not found
                  }

                  int status = 1; // Define your status logic
                  // Call the ViewModel to book the appointment
                  _viewModel.bookAppointment(
                    userId: userId!,
                    scheduledDate: widget.scheduledDate,
                    status: status,
                  );
                   Get.to(() => BookedScreenPage(selectedServicesCount: _selectedServices.length));
                },
                buttonColor: fabricColor,
                borderRadius: 5,
                buttonHeight: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget addItems(String imagePath, String text) {
    return Column(
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: const Color(0xffEDF6F6),
          ),
          child: Center(
            child: SvgPicture.asset(imagePath),
          ),
        ),
        Text(
          text,
          style: AppTextStyle.getTextStyle12FontWeightw500FabricColor,
        ),
      ],
    );
  }

  getQueueCount(String pid) {
    int panelId = int.parse(pid);
    // Find the panel with the matching panelId
    Panel? panel = _viewModel.beautySalonViewModel.panels.firstWhere(
          (panel) => panel.id == panelId,
    );
    return panel.queueCount;
  }

  getContainer(Map<String, String> service) {
    bool b = uniqueIds.contains(service['panelId']);
    if(b) return Container();
    uniqueIds.add(service['panelId']!);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Panel ${service['panelId']!}",
            style: AppTextStyle.getTextStyle16FontWeightw600,
          ),
          Text(
            "Queue - ${getQueueCount(service['panelId']!)}",
            style: AppTextStyle.getTextStyle14FontWeightw600B,
          ),
        ],
      ),
    );
  }

}
