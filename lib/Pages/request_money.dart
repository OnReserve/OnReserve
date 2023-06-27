import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:on_reserve/Components/revenue_counter.dart';
import 'package:on_reserve/Controllers/payment_request.dart';
import 'package:on_reserve/Pages/my_companies.dart';
import 'package:on_reserve/Pages/request_bottomsheet.dart';
import 'package:on_reserve/helpers/routes.dart';

class RequestMoney extends StatefulWidget {
  const RequestMoney({super.key});

  @override
  State<RequestMoney> createState() => _RequestMoneyState();
}

class _RequestMoneyState extends State<RequestMoney> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RequestMoneyController>();

    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          controller.args['event']['title'],
          style: TextStyle(
            fontSize: 70.sp,
            fontWeight: FontWeight.bold,
            fontFamily: "Inter",
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShaderMask(
              blendMode: BlendMode.srcATop,
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  colors: [
                    Colors.transparent,
                    Theme.of(context).colorScheme.background.withOpacity(0.58),
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
                items: List<Widget>.from(
                    controller.args['event']['galleries'].map((i) {
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
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  "Event Details",
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
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Event : ",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w500,
                            fontSize: 68.sp,
                          ),
                        ),
                      ),
                      Container(
                          // width: 135,
                          height: 65,
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.12),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Center(
                            child: Text(
                              controller.args['event']['title'],
                              style: TextStyle(
                                // color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w500,
                                fontSize: 60.sp,
                              ),
                            ),
                          )),
                    ],
                  ),
                  SizedBox(height: 70.h),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Total Revenue : ",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w500,
                            fontSize: 68.sp,
                          ),
                        ),
                      ),
                      Stat(
                        w: 135,
                        h: 65,
                        icon: Icon(Icons.attach_money),
                        title: 'Gross ',
                        value: RevenueCountUpAnimation(
                          money: true,
                          endValue: double.parse(controller.details
                                  .containsKey('totalRevenue')
                              ? controller.details['totalRevenue'].toString()
                              : "0"),
                          duration: const Duration(seconds: 3),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 70.h),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Total No. Tickets : ",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w500,
                            fontSize: 68.sp,
                          ),
                        ),
                      ),
                      Stat(
                        w: 135,
                        h: 65,
                        icon: Icon(
                          Icons.confirmation_num,
                          size: 75.r,
                        ),
                        title: 'Tickets ',
                        value: RevenueCountUpAnimation(
                          // money: true,
                          endValue: double.parse(controller.details
                                  .containsKey('vipCount')
                              ? "${controller.details['vipCount'] + controller.details['economyCount']}"
                              : "0"),
                          duration: const Duration(seconds: 3),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 100.h),
                  GetBuilder<RequestMoneyController>(builder: (controller) {
                    return SizedBox(
                      width: double.infinity,
                      height: 180.h,
                      child: ElevatedButton(
                        onPressed: controller.can
                            ? () {
                                if (controller.details['vipCount'] +
                                        controller.details['economyCount'] >
                                    0) {
                                  Get.bottomSheet(
                                    const RequestMoneyBottomSheet(),
                                    shape: Get.theme.bottomSheetTheme.shape,
                                    isScrollControlled: true,
                                    clipBehavior: Clip.hardEdge,
                                    useRootNavigator: true,
                                    enableDrag: true,
                                  );
                                } else {
                                  Get.snackbar(
                                    'Nothing to Request For ... ',
                                    'The event has not yet generated a revenue',
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor:
                                        const Color.fromARGB(255, 226, 102, 93),
                                    colorText: Colors.white,
                                    margin: EdgeInsets.all(10),
                                    borderRadius: 10,
                                    duration: Duration(seconds: 3),
                                    isDismissible: true,
                                    dismissDirection:
                                        DismissDirection.horizontal,
                                    forwardAnimationCurve: Curves.easeOutBack,
                                  ); //
                                }
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            maximumSize: Size.fromHeight(180.h)),
                        child: Text(
                          "Request Payment",
                          style: TextStyle(
                            fontSize: 60.sp,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.7,
                            fontFamily: "Inter",
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
