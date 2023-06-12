import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_actions/card_action_button.dart';
import 'package:card_actions/card_actions.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:on_reserve/Components/revenue_counter.dart';
import 'package:on_reserve/Components/shimmer.dart';
import 'package:on_reserve/Pages/my_companies.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

class CompanyProfile extends StatefulWidget {
  const CompanyProfile({super.key});

  @override
  State<CompanyProfile> createState() => CompanyProfileState();
}

class CompanyProfileState extends State<CompanyProfile> {
  final double coverHeight = 200;
  final double profileHeight = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              buildCoverImage(),
              Positioned(
                top: coverHeight - (profileHeight / 2),
                child: biuldProfileImage(),
              ),
              Positioned(
                top: 25,
                right: 20,
                child: buildEditProfileIcon(),
              ),
              Positioned(
                top: 25,
                left: 20,
                child: buildBackButton(),
              )
            ],
          ),
          SizedBox(height: 50),
          buildCompanyDetail(),
          SizedBox(height: 5),
          buildAdminTab(context),
          SizedBox(height: 20),
          buildEventTab(),
          SizedBox(height: 100),
        ],
      ),
    ));
  }

  Widget buildBackButton() {
    return Container(
      height: 35,
      width: 35,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withAlpha(120),
        borderRadius: BorderRadius.circular(50),
      ),
      child: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(
          Icons.arrow_back_ios,
          size: 13,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget buildEditProfileIcon() {
    return Container(
      height: 35,
      width: 35,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withAlpha(120),
        borderRadius: BorderRadius.circular(50),
      ),
      child: IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.edit,
          size: 12,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget buildCompanyDetail() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.08),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header(
              //   title: 'Company Name',
              //   onTap: () {},
              // ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: DataTable(
                  columns: [
                    DataColumn(
                      label: Text(
                        "Company Name",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(label: Text('')),
                  ],
                  rows: [
                    DataRow(cells: [
                      DataCell(Text(
                        'Created',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                      DataCell(Text('June 12, 2023')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text(
                        'Admins',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                      DataCell(Text('5')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text(
                        'Total Events',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                      DataCell(Text('23')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text(
                        'Total Revenue',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                      DataCell(Text('500 ETB')),
                    ]),
                  ],
                ),
              )
            ]));
  }

  Widget buildCoverImage() {
    return Container(
      color: Colors.grey[300],
      child: CachedNetworkImage(
        imageUrl:
            'http://res.cloudinary.com/dsgpxgwxs/image/upload/v1686293226/onReserve/Profile/wlru9yrmbxu9lfkfj9fu.jpg',
        fit: BoxFit.cover,
        height: coverHeight,
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }

  Widget biuldProfileImage() {
    return Container(
      height: profileHeight,
      width: profileHeight,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 3),
        borderRadius: BorderRadius.circular(50),
        image: DecorationImage(
          image: AssetImage('assets/Images/Rophnan.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget buildEventTab() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.08),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Header(
              title: 'Events',
              onTap: () {},
              addable: true,
            ),
            Container(
              margin: const EdgeInsets.all(20),
              child: CardActions(
                buttonsCursor: SystemMouseCursors.click,
                backgroundColor: Theme.of(context).colorScheme.primary,
                axisDirection: CardActionAxis.bottom,
                borderRadius: 15,
                width: 600,
                height: 220,
                actions: [
                  CardActionButton(
                    icon: const Icon(
                      Icons.qr_code,
                      color: Colors.white,
                      size: 20,
                    ),
                    label: 'Scan QR Code',
                    onPress: () {},
                  ),
                  CardActionButton(
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 20,
                    ),
                    label: 'Edit',
                    onPress: () {
                      // setState(() {
                      //   counter = 0;
                      // });
                    },
                  ),
                  CardActionButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 20,
                    ),
                    label: 'Delete',
                    onPress: () {},
                  ),
                ],
                child: EventCard(counter: 1),
              ),
            ),
            SizedBox(height: 15),
          ],
        ));
  }
}

Widget buildAdminTab(BuildContext context) {
  TextEditingController _emailController = TextEditingController();
  void showEmailDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Admin Email', style: TextStyle(fontSize: 16)),
          content: TextField(
            controller: _emailController,
            decoration: InputDecoration(
              hintText: 'Enter email address',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Submit'),
              onPressed: () {
                String email = _emailController.text;
                // Do something with email, such as send it to a server for verification
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Header(
            title: 'Admins',
            addable: true,
            onTap: () {
              showEmailDialog(context);
            },
          ),
          SlidableList(),
          SizedBox(height: 15),
        ],
      ));
}

class SlidableList extends StatelessWidget {
  const SlidableList({
    super.key,
  });

  Future getAdmins() {
    return Future.delayed(Duration(seconds: 5));
  }

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;
    return Container(
        width: w,
        height: 1000.h,
        child: FutureBuilder(
            future: getAdmins(),
            initialData: [
              Slide(
                name: "Admin",
                email: "admin@gmail.com",
                profilePic:
                    "http://res.cloudinary.com/dsgpxgwxs/image/upload/v1686293226/onReserve/Profile/wlru9yrmbxu9lfkfj9fu.jpg",
              ),
            ],
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.done
                  ? ListView.builder(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Slide(
                          name: "$index",
                          email: "snapshot.data![index].date",
                          profilePic:
                              "https://picsum.photos/seed/picsum/200/300",
                        );
                      })
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      padding: const EdgeInsets.all(10),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: ShimmerWidgets.rectangular(
                              height: 250.h,
                              width: 850.w,
                              baseColor:
                                  const Color.fromARGB(255, 205, 205, 205),
                              highlightColor: Colors.grey[100]!),
                        );
                      });
            }));
  }
}

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.title,
    required this.onTap,
    this.addable = false,
  });
  final String title;
  final void Function() onTap;
  final bool addable;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 20, top: 10),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              addable
                  ? Padding(
                      padding: EdgeInsets.only(right: 20, top: 10),
                      child:
                          IconButton(onPressed: onTap, icon: Icon(Icons.add)),
                    )
                  : Container(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Divider(
              color: Colors.blueGrey,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class Slide extends StatelessWidget {
  final String name;
  final String email;
  final String profilePic;

  const Slide({
    super.key,
    required this.name,
    required this.email,
    required this.profilePic,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(uuid.v4()),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(onDismissed: () {
          // snackbar
          Get.snackbar(
            'Admin Removed',
            'Admin has been removed from the company',
            snackPosition: SnackPosition.BOTTOM,
          );
        }),
        children: const [
          SlidableAction(
            onPressed: null,
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      endActionPane: const ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: null,
            backgroundColor: Color(0xFF21B7CA),
            foregroundColor: Colors.white,
            icon: Icons.share,
            label: 'Edit',
          ),
          SlidableAction(
            onPressed: null,
            backgroundColor: Color(0xFF0392CF),
            foregroundColor: Colors.white,
            icon: Icons.save,
            label: 'Save',
          ),
        ],
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.white,
            child: CachedNetworkImage(
              imageUrl: profilePic,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          title: Text(name),
          subtitle: Text(email),
        ),
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  const EventCard({
    super.key,
    required this.counter,
  });
  final int counter;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600,
      height: 220,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.lighten(20),
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(10, 10),
            blurRadius: 20,
            // spreadRadius: 20,
          )
        ],
      ),
      child: Row(
        children: [
          // Hero Image
          Container(
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: const DecorationImage(
                image:
                    NetworkImage('https://picsum.photos/seed/picsum/200/300'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    'Event Date',
                    style: TextStyle(
                      color: Colors.white,
                      // fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    "Event Name",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  RatingBar.builder(
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemSize: 20,
                    itemCount: 5,
                    itemPadding:
                        EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                  const SizedBox(height: 15),
                  Stat(
                    w: 200,
                    h: 70,
                    icon: Icon(Icons.attach_money),
                    bgColor: Colors.white.withOpacity(0.5),
                    title: 'Total Revenue',
                    value: RevenueCountUpAnimation(
                      endValue: 124.56,
                      duration: const Duration(seconds: 3),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
