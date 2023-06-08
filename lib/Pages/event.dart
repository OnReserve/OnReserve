// import 'dart:async';
// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:on_reserve/helpers/routes.dart';

class Event extends StatefulWidget {
  const Event({super.key});

  @override
  State<Event> createState() => _EventState();
}

class _EventState extends State<Event> {
  // final Completer<GoogleMapController> controller =
  //     Completer<GoogleMapController>();

  // static const CameraPosition kGooglePlex = CameraPosition(
  //   target: LatLng(37.42796133580664, -122.085749655962),
  //   zoom: 14.4746,
  // );

  // static const CameraPosition kLake = CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: LatLng(37.43296265331129, -122.08832357078792),
  //     tilt: 59.440717697143555,
  //     zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              ShaderMask(
                  blendMode: BlendMode.srcATop,
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      colors: [
                        Colors.transparent,
                        Theme.of(context).colorScheme.background
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ).createShader(bounds);
                  },
                  child: Image.asset(
                    "assets/Images/Rophnan.png",
                    fit: BoxFit.cover,
                    height: 1100.h,
                  )),
              Positioned(
                top: 180.h,
                left: 120.w,
                child: Container(
                  height: 150.r,
                  width: 150.r,
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .background
                        .withOpacity(0.65),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 3.0),
                    child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Theme.of(context).colorScheme.onBackground,
                        weight: 2,
                        size: 60.r,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Rophnan’s My Second Generation",
                            style: TextStyle(
                              fontSize: 55.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Rophnan Concert",
                            style: TextStyle(
                              fontSize: 50.sp,
                              color: const Color(0xFF23538f),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "03:00 PM",
                          style: TextStyle(
                            fontSize: 45.sp,
                            color: const Color(0xFF23538f),
                          ),
                        ),
                        Text(
                          "Jan 14, 2022",
                          style: TextStyle(
                            fontSize: 45.sp,
                            color: const Color(0xFF23538f),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: SizedBox(
                    child: Text(
                      "Lorem ipsum dolor sit amet consectetur. Interdum et duis integer quam. Lectus dictum aenean in vulputate fringilla vitae tempor adipiscing. Est arcu aliquet convallis sed gravida. Pharetra feugiat nisl non in arcu massa accumsan...see more",
                      style: TextStyle(
                        fontSize: 50.sp,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 65.r,
                    ),
                    Text(" Gihon Hotel",
                        style: TextStyle(
                          fontSize: 60.sp,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
                SizedBox(
                  height: 50.h,
                ),
                SizedBox(
                    width: double.infinity,
                    height: 550.h,
                    child:
                        // Platform.isAndroid
                        //     ? GoogleMap(
                        //         mapType: MapType.hybrid,
                        //         initialCameraPosition: kGooglePlex,
                        //       )
                        //     : SizedBox(),
                        SizedBox()),
                SizedBox(
                  width: double.infinity,
                  height: 180.h,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed(Routes.reserve);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF23538f),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        maximumSize: Size.fromHeight(180.h)),
                    child: Text(
                      "Reserve",
                      style: TextStyle(
                          fontSize: 60.sp,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.7,
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontFamily: "Inter"),
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
