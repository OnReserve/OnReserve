import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:on_reserve/Controllers/event_controller.dart';
import 'package:on_reserve/Pages/Reser%20Bottom%20Sheets/reserve_bottom_sheets.dart';
import 'package:on_reserve/Pages/review_bottom_sheet.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:on_reserve/helpers/log/logger.dart';

class Event extends StatefulWidget {
  const Event({super.key});

  @override
  State<Event> createState() => _EventState();
}

class _EventState extends State<Event> {
  final Completer<GoogleMapController> controller =
      Completer<GoogleMapController>();

  static CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  bool liked = false;
  double rating = 3.0;

  @override
  void initState() {
    var controller = Get.put(EventController());
    var lat = 37.42796133580664;
    var long = -122.085749655962;
    try {
      lat = controller.args['locations'][0]['latitude'] + 0.0;
      long = controller.args['locations'][0]['longitude'] + 0.0;
    } catch (e) {
      logger(Event).e(e.toString());
    }
    kGooglePlex = CameraPosition(target: LatLng(lat, long), zoom: 14.4746);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    var controller = Get.put(EventController());

    DateTime dateTime = DateTime.parse(controller.args['eventStartTime']);

    String date =
        "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
    String time =
        "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";

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
                  items:
                      List<Widget>.from(controller.args['galleries'].map((i) {
                    return Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background),
                        child: CachedNetworkImage(
                          imageUrl: i['eventPhoto'],
                          fit: BoxFit.cover,
                        ));
                  })),
                ),
              ),
              Positioned(
                top: 140.h,
                left: 100.w,
                child: Container(
                  height: 140.r,
                  width: 140.r,
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .background
                        .withOpacity(0.65),
                    borderRadius: BorderRadius.circular(50),
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
                top: 140.h,
                right: 100.w,
                child: Container(
                  height: 140.r,
                  width: 140.r,
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .background
                        .withOpacity(0.65),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        liked = !liked;
                      });
                    },
                    splashColor: Colors.pink,
                    color: Colors.pink,
                    icon: Icon(
                      liked ? Icons.favorite : Icons.favorite_border,
                      color: Colors.pink,
                      weight: 2,
                      size: 75.r,
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
                                  controller.args['title'],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 70.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                controller.args['locations'] != null
                                    ? controller.args['locations'][0]['city']
                                    : '',
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
                              time,
                              style: TextStyle(
                                fontSize: 55.sp,
                              ),
                            ),
                            Text(
                              date,
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
                SizedBox(height: 4.h),
                Row(
                  children: [
                    // Review Stars
                    Expanded(
                      child: Container(
                        width: 600.w,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                              children: List.generate(
                            5,
                            (index) => Icon(
                              Icons.star,
                              color: controller.rating > index
                                  ? Colors.yellow[600]
                                  : Colors.grey[400],
                              size: 75.r,
                            ),
                          )),
                        ),
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
                                    .withOpacity(0.55),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              child: Text(
                                "ECO",
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
                                    .withOpacity(0.55),
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
                      controller.args['desc'],
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
                    Text(controller.args['locations'][0]['venue'],
                        style: TextStyle(
                          fontSize: 60.sp,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
                SizedBox(
                  height: 50.h,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 750.h,
                    child: Platform.isAndroid
                        ? GoogleMap(
                            mapType: MapType.hybrid,
                            initialCameraPosition: kGooglePlex,
                          )
                        : SizedBox(),
                  ),
                ),
                SizedBox(
                  height: 120.h,
                ),
                Row(
                  children: [
                    true
                        ? Container(
                            margin: EdgeInsets.only(left: 10, right: 20),
                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.55),
                                borderRadius: BorderRadius.circular(20)),
                            child: IconButton(
                              onPressed: () {
                                controller.resetBottomSheet();
                                Get.bottomSheet(
                                  ReviewsBottomSheet(),
                                  shape: Get.theme.bottomSheetTheme.shape,
                                  isScrollControlled: true,
                                  clipBehavior: Clip.hardEdge,
                                  useRootNavigator: true,
                                  enableDrag: true,
                                );
                              },
                              icon: Icon(
                                Icons.reviews,
                                color: Theme.of(context).colorScheme.onPrimary,
                                size: 80.r,
                              ),
                            ),
                          )
                        // ignore: dead_code
                        : SizedBox(),
                    Expanded(
                      child: SizedBox(
                        height: 180.h,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.bottomSheet(
                              const ReserveBottomSheet(),
                              shape: Get.theme.bottomSheetTheme.shape,
                              isScrollControlled: true,
                              clipBehavior: Clip.hardEdge,
                              useRootNavigator: true,
                              enableDrag: true,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
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
                    ),
                  ],
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
