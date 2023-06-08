import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:on_reserve/Controllers/category_controller.dart';

class Category extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categoryController = Get.find<CategoryController>();
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryController.args['category']!),
        centerTitle: true,
        // brightness: Brightness.dark,
      ),
      body: AnimationLimiter(
        child: ListOfCategories(w: _w),
      ),
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
    final categoryController = Get.find<CategoryController>();
    return categoryController.args['events']!.isEmpty
        ? Center(
            child: Text(
              'No events found',
              style: TextStyle(
                fontSize: _w / 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          )
        : ListView.builder(
            padding: EdgeInsets.all(_w / 30),
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            itemCount: categoryController.args['events']!.length,
            itemBuilder: (BuildContext context, int index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                delay: Duration(milliseconds: 100),
                child: SlideAnimation(
                  duration: Duration(milliseconds: 2500),
                  curve: Curves.fastLinearToSlowEaseIn,
                  child: FadeInAnimation(
                    curve: Curves.fastLinearToSlowEaseIn,
                    duration: Duration(milliseconds: 2500),
                    child: GestureDetector(
                      onTap: () {
                        print(categoryController.args['events']![0]);
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: _w / 20),
                        height: _w / 4,
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.5),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onBackground
                                  .withOpacity(0.1),
                              blurRadius: 40,
                              spreadRadius: 10,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            categoryController.args['events']![index]['name'],
                            style: TextStyle(
                              fontSize: _w / 20,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
  }
}
