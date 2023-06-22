import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:on_reserve/Components/event_card.dart';
import 'package:on_reserve/Components/shimmer.dart';
import 'package:on_reserve/Controllers/home_controller.dart';
import 'package:on_reserve/Pages/search_delegate.dart';
import 'package:on_reserve/helpers/routes.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Home2 extends StatelessWidget {
  static const List<String> _data = [
    'Event 1',
    'Event 2',
    'Event 3',
    'Event 4',
    'Event 5'
  ];
  const Home2({super.key});
  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: BorderSide.none,
    );
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final homeController = Get.find<HomeController>();

    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GetBuilder<HomeController>(builder: (homeController) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Stack(
                  children: [
                    // Floating Quick Search
                    Container(
                      height: height * 0.6,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: PageView.builder(
                        controller: homeController.pageController,
                        itemCount: homeController.events.length,
                        onPageChanged: homeController.changePage,
                        itemBuilder: (_, index) {
                          return homeController.events
                              .map((event) => Image.asset(
                                    "assets/Images/${event.imageURL}",
                                    fit: BoxFit.cover,
                                  ))
                              .toList()[index % homeController.events.length];
                        },
                      ),
                    ),
                    Container(
                      height: height * 0.6,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withAlpha(160)
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 50,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: height * 0.065,
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          // color: Theme.of(context).colorScheme.background,
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                        ),
                        child: Container(
                          width: width * 0.8,
                          child: TextField(
                            controller: homeController.searchController,
                            style: TextStyle(
                              fontSize: 14,
                              height: 0.9,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onBackground
                                  .withAlpha(200),
                            ),
                            onTap: () {
                              showSearch<String>(
                                context: context,
                                delegate: MySearchDelegate(_data),
                              );
                            },
                            decoration: InputDecoration(
                              hintText: "Search for events",
                              hintStyle: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onBackground
                                    .withAlpha(120),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: border,
                              focusedBorder: border,
                              errorBorder: border,
                              disabledBorder: border,
                              filled: true,
                              constraints: BoxConstraints(
                                maxHeight: 30,
                              ),
                              fillColor:
                                  Theme.of(context).colorScheme.background,
                              // contentPadding: EdgeInsets.symmetric(
                              //     horizontal: 20, vertical: 16),
                              prefixIcon: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Icon(
                                  Icons.search_rounded,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: 20,
                      left: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            homeController
                                .events[homeController.currentPageIndex].title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            width: width * 0.9,
                            child: Wrap(children: [
                              Text(
                                homeController
                                    .events[homeController.currentPageIndex]
                                    .subtitle,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ]),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            width: width * 0.88,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 20),
                                  width: width * 0.38,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    child: Text(
                                      'Book Now',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Theme.of(context).colorScheme.primary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                ),
                                SmoothPageIndicator(
                                  controller: homeController.pageController,
                                  count: homeController.events.length,
                                  effect: WormEffect(
                                    dotWidth: 10.0,
                                    dotHeight: 10.0,
                                    activeDotColor:
                                        Theme.of(context).colorScheme.primary,
                                    dotColor: Theme.of(context)
                                        .colorScheme
                                        .background,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
              child: Text(
                'Popular Events',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 750.h,
              child: FutureBuilder(
                  future: homeController.getPopularEvents(),
                  initialData: [
                    // ContinueCard(
                    //   index: 1,
                    //   datetime: '12/12/2021',
                    //   title: 'Event Name',
                    //   bgImage:
                    //       'http://res.cloudinary.com/dsgpxgwxs/image/upload/v1686106147/onReserve/Profile/s9r9od8ty6wm5czt3bme.png',
                    // ),
                  ],
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Show a loading indicator while the future is waiting
                      return ListView.builder(
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.all(10),
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              child: ShimmerWidgets.rectangular(
                                  height: 650.h,
                                  width: 850.w,
                                  baseColor: Theme.of(context)
                                      .colorScheme
                                      .onBackground
                                      .withAlpha(80),
                                  highlightColor: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withAlpha(200)),
                            );
                          });
                    } else {
                      // When the future is done, check if it has an error or not
                      if (snapshot.hasError) {
                        // Show an error message if the future has an error
                        return Text('Error: ${snapshot.error}');
                      }
                    }
                    return ListView.builder(
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.all(12),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.eventDetail,
                                    arguments: snapshot.data![index]);
                              },
                              child: EventCard(
                                index: index,
                                datetime: snapshot.data![index]
                                    ['eventStartTime'],
                                title: snapshot.data![index]['title'],
                                bgImage: snapshot
                                            .data![index]['galleries'].length >
                                        0
                                    ? snapshot.data![index]['galleries'][0]
                                        ['eventPhoto']
                                    : 'https://wallpaperaccess.com/full/3787594.jpg',
                              ));
                        });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
