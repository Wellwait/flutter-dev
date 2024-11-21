import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../utils/app_text_style.dart';
import '../../utils/colors.dart';
import 'notification_viewmodel.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  late NotificationViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    _viewModel = context.watch<NotificationViewModel>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Notification',
          style: AppTextStyle.getTextStyle16FontWeightw700,
          textAlign: TextAlign.center, // Moved textAlign here
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: Icon(Icons.settings,color: fabricColor,size: 30,),
          )
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NotificationTile(
              //title: 'SALE IS LIVE',
              description:
                  'Your Payment Failed for hotel booking ',
              time: '15 Hrs ago',
              iconPath: "assets/icons/cross.svg",
            ),
            NotificationTile(
              // title: 'SALE IS LIVE',
              description:
                  'Reminder! . Get ready for your appointment at 9am',
              time: '15 Hrs ago',
              iconPath: 'assets/icons/reminder.svg',
            ),
            NotificationTile(
             // title: 'WELCOME',
              description:
                  'Payment at Lovely Lather was success!',
              time: '20 Hrs ago',
              iconPath: 'assets/icons/dollar.svg',
              showDivider: false,
            ),
            SizedBox(height: 14),
            Text(
              "Earlier",
              style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            NotificationTile(
              // title: 'WELCOME',
              description:
              'You make an appointment with Lovely Lather',
              time: '20 Hrs ago',
              iconPath: 'assets/icons/reminder.svg',
            ),
            NotificationTile(
              // title: 'WELCOME',
              description:
              'Get 20% offers for hair service at Lovely Lather',
              time: '20 Hrs ago',
              iconPath: 'assets/icons/reminder.svg',
            ),
          ],
        ),
      ),
    );
  }
}


class NotificationTile extends StatelessWidget {
  final String description;
  final String time;
  final String iconPath;
  final bool showDivider;

  const NotificationTile({
    required this.description,
    required this.time,
    required this.iconPath,
    this.showDivider = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 40, // Reduced the height of the container
                width: 40, // Reduced the width of the container
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffEDF6F6),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    iconPath,
                    width: 20, // Adjusted width of the SVG image
                    height: 20, // Adjusted height of the SVG image
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Uncomment if you want to use the title again
                    // Text(
                    //   title,
                    //   style: const TextStyle(
                    //     fontFamily: 'Manrope',
                    //     fontSize: 14,
                    //     fontWeight: FontWeight.w600,
                    //     height: 19.12 / 14,
                    //   ),
                    //   textAlign: TextAlign.left,
                    // ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: AppTextStyle.getTextStyle14FontWeightw400,
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                time,
                style: AppTextStyle.getTextStyle10FontWeightw600,
              ),
            ],
          ),
          const SizedBox(height: 6),
          if (showDivider) // Conditionally render the Divider based on showDivider
            Divider(color: Colors.grey[300]),
        ],
      ),
    );
  }
}


