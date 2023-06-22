// ignore_for_file: unused_local_variable
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class EventCard extends StatelessWidget {
  final int index;
  final String datetime;
  final String title;
  final String bgImage;
  late String date;
  late String time;
  late DateTime dateTime;

  EventCard({
    super.key,
    required this.datetime,
    required this.title,
    required this.index,
    required this.bgImage,
  }) {
    dateTime = DateTime.parse(this.datetime);

    date =
        "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
    time =
        "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    Orientation isLandscape =
        displayWidth > 650 ? Orientation.landscape : Orientation.portrait;
    return Container(
      width: isLandscape == Orientation.portrait ? 920.w : 920.w * 0.65,
      margin: EdgeInsets.only(right: 75.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60.r),
        image: DecorationImage(
          image: CachedNetworkImageProvider(bgImage),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.5),
            BlendMode.srcATop,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withAlpha(85),
            blurRadius: 15.r,
            offset: Offset(5.w, 2.h),
          )
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(50.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 60.sp,
                  ),
            ),
            SizedBox(height: 20.h),
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(25.r),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: Icon(
                        Icons.calendar_today_outlined,
                        color: Colors.white,
                        size: 40.sp,
                      ),
                    ),
                    Text(
                      DateFormat('EEEE, MMMM d, y').format(dateTime),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40.sp,
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: Icon(
                        Icons.access_time,
                        color: Colors.white,
                        size: 30.sp,
                      ),
                    ),
                    Text(
                      time,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
