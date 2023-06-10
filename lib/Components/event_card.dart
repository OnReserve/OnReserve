// ignore_for_file: unused_local_variable
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:on_reserve/helpers/routes.dart';

class ContinueCard extends StatelessWidget {
  final int index;
  final String date;
  final String title;
  final String bgImage;

  const ContinueCard({
    super.key,
    required this.date,
    required this.title,
    required this.index,
    required this.bgImage,
  });

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    Orientation isLandscape =
        displayWidth > 650 ? Orientation.landscape : Orientation.portrait;
    return GestureDetector(
        onTap: () {
          Get.toNamed(Routes.eventDetail);
        },
        child: Container(
          width: isLandscape == Orientation.portrait ? 920.w : 920.w * 0.65,
          margin: EdgeInsets.only(right: 75.w),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: Image.network(
                    bgImage,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      // handle the exception here
                      return Center(
                        child: Text('Failed to load image'),
                      );
                    },
                  ).image,
                  fit: BoxFit.cover,
                  opacity: 0.5),
              gradient: LinearGradient(
                begin: const Alignment(-1, 1),
                end: const Alignment(1, -1),
                colors: index.isEven
                    ? [
                        Color.fromARGB(255, 136, 102, 63),
                        Color.fromARGB(255, 139, 111, 59),
                        Color.fromARGB(255, 105, 87, 44),
                        Color.fromARGB(255, 60, 54, 32),
                      ]
                    : [
                        Color.fromARGB(255, 163, 110, 56),
                        Color.fromARGB(255, 178, 59, 87),
                        Color.fromARGB(255, 138, 52, 185),
                        Color.fromARGB(255, 47, 33, 156),
                      ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor.withAlpha(85),
                  // spreadRadius: 0.25,
                  blurRadius: 15.r,
                  offset: Offset(5.w, 2.h),
                )
              ],
              borderRadius: BorderRadius.all(Radius.circular(60.r))),
          child: Padding(
            padding: EdgeInsets.all(50.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 350.w,
                  height: 105.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.r)),
                  ),
                  child: Center(
                    child: Text(
                      'Event Name',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .background
                          .withOpacity(0.2),
                      borderRadius: BorderRadius.all(Radius.circular(25.r)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Text(
                            '$Title',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                    fontSize: 10,
                                    color: Theme.of(context).canvasColor),
                          ),
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}

class Details extends StatelessWidget {
  final String text;
  final bool shade;
  final IconData icon;
  const Details(
      {super.key, required this.text, required this.icon, this.shade = false});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 33.h,
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        // padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: shade ? Colors.black.withOpacity(0.2) : Colors.transparent,
        ),
        child: Row(
          children: [
            Container(
                height: 12.h,
                width: 12.w,
                margin: EdgeInsets.only(bottom: 13.h, left: 4.w),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 25.r,
                )),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 25.w),
                child: Text(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  text,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontSize: 8.5, color: Colors.white),
                ),
              ),
            )
          ],
        ));
  }
}
