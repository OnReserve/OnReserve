import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:get/get.dart';

class ReviewsBottomSheet extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height * 0.5,
              maxHeight: MediaQuery.of(context).size.height * 0.8),
          child: Container(
            color: Theme.of(context).colorScheme.background,
            child: Column(
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
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20),
                    child: ListView(
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        getReceiverView(
                            ChatBubbleClipper4(type: BubbleType.receiverBubble),
                            context,
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
                        getReceiverView(
                            ChatBubbleClipper4(type: BubbleType.receiverBubble),
                            context,
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
                        getReceiverView(
                            ChatBubbleClipper4(type: BubbleType.receiverBubble),
                            context,
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _textEditingController,
                          maxLines: 5,
                          minLines: 2,
                          decoration: InputDecoration(
                            hintText: 'Write a review',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          // // Save the review and close the bottom sheet
                          // final reviewText = _textEditingController.text;
                          // // Do something with the review
                          // final newReview =
                          //     Review(userName: 'John Doe', reviewText: reviewText);
                          // setState(() {
                          //   widget.reviews.add(newReview);
                          // });
                          // _textEditingController.clear();
                        },
                        icon: Icon(
                          Icons.send,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
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

  getSenderView(CustomClipper clipper, BuildContext context, String text) =>
      ChatBubble(
        clipper: clipper,
        alignment: Alignment.topRight,
        margin: EdgeInsets.only(top: 20),
        backGroundColor: Theme.of(context).colorScheme.primary,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  getReceiverView(CustomClipper clipper, BuildContext context, String text) =>
      ChatBubble(
        clipper: clipper,
        backGroundColor: Color.fromARGB(255, 236, 231, 237),
        margin: EdgeInsets.only(top: 20),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: Text(
            text,
            style: TextStyle(color: Colors.black),
          ),
        ),
      );
}
