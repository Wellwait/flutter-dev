import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:salon_app/queue/queue_viewmodel.dart';
import 'package:salon_app/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import '../booking_pending/booking_pending_viewmodel.dart';
import '../models/panel.dart';
import '../rating/rating_page.dart';
import '../service_provider_details/sp_detail_viewmodel.dart';
import '../utils/app_strings.dart';
import '../utils/app_text_style.dart';
import '../widget/custom_button.dart';
import '../widget/snack_bar_widget.dart';

class QueuePage extends StatefulWidget {
  final dynamic serviceProvideId;
  final String? phoneNumber;
  QueuePage({super.key,this.serviceProvideId,this.phoneNumber});

  @override
  State<QueuePage> createState() => _QueuePageState();
}

class _QueuePageState extends State<QueuePage> {
  // Dummy data for demonstration
  late QueueViewModel _viewModel;
  late SPDetailViewModel _sPDetailViewModel;
  late BookingPendingViewModel _bookingPendingViewModel;

  void initState() {
    super.initState();
    // Use addPostFrameCallback to avoid calling during build
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _viewModel.fetchData(widget.serviceProvideId);
      _sPDetailViewModel.fetchPanels(widget.serviceProvideId);
      print('booking service provider id : ${widget.serviceProvideId}');
      print('phone number : ${widget.phoneNumber}');
    });
  }

  List<String> uniqueIds = [];

  @override
  Widget build(BuildContext context) {
    _viewModel = context.watch<QueueViewModel>();
    _sPDetailViewModel = Provider.of<SPDetailViewModel>(context, listen: false);
    _bookingPendingViewModel = Provider.of<BookingPendingViewModel>(context, listen: false);
    uniqueIds = [];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            _bookingPendingViewModel.fetchData();
          },
          icon: const Icon(Icons.arrow_back_ios_new,color: Colors.black,),
        ),
        title: Center(
            child: Text(_viewModel.formattedDate,
                style: AppTextStyle.getTextStyle18FontWeightBold)
        ),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 15),
        //     child: Text(
        //       AppString.help,
        //       style: AppTextStyle.getTextStyleFontWeightw600G,
        //     ),
        //   ),
        // ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _sPDetailViewModel.panels.length,
                  itemBuilder: (context, index) {
                    final panel = _sPDetailViewModel.panels[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            height: 80,
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
                                          Image.asset("assets/profile_image.png",height: 50,width: 50,),
                                          // SvgPicture.asset(
                                          //     'assets/google.svg'),
                                          const SizedBox(width: 20),
                                          RichText(
                                            text: TextSpan(
                                              text: panel.name,
                                              // Display panel name
                                              style: AppTextStyle
                                                  .getTextStyle15FontWeightw600,
                                              children: <TextSpan>[
                                                const TextSpan(text: " "),
                                                TextSpan(
                                                  text: "Artist",
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
                                              'tel:${widget.phoneNumber}');
                                          print('Panel phone number : ${widget.phoneNumber}');
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ...getBookings(panel.id!)
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomButtonWidget(
              text: AppString.cancelBooking,
              textColor: _viewModel.selectedIndex != null
                  ? fabricColor
                  : Colors.grey,
              onPressed: () async {
                if (_viewModel.selectedIndex == null) return;
                final selectedBooking = _viewModel.bookings[_viewModel.selectedIndex!];
                if (selectedBooking.started == 1 && selectedBooking.finished == 1) {
                  Get.to(() => RatingPage(bookingId: selectedBooking.id,bookingPrice: selectedBooking.price?.toDouble(),serviceProviderId: widget.serviceProvideId,));
                } else if (selectedBooking.started == 1) {
                  CustomSnackBar.showSnackBar("This service is Started");
                  print(selectedBooking.started);
                } else {
                  await _viewModel.cancelBooking(selectedBooking.id!);
                  await _viewModel.fetchData(widget.serviceProvideId);
                  setState(() {
                    _viewModel.selectedIndex = null;
                  });
                  print('selectId: ${selectedBooking.id}');
                }
              },
              buttonColor: Colors.white,
              borderRadius: 8,
              borderColor: _viewModel.selectedIndex != null
                  ? fabricColor
                  : Colors.grey,
              buttonHeight: 40,
            ),
          ),
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
    widgets.add(SizedBox(height: 10));
    for (int i = 0; i < _viewModel.bookings.length; i++) {
      var booking = _viewModel.bookings[i];
      if (booking.panelId == panelId) {
        widgets.add(Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              setState(() {
                _viewModel.selectedIndex = i; // Set the selected index
              });
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color(0xffEDF6F6),
                border: Border.all(
                   color: _viewModel.selectedIndex == i
                       ? fabricColor
                       : Colors.transparent,
                   width: 1,
                 ),
              ),
              child: ListTile(
                leading: ClipOval(
                  child: Container(
                    color: Colors.white,
                    child: Image.asset('assets/admin_icon.png',height: 35,width: 35,),
                    //SvgPicture.asset('assets/google.svg'),
                  ),
                ),
                title: Text(
                  booking.username.toString(),
                  style: AppTextStyle.getTextStyle16FontWeightw600,
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(booking.serviceName.toString()),
                ),
                trailing: (booking.started == 1 || booking.finished == 1)
                    ? Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if(booking.status == 2) Container(
                        height: 20,
                        width: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xff2158FF),
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: Center(
                            child: Text(
                              AppString.onGoing,
                              style: AppTextStyle.getTextStyle10FontWeightw300,
                            ),
                          ),
                        ),
                      ),
                      if (booking.started == 1)
                        RichText(
                          text: TextSpan(
                            text: 'Started at:',
                            style: AppTextStyle.getTextStyle14FontWeightw500t,
                            children: <TextSpan>[
                              const TextSpan(text: " "),
                              TextSpan(
                                text: '${booking.startedAt}',
                                style: AppTextStyle.getTextStyle15FontWeightw600,
                              ),
                            ],
                          ),
                        ),
                      if (booking.started == 1) const SizedBox(height: 5), // Spacing
                      if (booking.finished == 1)
                        RichText(
                          text: TextSpan(
                            text: 'Finished at:',
                            style: AppTextStyle.getTextStyle14FontWeightw500t,
                            children: <TextSpan>[
                              const TextSpan(text: " "),
                              TextSpan(
                                text: '${booking.finishedAt}',
                                style: AppTextStyle.getTextStyle15FontWeightw600,
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                )
                    : Container(
                  width: 100,
                  height: 30,
                  decoration: BoxDecoration(
                    color: fabricColor,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Colors.black87,
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Center(
                      child: Text(
                        'Token No: ${i + 1}',
                        style: AppTextStyle.getTextStyleFontWeightw300White,
                      ),
                    ),
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
