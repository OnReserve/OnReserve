import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:on_reserve/Controllers/event_controller.dart';
import 'package:on_reserve/Controllers/profile_controller.dart';

class ReviewsBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<EventController>();
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height * 0.5,
              maxHeight: MediaQuery.of(context).size.height * 0.68),
          child: Container(
            color: Theme.of(context).colorScheme.background,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          child: Text(
                            'Reviews',
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                    ),
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(Icons.close_outlined)),
                    ],
                  ),
                ),
                GetBuilder<EventController>(builder: (controller) {
                  return controller.rated
                      ? SizedBox()
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 2),
                          child: Row(
                            children: [
                              RatingBar.builder(
                                initialRating: 3,
                                minRating: 1,
                                tapOnlyMode: false,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemSize: 20,
                                itemCount: 5,
                                itemPadding: EdgeInsets.symmetric(
                                    horizontal: 2, vertical: 5),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  controller.userRating = rating;
                                  controller.update();
                                },
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  controller.userRating.toString(),
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        );
                }),
                GetBuilder<EventController>(builder: (controller) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20),
                      child: FutureBuilder(
                          future: controller.getReview(),
                          builder: (context, snapshot) {
                            return snapshot.connectionState ==
                                    ConnectionState.done
                                ? snapshot.data == null ||
                                        snapshot.data!.isEmpty
                                    ? Center(
                                        child: Text('No Reviews Yet'),
                                      )
                                    : ListView(
                                        children: List<Widget>.generate(
                                            snapshot.data!.length, (index) {
                                          Review review = snapshot.data![index];
                                          var controller2 =
                                              Get.find<ProfileController>();
                                          if (review.userId ==
                                              controller2.user!.id) {
                                            return getSenderView(
                                              ChatBubbleClipper4(
                                                  type: BubbleType.sendBubble),
                                              context,
                                              review.review,
                                              review.rating,
                                            );
                                          } else {
                                            return getReceiverView(
                                              ChatBubbleClipper4(
                                                  type: BubbleType
                                                      .receiverBubble),
                                              context,
                                              review.review,
                                              review.rating,
                                            );
                                          }
                                        }),
                                      )
                                : Center(
                                    child: CircularProgressIndicator.adaptive(),
                                  );
                          }),
                    ),
                  );
                }),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller.textEditingController,
                          enabled: !controller.rated,
                          maxLines: 5,
                          minLines: 1,
                          decoration: InputDecoration(
                            hintText: 'Write a review',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      GetBuilder<EventController>(builder: (controller) {
                        return controller.isLoading
                            ? CircularProgressIndicator.adaptive()
                            : IconButton(
                                onPressed: controller.rated
                                    ? null
                                    : () {
                                        controller.addReview();
                                        controller.textEditingController
                                            .clear();
                                        controller.rated = true;
                                        controller.update();
                                      },
                                icon: Icon(
                                  Icons.send,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  getTitleText(String title) => Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      );

  getSenderView(CustomClipper clipper, BuildContext context, String text,
          int rating) =>
      ChatBubble(
        clipper: clipper,
        alignment: Alignment.topRight,
        margin: EdgeInsets.only(top: 20),
        backGroundColor: Theme.of(context).colorScheme.primary,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 600.w,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                      children: List.generate(
                    5,
                    (index) => Icon(
                      Icons.star,
                      color: rating > index
                          ? Colors.yellow[600]
                          : Theme.of(context)
                              .colorScheme
                              .background
                              .withAlpha(100),
                      size: 75.r,
                    ),
                  )),
                ),
              ),
              Text(
                text,
                style:
                    TextStyle(color: Theme.of(context).colorScheme.background),
              ),
            ],
          ),
        ),
      );

  getReceiverView(CustomClipper clipper, BuildContext context, String text,
          int rating) =>
      ChatBubble(
        clipper: clipper,
        backGroundColor: Theme.of(context).colorScheme.background.lighten(10),
        margin: EdgeInsets.only(top: 20),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 600.w,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                      children: List.generate(
                    5,
                    (index) => Icon(
                      Icons.star,
                      color: rating > index
                          ? Colors.yellow[600]
                          : Colors.grey[500],
                      size: 75.r,
                    ),
                  )),
                ),
              ),
              Text(
                text,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
            ],
          ),
        ),
      );
}
