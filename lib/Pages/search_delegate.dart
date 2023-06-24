import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:on_reserve/helpers/routes.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:on_reserve/Controllers/theme_controller.dart';
import 'package:on_reserve/helpers/network/network_provider.dart';

class MySearchDelegate extends SearchDelegate<String> {
  final List<String> _data;

  MySearchDelegate(this._data);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<Widget>>(
      future: _search(query),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return snapshot.data![index];
              }
              // onTap: () {
              //   close(context, snapshot.data![index]);
              // },
              );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = _data
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index]),
          onTap: () {
            query = suggestions[index];
            close(context, query);
          },
        );
      },
    );
  }

  Future<List<Widget>> _search(String query) async {
    // Call your backend API here to search for data
    // Return a list of search results
    // For example:

    Color color = Get.find<ThemeController>().dark
        ? Color(0xFF706788)
        : Color(0xFFb3a8d1);
    try {
      final response =
          await NetworkHandler.get(endpoint: 'events/search/$query');
      if (response[1] == 200) {
        print("CEH ${response[0]}");
        final List<Widget> results = List<Widget>.generate(
          response[0].length,
          (index) {
            String timestamp = response[0][index]['createdAt'];

            // Parse the given timestamp into a DateTime object
            DateTime parsedTime = DateTime.parse(timestamp);

            // Get the current time
            DateTime currentTime = DateTime.now();

            // Calculate the difference between the parsed time and the current time
            Duration difference = parsedTime.difference(currentTime);

            Color color = Get.find<ThemeController>().dark
                ? Color(0xFF706788)
                : Color(0xFFb3a8d1);

            // Format the remaining time using the timeago package
            String remainingTime =
                timeago.format(currentTime.subtract(difference));
            return GestureDetector(
              onTap: () {
                Get.toNamed(Routes.eventDetail, arguments: response[0][index]);
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 25, horizontal: 25),
                decoration: BoxDecoration(
                  color: Get.theme.colorScheme.primary.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              response[0][index]['title'],
                              style: TextStyle(
                                  fontSize: 60.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Get.theme.colorScheme.background),
                            ),
                            Text(
                              remainingTime,
                              style: TextStyle(
                                  fontSize: 50.sp,
                                  color: Get.theme.colorScheme.background
                                      .withAlpha(200)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ShaderMask(
                      blendMode: BlendMode.srcATop,
                      shaderCallback: (Rect bounds) {
                        return LinearGradient(
                          colors: [
                            Colors.transparent,
                            color.withOpacity(0.5),
                            color
                          ],
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                        ).createShader(bounds);
                      },
                      child: Container(
                        width: 330.w,
                        height: 230.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                          ),
                          image: response[0][index]['galleries'].length > 0
                              ? DecorationImage(
                                  image: NetworkImage(
                                    response[0][index]['galleries'][0]
                                        ['eventPhoto'],
                                  ),
                                  fit: BoxFit.cover,
                                  opacity: 0.6,
                                )
                              : DecorationImage(
                                  image: CachedNetworkImageProvider(
                                    'https://wallpaperaccess.com/full/3787594.jpg',
                                  ),
                                  fit: BoxFit.cover,
                                  opacity: 0.6,
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
        return results;
      } else {
        throw Exception('Failed to search');
      }
    } catch (e) {
      print(e);
    }
    return [];
  }
}
