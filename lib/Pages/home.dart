import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:on_reserve/Components/event_card.dart';
import 'package:on_reserve/Components/shimmer.dart';
import 'package:on_reserve/Controllers/home_controller.dart';
import 'package:on_reserve/Controllers/theme_controller.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ThemeController themeController = Get.find();
    HomeController homeController = Get.find();
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
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 20.0, 0.0, 0.0),
            child: Text(
              'Explore Events',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontFamily: 'PaytoneOne', fontSize: 85.sp),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
            child: Card(
              child: TextFormField(
                controller: searchController,
                decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.search),
                  hintText: 'Search...',
                  fillColor: Color(0xFFe4e4e4),
                  focusColor: Color.fromARGB(255, 203, 203, 203),
                  filled: true,
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 145.h),
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
                        color: Colors.grey[800]),
                  ),
                ),
                SizedBox(height: 25.h),
                SizedBox(
                    height: 650.h,
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.all(10),
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return ContinueCard(
                            index: index,
                            remainingTime: "500.0",
                            subject: "saved.examData.subject",
                          );
                        })),
                SizedBox(height: 105.h),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Text(
                    'Categories',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontFamily: 'PaytoneOne',
                        fontSize: 75.sp,
                        color: Colors.grey[800]),
                  ),
                ),
                SizedBox(height: 50.h),
                GetBuilder<HomeController>(builder: (homeController) {
                  return SizedBox(
                    height: 750.h,
                    child: FutureBuilder(
                        future: null,
                        builder: (context, snapshot) {
                          return GridView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 22),
                            physics: const BouncingScrollPhysics(
                                parent: NeverScrollableScrollPhysics()),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 2.5,
                              crossAxisSpacing: 0,
                              mainAxisSpacing: 0,
                            ),
                            itemCount: 6,
                            itemBuilder: (context, index) {
                              return !snapshot.hasData
                                  ? Container(
                                      margin: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(18),
                                        color: Colors.blue,
                                      ))
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
