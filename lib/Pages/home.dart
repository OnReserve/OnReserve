import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:on_reserve/Components/event_card.dart';
import 'package:on_reserve/Components/shimmer.dart';
import 'package:on_reserve/Controllers/home_controller.dart';
import 'package:on_reserve/Controllers/theme_controller.dart';
import 'package:on_reserve/Models/event_overview.dart';
import 'package:on_reserve/helpers/routes.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Get.find<ThemeController>();
    Get.find<HomeController>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          GetBuilder<ThemeController>(builder: (themeController) {
            return IconButton(
                onPressed: () {
                  themeController.toggle();
                },
                icon: Icon(
                    !themeController.dark ? Icons.dark_mode : Icons.sunny));
          }),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 10.0, 0.0, 0.0),
            child: Text(
              'Explore Events',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontFamily: 'PaytoneOne',
                  fontSize: 85.sp,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
            child: Card(
              child: TextFormField(
                controller: searchController,
                decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.search),
                  hintText: 'Search...',
                  // focusColor: Color.fromARGB(255, 203, 203, 203),k
                  filled: true,
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 95.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Text(
                    'Popular',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontFamily: 'PaytoneOne',
                        fontSize: 75.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Divider(
                    color: Theme.of(context).colorScheme.onBackground,
                    thickness: 2,
                  ),
                ),
                SizedBox(
                    height: 650.h,
                    child:
                        GetBuilder<HomeController>(builder: (homeController) {
                      return FutureBuilder(
                          future: homeController.getPopularEvents(),
                          initialData: [
                            EventOverview(
                                id: 1,
                                title: "Rophnan Concert",
                                date: "2021-10-10",
                                imageURL:
                                    "http://res.cloudinary.com/dsgpxgwxs/image/upload/v1686106147/onReserve/Profile/s9r9od8ty6wm5czt3bme.png"),
                          ],
                          builder: (context, snapshot) {
                            return snapshot.connectionState ==
                                    ConnectionState.done
                                ? ListView.builder(
                                    physics: const BouncingScrollPhysics(
                                        parent:
                                            AlwaysScrollableScrollPhysics()),
                                    scrollDirection: Axis.horizontal,
                                    padding: const EdgeInsets.all(10),
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      return ContinueCard(
                                        index: index,
                                        date: snapshot.data![index].date,
                                        title: snapshot.data![index].title,
                                        bgImage: snapshot.data![index].imageURL,
                                      );
                                    })
                                : ListView.builder(
                                    physics: const BouncingScrollPhysics(
                                        parent:
                                            AlwaysScrollableScrollPhysics()),
                                    scrollDirection: Axis.horizontal,
                                    padding: const EdgeInsets.all(10),
                                    itemCount: 3,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: ShimmerWidgets.rectangular(
                                            height: 650.h,
                                            width: 850.w,
                                            baseColor: Colors.grey[400]!,
                                            highlightColor: Colors.grey[100]!),
                                      );
                                    });
                          });
                    })),
                SizedBox(height: 85.h),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Text(
                    'Categories',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontFamily: 'PaytoneOne',
                        fontSize: 75.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Divider(
                    color: Theme.of(context).colorScheme.onBackground,
                    thickness: 2,
                  ),
                ),
                GetBuilder<HomeController>(builder: (homeController) {
                  return SizedBox(
                    height: 850.h,
                    child: FutureBuilder(
                        future: homeController.getCategories(),
                        builder: (context, snapshot) {
                          return GridView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 22),
                            physics: const BouncingScrollPhysics(
                                parent: NeverScrollableScrollPhysics()),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 2.2,
                              crossAxisSpacing: 0,
                              mainAxisSpacing: 0,
                            ),
                            itemCount: snapshot.data == null
                                ? 0
                                : snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return snapshot.connectionState ==
                                      ConnectionState.done
                                  ? GestureDetector(
                                      onTap: () {
                                        print(snapshot.data);
                                        Get.toNamed(Routes.category,
                                            arguments: {
                                              'category': snapshot.data![index]
                                                  ['name'],
                                              'events': snapshot.data![index]
                                                  ['events'] as List
                                            });
                                      },
                                      child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 12),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(18),
                                            boxShadow: [
                                              BoxShadow(
                                                color: const Color.fromARGB(
                                                        255, 113, 113, 113)
                                                    .withOpacity(0.5),
                                                spreadRadius: 1,
                                                blurRadius: 7,
                                                offset: const Offset(0, 3),
                                              ),
                                            ],
                                            gradient: LinearGradient(
                                                begin: const Alignment(-1, 1),
                                                end: const Alignment(1, -1),
                                                colors: [
                                                  Color.fromARGB(
                                                      255, 104, 127, 167),
                                                  Color.fromARGB(
                                                      255, 112, 121, 154),
                                                  Color.fromARGB(
                                                      255, 88, 101, 133),
                                                ]),
                                          ),
                                          child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      left: 20.w),
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 35.w),
                                                  height: 120.h,
                                                  width: 120.w,
                                                  child: Icon(
                                                    Icons
                                                        .movie_creation_rounded,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onPrimary,
                                                  ),
                                                ),
                                                SizedBox(width: 5.w),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      snapshot.data![index]
                                                          ['name'],
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge!
                                                          .copyWith(
                                                              fontFamily:
                                                                  'PaytoneOne',
                                                              fontSize: 50.sp,
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .onPrimary),
                                                    ),
                                                    Text(
                                                      "${snapshot.data![index]['events'].length} Events",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge!
                                                          .copyWith(
                                                              fontFamily:
                                                                  'PaytoneOne',
                                                              fontSize: 30.sp,
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .onPrimary),
                                                    ),
                                                  ],
                                                ),
                                              ])),
                                    )
                                  : Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      child: ShimmerWidgets.rectangular(
                                          width: 100,
                                          height: 150,
                                          baseColor: Colors.grey[400]!,
                                          highlightColor: Colors.grey[100]!),
                                    );
                            },
                          );
                        }),
                  );
                })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
