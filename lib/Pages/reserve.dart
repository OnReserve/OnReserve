import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
// import 'package:on_reserve/Pages/profile.dart';
import 'package:on_reserve/helpers/routes.dart';

class Reserve extends StatelessWidget {
  const Reserve({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              // handle menu item selection
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'menu_item_1',
                child: Text('Sort by Price'),
              ),
              const PopupMenuItem<String>(
                value: 'menu_item_2',
                child: Text('Sort by Date'),
              ),
              const PopupMenuItem<String>(
                value: 'menu_item_3',
                child: Text('Filter by Category'),
              ),
            ],
            icon: const Icon(Icons.more_vert),
          ),
          // IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
        ],
        centerTitle: true,
        title: SafeArea(
          child: Text("Reserve for an Event",
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 65.sp,
                  fontFamily: "Inter")),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                "Reservation Options",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 75.sp,
                    fontFamily: "Inter"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Divider(
              color: Colors.blueGrey,
              thickness: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Event :",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                    fontSize: 68.sp,
                  ),
                ),
                SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Rophnan's My Generation Concert",
                      style: TextStyle(
                        fontSize: 62.sp,
                      ),
                      textAlign: TextAlign.end,
                    )),
                SizedBox(height: 50.h),
                Text(
                  "Even Starting Time :",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                    fontSize: 68.sp,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Jan 14/2022 03:00",
                    style: TextStyle(
                      fontSize: 62.sp,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
                SizedBox(height: 50.h),
                Text(
                  "Choose Packages :",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                    fontSize: 68.sp,
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                CustomRadioButton(
                  elevation: 0,
                  enableShape: true,
                  unSelectedColor: Theme.of(context).canvasColor,
                  autoWidth: true,
                  buttonLables: [
                    'VIP',
                    'VVIP',
                    'Regular',
                  ],
                  buttonValues: [
                    'VIP',
                    'VVIP',
                    'Regular',
                  ],
                  buttonTextStyle: ButtonTextStyle(
                      selectedColor: Colors.white,
                      unSelectedColor: Colors.black,
                      textStyle: TextStyle(fontSize: 50.sp)),
                  radioButtonValue: (value) {
                    print(value);
                  },
                  selectedColor: Theme.of(context).primaryColor,
                ),
                SizedBox(height: 50.h),
                Text(
                  "Choose Payment Method :",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                    fontSize: 68.sp,
                  ),
                ),
                Text(
                  "DATA",
                  style: TextStyle(
                    fontSize: 60.sp,
                  ),
                ),
                SizedBox(height: 100.h),
                SizedBox(
                  width: double.infinity,
                  height: 180.h,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed(Routes.pay);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF23538f),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        maximumSize: Size.fromHeight(180.h)),
                    child: Text(
                      "Continue To Payment",
                      style: TextStyle(
                          fontSize: 60.sp,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.7,
                          fontFamily: "Inter"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
