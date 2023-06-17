import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:on_reserve/helpers/routes.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:on_reserve/Components/shimmer.dart';
import 'package:on_reserve/Controllers/booking_controller.dart';

class BookingHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking History',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary)),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: ListOfCategories(w: _w),
    );
  }
}

class ListOfCategories extends StatelessWidget {
  const ListOfCategories({
    super.key,
    required double w,
  }) : _w = w;

  final double _w;

  @override
  Widget build(BuildContext context) {
    final bookingController = Get.find<BookingController>();
    return FutureBuilder(
        future: bookingController.getHistory(),
        initialData: [],
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator while the future is waiting
            return ListView.builder(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                padding: const EdgeInsets.all(10),
                itemCount: 8,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: ShimmerWidgets.rectangular(
                        height: 300.h,
                        width: 310.w,
                        baseColor: Colors.grey[400]!,
                        highlightColor: Colors.grey[100]!),
                  );
                });
          } else {
            // When the future is done, check if it has an error or not
            if (snapshot.hasError) {
              // Show an error message if the future has an error
              return Text('Error: ${snapshot.error}');
            }
          }
          // If the future is successful, but empty then show a message
          if (snapshot.data!.length == 0) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 50.h),
                  Icon(
                    Icons.event_busy,
                    size: 150.w,
                    color: Colors.grey[400],
                  ),
                  Text('No Bookings Yet',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey[400],
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
            );
          }
          // If the future is successful, display the booked tickets
          return ListView.builder(
            padding: EdgeInsets.all(_w / 30),
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              List<Widget> count = List.generate(
                snapshot.data![index]['vipCount'],
                (index) => Chip(
                  text: 'VIP',
                ),
                growable: true,
              );
              count.addAll(List.generate(
                snapshot.data![index]['economyCount'],
                (index) => Chip(
                  text: 'ECO',
                ),
                growable: true,
              ));

              String timestamp = snapshot.data![index]['event']['createdAt'];

              // Parse the given timestamp into a DateTime object
              DateTime parsedTime = DateTime.parse(timestamp);

              // Get the current time
              DateTime currentTime = DateTime.now();

              // Calculate the difference between the parsed time and the current time
              Duration difference = parsedTime.difference(currentTime);

              // Format the remaining time using the timeago package
              String remainingTime =
                  timeago.format(currentTime.subtract(difference));

              return Ticket(
                  w: _w,
                  remainingTime: remainingTime,
                  count: count,
                  snapshot: snapshot,
                  index: index);
            },
          );
        });
  }
}

class Ticket extends StatelessWidget {
  const Ticket({
    super.key,
    required double w,
    required this.remainingTime,
    required this.count,
    required this.snapshot,
    required this.index,
  }) : _w = w;

  final double _w;
  final String remainingTime;
  final List<Widget> count;
  final AsyncSnapshot snapshot;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.booking, arguments: snapshot.data![index]);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: _w / 30, horizontal: 5),
        height: _w / 4,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color:
                  Theme.of(context).colorScheme.onBackground.withOpacity(0.15),
              blurRadius: 20,
              spreadRadius: 8,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: _w / 4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                image: DecorationImage(
                  image: NetworkImage(
                    snapshot.data![index]['qrcode'],
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: _w / 20, top: _w / 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    snapshot.data![index]['event']['title'],
                    style: TextStyle(
                      fontSize: _w / 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  Text(
                    remainingTime,
                    style: TextStyle(
                      fontSize: _w / 30,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  // VIP chip
                  Row(children: count),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Chip extends StatelessWidget {
  const Chip({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, right: 4),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onBackground.withOpacity(0.25),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 6,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }
}
