import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:on_reserve/Pages/profile.dart';
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
                    fontSize: 58.sp,
                  ),
                ),
                Text(
                  "DATA",
                  style: TextStyle(
                    fontSize: 62.sp,
                  ),
                ),
                SizedBox(height: 30.h),
                Text(
                  "Even Starting Time :",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    fontSize: 58.sp,
                  ),
                ),
                Text(
                  "DATA",
                  style: TextStyle(
                    fontSize: 62.sp,
                  ),
                ),
                SizedBox(height: 30.h),
                Text(
                  "Your Packages :",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    fontSize: 58.sp,
                  ),
                ),
                Text(
                  "DATA",
                  style: TextStyle(
                    fontSize: 60.sp,
                  ),
                ),
                SizedBox(height: 30.h),
                Text(
                  "Choose Payment Method :",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    fontSize: 58.sp,
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
