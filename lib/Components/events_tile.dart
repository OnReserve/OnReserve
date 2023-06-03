import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:on_reserve/helpers/routes.dart';

class EventCard extends StatelessWidget {
  const EventCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.eventDetail);
      },
      child: Container(
          padding: EdgeInsets.all(10.r),
          margin: EdgeInsets.all(30.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Image.asset("assets/Images/logo.png",
                        height: 330.r, width: 330.r),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Rophnan's My Generation",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 60.sp,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Addis Concert Organizers",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 46.sp,
                              ),
                            ),
                            Image.asset('assets/Images/Blue_tick.png',
                                height: 70.r, width: 80.r)
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          "Jan 14/2022 03:00",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 36.sp,
                            fontFamily: "Inter",
                            color: Colors.grey,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Row(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.grey,
                                    size: 40.r,
                                  ),
                                  Text(
                                    "Addis Ababa, Ethiopia",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 36.sp,
                                      fontFamily: "Inter",
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Text.rich(
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 40.sp,
                                      fontFamily: "Inter",
                                      color: Colors.grey,
                                    ),
                                    TextSpan(
                                      text: "Starting from",
                                      children: [
                                        TextSpan(
                                            text: " 100ETB",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 42.sp,
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(
                color: Colors.grey,
                thickness: 1.0,
              ),
            ],
          )),
    );
  }
}
