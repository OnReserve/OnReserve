import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:on_reserve/Pages/reserve.dart';
import 'package:on_reserve/helpers/routes.dart';

class Event extends StatefulWidget {
  const Event({super.key});

  @override
  State<Event> createState() => _EventState();
}

class _EventState extends State<Event> {
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
          child: Text("Event-Details",
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 65.sp,
                  fontFamily: "Inter")),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 770.h,
            child: Image.asset("assets/images/Rophnan.png", fit: BoxFit.cover),
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
                      // color: Colors.black,
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
                      Image.asset("assets/images/Map.png", fit: BoxFit.cover),
                ),
                SizedBox(
                  height: 300.h,
                ),
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
