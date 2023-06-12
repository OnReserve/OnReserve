import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:on_reserve/Components/revenue_counter.dart';

class MyCompanies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    int columnCount = 1;

    return Scaffold(
      appBar: AppBar(
        title: Text("My Companies"),
        centerTitle: true,
      ),
      body: AnimationLimiter(
        child: GridView.count(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          padding: EdgeInsets.all(_w / 60),
          crossAxisCount: columnCount,
          children: List.generate(
            50,
            (int index) {
              return AnimationConfiguration.staggeredGrid(
                position: index,
                duration: Duration(milliseconds: 500),
                columnCount: columnCount,
                child: ScaleAnimation(
                  duration: Duration(milliseconds: 900),
                  curve: Curves.fastLinearToSlowEaseIn,
                  child: FadeInAnimation(
                    child: Container(
                      margin: EdgeInsets.only(
                          bottom: _w / 30, left: _w / 80, right: _w / 80),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 40,
                            spreadRadius: 10,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: _w,
                            height: _w / 2.4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 40,
                                  spreadRadius: 10,
                                ),
                              ],
                              image: DecorationImage(
                                image: NetworkImage(
                                    "https://picsum.photos/seed/picsum/200/300"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(_w / 40),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.2),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Company Name",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 2),
                                            Text(
                                              "Company Address",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Stat(
                                        w: _w / 2.5,
                                        h: _w / 6,
                                        icon: Icon(Icons.attach_money),
                                        title: 'Total Revenue',
                                        value: RevenueCountUpAnimation(
                                          endValue: 124.56,
                                          duration: const Duration(seconds: 3),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Stat(
                                          w: _w / 3.5,
                                          h: _w / 6,
                                          title: 'Admins',
                                          value: Text(
                                            "2",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onBackground),
                                          ),
                                          icon: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 6.0),
                                            child: Icon(
                                              Icons.admin_panel_settings,
                                            ),
                                          )),
                                      Stat(
                                          w: _w / 3.5,
                                          h: _w / 6,
                                          title: 'Events',
                                          value: Text(
                                            "0",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onBackground),
                                          ),
                                          icon: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 6.0),
                                            child: Icon(
                                              Icons.event,
                                            ),
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class Stat extends StatelessWidget {
  const Stat({
    super.key,
    required this.w,
    this.bgColor,
    required this.h,
    required this.title,
    required this.value,
    required this.icon,
  });

  final double w;
  final double h;
  final String title;
  final Widget value;
  final Widget icon;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: w,
      height: h,
      padding: EdgeInsets.all(w / 50),
      decoration: BoxDecoration(
        color:
            bgColor ?? Theme.of(context).colorScheme.primary.withOpacity(0.12),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon,
          SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 144, 144, 144),
                ),
              ),
              value,
            ],
          ),
        ],
      ),
    );
  }
}
