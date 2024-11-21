import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salon_app/past_booking/past_booking_viewmodel.dart';

import '../utils/app_strings.dart';
import '../utils/app_text_style.dart';

class PastBookingPage extends StatefulWidget {
  const PastBookingPage({super.key});

  @override
  State<PastBookingPage> createState() => _PastBookingPageState();
}

class _PastBookingPageState extends State<PastBookingPage> {
  late PastBookingVieModel _viewModel;

  void initState() {
    super.initState();
    // Use addPostFrameCallback to avoid calling during build
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Fetch data methods
      print("api call");
      _viewModel.fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    _viewModel = context.watch<PastBookingVieModel>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new,color: Colors.black,),
        ),
        title: Center(
            child: Text(AppString.pastBooking,
                style: AppTextStyle.getTextStyle18FontWeightBold)
        ),
        actions: [
          Container(
            width: 30,
            height: 30,
            color: Colors.transparent,
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: _viewModel.bookings.length,
          itemBuilder: (context, index) {
            final booking = _viewModel.bookings[index];
            return Card(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 100,
                    height: 90,
                    margin: const EdgeInsets.all(8),
                    child: CachedNetworkImage(
                      imageUrl: "assets/icons/gallery1.png",
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                            colorFilter: const ColorFilter.mode(Colors.transparent, BlendMode.colorBurn),
                          ),
                        ),
                      ),
                      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Service Done',
                                style: AppTextStyle.getTextStyle12FontWeightw300,
                              ),
                              const SizedBox(height: 3),
                              Text(
                                booking.salonName.toString(),
                                style: AppTextStyle.getTextStyle18FontWeightBold,
                              ),
                              const SizedBox(height: 3),
                              Text(
                                booking.address.toString(),
                                style: AppTextStyle.getTextStyle13FontWeightw400G,
                              ),
                              const SizedBox(height: 3),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Text(
                                      booking.serviceName.toString(),
                                      style: const TextStyle(
                                          fontFamily: 'Outfit',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          color: Colors.black
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  RichText(
                                    textAlign: TextAlign.left,
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: 'Price: ',
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontFamily: 'Outfit',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            // height: 1.3, // Equivalent to 42.9px line height
                                            // letterSpacing: 0.04,
                                          ),
                                        ),
                                        TextSpan(
                                          text:  '${booking.price.toString()}',
                                          style: AppTextStyle.getTextStyle14FontWeight,
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(right: 20),
                                  //   child: Text(
                                  //     'price: ${booking.price.toString()}',
                                  //     style: AppTextStyle.getTextStyle14FontWeight,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // const SizedBox(height: 10),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Container(
                        //         height: 40,
                        //         margin: const EdgeInsets.only(bottom: 10),
                        //         decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(12),
                        //           color: const Color(0xffE6F4F4),
                        //         ),
                        //         child: IconButton(
                        //           icon: const Icon(Icons.navigation_sharp,color: Colors.grey,),
                        //           onPressed: () {
                        //             // Toggle favorite status
                        //             // Notify changes
                        //           },
                        //         ),
                        //       ),
                        //       const SizedBox(width: 25),
                        //       Expanded(
                        //         child: Container(
                        //           margin: const EdgeInsets.only(bottom: 6),
                        //           child: CustomButtonWidget(
                        //             text: AppString.payment,
                        //             textColor: Colors.grey,
                        //             onPressed: () async {
                        //               // Call the passed onPressed function
                        //               // onPressed(); // Execute the onPressed callback
                        //             },
                        //             buttonColor: Colors.white,
                        //             borderColor: Colors.grey,
                        //             borderRadius: 5,
                        //             buttonHeight: 40,
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
      ),
    );
  }
}
