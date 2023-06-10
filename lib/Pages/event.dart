// import 'dart:async';
// import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
                      Theme.of(context)
                          .colorScheme
                          .background
                          .withOpacity(0.58),
                      Theme.of(context).colorScheme.background
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ).createShader(bounds);
                },
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: height * 0.45,
                    viewportFraction: 1,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 10),
                    autoPlayAnimationDuration: Duration(seconds: 1),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    // enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    // onPageChanged: callbackFunction,
                    scrollDirection: Axis.horizontal,
                  ),
                  items: [1, 2, 3, 4, 5].map((i) {
                    return Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background),
                        child: Image.asset(
                          "assets/Images/Rophnan.png",
                          fit: BoxFit.cover,
                        ));
                  }).toList(),
                ),
              ),
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
              Positioned(
                bottom: 10,
                left: 0,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: width,
                  ),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: 900.w,
                                ),
                                child: Text(
                                  "Rophnan’s My Second Generation",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 70.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                "Rophnan Concert",
                                style: TextStyle(
                                  fontSize: 58.sp,
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
                                fontSize: 55.sp,
                              ),
                            ),
                            Text(
                              "Jan 14, 2022",
                              style: TextStyle(
                                fontSize: 55.sp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30.h),
                Row(
                  children: [
                    Expanded(
                      child: RatingBar.builder(
                        initialRating: 3,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemSize: 20,
                        itemCount: 5,
                        itemPadding:
                            EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                    ),
                    SizedBox(
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 3),
                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.75),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              child: Text(
                                "VVIP",
                                style: TextStyle(
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.75),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              child: Text(
                                "VIP",
                                style: TextStyle(
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                  child: SizedBox(
                    child: Text(
                      "Lorem ipsum dolor sit amet consectetur. Interdum et duis integer quam. tempor adipiscing. Est arcu aliquet convallis sed gravida...see more",
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
                      size: 60.r,
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
                    height: 750.h,
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
                        backgroundColor: Theme.of(context).colorScheme.primary,
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
