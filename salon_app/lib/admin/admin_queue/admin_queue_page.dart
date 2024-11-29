import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:salon_app/queue/queue_viewmodel.dart';
import 'package:salon_app/utils/colors.dart';
import 'package:salon_app/utils/common_variables.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../home_screen/home_screen_viewmodel.dart';
import '../../models/panel.dart';
import '../../service_provider_details/sp_detail_viewmodel.dart';
import '../../utils/app_strings.dart';
import '../../utils/app_text_style.dart';
import '../../widget/custom_button.dart';
import '../admin_email_login/admin_email_login_viewmodel.dart';
import 'admin_queue_viewmodel.dart';

class AdminQueuePage extends StatefulWidget {
  const AdminQueuePage({super.key});

  @override
  State<AdminQueuePage> createState() => _AdminQueuePageState();
}

class _AdminQueuePageState extends State<AdminQueuePage> {
  // Dummy data for demonstration
  late AdminQueueViewModel _viewModel;
  //late HomeScreenViewModel _homeScreenViewModel;
  late SPDetailViewModel _sPDetailViewModel;
  late AdminEmailLoginViewModel _adminEmailLoginViewModel;

  List<int> panelIds = [];

  void initState() {
    super.initState();
    // Use addPostFrameCallback to avoid calling during build
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Fetch data methods
      _viewModel.fetchData(_adminEmailLoginViewModel.serviceProviderId!);
    });
  }

  List<String> uniqueIds = [];

  @override
  Widget build(BuildContext context) {
    panelIds = [];
    _viewModel = context.watch<AdminQueueViewModel>();
    //_homeScreenViewModel = Provider.of<HomeScreenViewModel>(context, listen: false);
    _sPDetailViewModel = Provider.of<SPDetailViewModel>(context, listen: false);
    _adminEmailLoginViewModel = Provider.of<AdminEmailLoginViewModel>(context, listen: false);
    uniqueIds = [];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Container(
          color: Colors.transparent,
          height: 20,
          width: 20,
        ),
        title: Center(
            child: Text(_viewModel.formattedDate,
                style: AppTextStyle.getTextStyle18FontWeightBold)
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Text(
              AppString.help,
              style: AppTextStyle.getTextStyleFontWeightw600G,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView( // Use SingleChildScrollView to allow scrolling
              child: Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  // Allow the ListView to take only the space it needs
                  physics: NeverScrollableScrollPhysics(),
                  // Disable its own scrolling
                  itemCount: _viewModel.bookings.length,
                  // Use the length of panels
                  itemBuilder: (context, index) {
                    print(_viewModel.bookings.length);
                    final booking = _viewModel.bookings[index]; // Access each panel
                    if(!panelIds.contains(booking.panelId)) {
                      print("Adding ${booking.panelId}");
                      panelIds.add(booking.panelId!);
                    } else {
                      print("exiting");
                      return Container();
                    }
                    print(booking);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: const Color(0xffEDF6F6),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 30),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/profile_image.png',height: 50,width: 50),
                                          const SizedBox(width: 20),
                                          RichText(
                                            text: TextSpan(
                                              text: booking.panelName.toString(),
                                              // Display panel name
                                              style: AppTextStyle
                                                  .getTextStyle15FontWeightw600,
                                              children: <TextSpan>[
                                                const TextSpan(text: " "),
                                                TextSpan(
                                                  text: "Artist",
                                                  // You can add more details here
                                                  style: AppTextStyle
                                                      .getTextStyle14FontWeightw200,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                            Icons.call, color: fabricColor,
                                            size: 25),
                                        onPressed: () {
                                          _makePhoneCall(
                                              'tel:${mobileNumber}');
                                          print(mobileNumber);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ...getBookings(booking.panelId!)

                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          /*Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomButtonWidget(
              text: AppString.cancelBooking,
              textColor: _viewModel.selectedIndex != null
                  ? Colors.green
                  : Colors.grey,
              onPressed: () async {
                if (_viewModel.selectedIndex != null) {
                  final selectedBooking = _viewModel.bookings[_viewModel.selectedIndex!];
                  await _viewModel.cancelBooking(selectedBooking.id!);
                  await _viewModel.fetchData(serviceProviderId);

                  setState(() {
                    _viewModel.selectedIndex =
                    null; // Optionally reset selection
                  });

                  print('selectId: ${selectedBooking.id}');
                }
              },
              buttonColor: Colors.white,
              borderRadius: 8,
              borderColor: _viewModel.selectedIndex != null
                  ? Colors.green
                  : Colors.grey,
              buttonHeight: 40,
            ),
          ),*/
        ],
      ),


    );
  }

  void _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  divider(Map<String, String> service) {
    bool b = uniqueIds.contains(service['panelId']);
    if (b) return Container();
    uniqueIds.add(service['panelId']!);
    return Center(
      child: Text(
        "Queue - ${getQueueCount(service['panelId']!)}",
        style: AppTextStyle.getTextStyle15FontWeightw600,
      ),
    );
  }

  getQueueCount(String pid) {
    int panelId = int.parse(pid);
    // Find the panel with the matching panelId
    Panel? panel = _sPDetailViewModel.panels.firstWhere(
          (panel) => panel.id == panelId,
    );
    return panel.queueCount;
  }

  // int _counter = 0;
  //
  // // Method to increment the counter
  // void incrementCounter() {
  //   setState(() {
  //     _counter++;
  //   });
  // }

  topSecondContainer() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 90,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color(0xffEDF6F6),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: Container(
                        color: Colors.white,
                        child: SvgPicture.asset('assets/google.svg'),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppString.msNatasha,
                          style: AppTextStyle.getTextStyle16FontWeightw600,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          AppString.haircutBlowdry,
                          style: AppTextStyle.getTextStyleFontWeightw300,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Container(
              //   margin: const EdgeInsets.only(top: 20),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.end,
              //     children: [
              //       Container(
              //         height: 20,
              //         width: 50,
              //         decoration: BoxDecoration(
              //           color: const Color(0xff2158FF),
              //           borderRadius: BorderRadius.circular(5),
              //           border: Border.all(
              //             color: Colors.black,
              //             width: 1,
              //           ),
              //         ),
              //         child: Padding(
              //           padding: const EdgeInsets.all(2),
              //           child: Center(
              //             child: Text(
              //               AppString.original,
              //               style: AppTextStyle.getTextStyle10FontWeightw300,
              //             ),
              //           ),
              //         ),
              //       ),
              //       const SizedBox(height: 8),
              //       textSpan(AppString.startedAt, AppString.elevenAm),
              //       textSpan(AppString.duration, AppString.twentyMinutes),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> getBookings(int panelId) {
    List<Widget> widgets = [];
    // Selected services
    //_sPDetailViewModel.selectedServices.map((service) => divider(service)),
    widgets.add(const SizedBox(height: 10));
    for (int i = 0; i < _viewModel.bookings.length; i++) {
      var booking = _viewModel.bookings[i];
      if (booking.panelId == panelId) {
        widgets.add(Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              setState(() {
              //  _viewModel.selectedIndex = i; // Set the selected index
              });
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color(0xffEDF6F6),
                border: Border.all(
                  color: Colors.transparent,
                  // color: _viewModel.selectedIndex == i
                  //     ? Colors.green
                  //     : Colors.transparent,
                  width: 1,
                ),
              ),
              child: ListTile(
                leading: ClipOval(
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(5),
                    child: SvgPicture.asset(
                      'assets/admin_icon.png',
                      height: 35,
                      width: 35,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                title: Text(
                  booking.username.toString(),
                  style: AppTextStyle.getTextStyle16FontWeightw600,
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(booking.serviceName.toString()),
                      Text('\$${booking.price.toString()}'),
                    ],
                  ),
                ),
                trailing: booking.status == 3
                    ? const Text('Completed',style: TextStyle(fontWeight: FontWeight.w300,fontFamily: 'Outfit',fontSize: 18),)
                    : SizedBox(
                  width: 150, // Constrain the width to ensure proper layout
                  child: Row(
                    children: [
                      Flexible(
                        child: GestureDetector(
                          onTap: () {
                            if (booking.status != 2) {
                              _viewModel.updateBookingStarted(booking.id!);
                            }
                          },
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: booking.status == 2
                                  ? Colors.grey[200] // Change color to grey if the booking is started
                                  : fabricColor, // Default color
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color:  booking.status == 2
                                    ? Colors.grey
                                    : Colors.black87,
                                width: 1,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Center(
                                child: Text(
                                  booking.status == 2
                                      ? 'Started' // Change text to "Started" if the booking has started
                                      : 'Start', // Default text
                                  style: TextStyle(
                                    color:  booking.status == 2
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Flexible(
                        child: GestureDetector(
                          onTap: () async {
                            if(booking.status != 3) {
                              await _viewModel.updateBookingFinished(booking.id!);
                              _viewModel.fetchData(_adminEmailLoginViewModel.serviceProviderId!);
                            }
                          },
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: booking.status == 3
                                  ? Colors.grey[200]
                                  : Colors.green,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                //color: _viewModel.bookingFinishedStatus[booking.id] == true
                                color: booking.status == 3
                                    ? Colors.grey
                                    : Colors.black87,
                                width: 1,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Center(
                                child: Text(
                                  booking.status == 3
                                      ? "Completed"
                                      : "Complete",
                                  style: TextStyle(
                                      color: booking.status == 3
                                          ? Colors.black
                                          : Colors.white,
                                      fontWeight: FontWeight.w300,
                                      fontFamily: 'Outfit'
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
      }
    }
    return widgets;
  }
}
