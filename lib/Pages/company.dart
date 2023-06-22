import 'package:cached_network_image/cached_network_image.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:on_reserve/Components/card_action_button.dart';
import 'package:on_reserve/Components/card_actions.dart';
import 'package:on_reserve/Components/revenue_counter.dart';
import 'package:on_reserve/Components/shimmer.dart';
import 'package:on_reserve/Controllers/company_profile_controller.dart';
import 'package:on_reserve/Controllers/profile_controller.dart';
import 'package:on_reserve/Controllers/theme_controller.dart';
import 'package:on_reserve/Pages/Profile%20Bottom%20Sheets/edit_company.dart';
import 'package:on_reserve/Pages/my_companies.dart';
import 'package:on_reserve/helpers/routes.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

class CompanyProfile extends StatelessWidget {
  const CompanyProfile({super.key});

  final double coverHeight = 240;
  final double profileHeight = 100;

  @override
  Widget build(BuildContext context) {
    // width
    double w = MediaQuery.of(context).size.width;
    var controller = Get.find<CompanyProfileController>();
    DateTime dateTime = DateTime.parse(controller.args['company']['createdAt']);

    String date = DateFormat('MMMM d yyyy').format(dateTime);

    return Scaffold(
        body: SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: GetBuilder<CompanyProfileController>(builder: (controller) {
        return Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                buildCoverImage(controller),
                Positioned(
                  top: coverHeight - (profileHeight / 2),
                  child: biuldProfileImage(controller),
                ),
                Positioned(
                  top: 45,
                  right: 30,
                  child: EditProfileIcon(),
                ),
                Positioned(
                  top: 45,
                  left: 30,
                  child: buildBackButton(context),
                )
              ],
            ),
            SizedBox(height: 50),
            buildCompanyDetail(w, controller, date, context),
            SizedBox(height: 5),
            buildAdminTab(context, controller),
            SizedBox(height: 20),
            EventTab(controller: controller),
            SizedBox(height: 100),
          ],
        );
      }),
    ));
  }

  Widget buildBackButton(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
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
          size: 15,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget buildCompanyDetail(
    double w,
    CompanyProfileController controller,
    var date,
    BuildContext context,
  ) {
    return Container(
        width: w,
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.08),
          borderRadius: BorderRadius.circular(10),
        ),
        child: DataTable(
          columns: [
            DataColumn(
              label: Text(
                controller.args['company']['name'],
                style: TextStyle(
                  fontSize: 18,
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
              DataCell(Text("$date")),
            ]),
            DataRow(cells: [
              DataCell(Text(
                'Admins',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              )),
              DataCell(Text(
                  controller.args['company']['_count']['users'].toString())),
            ]),
            DataRow(cells: [
              DataCell(Text(
                'Total Events',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              )),
              DataCell(Text(
                  controller.args['company']['_count']['events'].toString())),
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
        ));
  }

  Widget buildCoverImage(CompanyProfileController controller) {
    return Container(
      width: double.infinity,
      color: Colors.grey[300],
      child: CachedNetworkImage(
        imageUrl: controller.args['company']['coverPic'],
        fit: BoxFit.cover,
        height: coverHeight,
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }

  Widget biuldProfileImage(CompanyProfileController controller) {
    return Container(
      height: profileHeight,
      width: profileHeight,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 3),
        borderRadius: BorderRadius.circular(50),
        image: DecorationImage(
          image: CachedNetworkImageProvider(
            controller.args['company']['profPic'],
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class EventTab extends StatelessWidget {
  const EventTab({
    super.key,
    required this.controller,
  });

  final CompanyProfileController controller;

  @override
  Widget build(BuildContext context) {
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
              onTap: () {
                Get.toNamed(Routes.addEvent, arguments: {
                  'companies': [controller.args],
                  'categories': controller.categories
                });
              },
              addable: true,
            ),
            GetBuilder<CompanyProfileController>(builder: (controller) {
              return Container(
                height: 2000.h,
                child: FutureBuilder(
                  future: controller.getCompanyProfile(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: snapshot.data != null
                            ? snapshot.data!['events'].length
                            : 0,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.all(20),
                            child: CardActions(
                              // buttonsCursor: SystemMouseCursors.click,
                              showToolTip: true,
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
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
                                  onPress: () {
                                    Get.toNamed(Routes.qr);
                                  },
                                ),
                                CardActionButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  label: 'Edit',
                                  onPress: () {
                                    Get.toNamed(Routes.addEvent, arguments: {
                                      'companies': [controller.args],
                                      'categories': controller.categories,
                                      'event': snapshot.data!['events'][index]
                                    });
                                  },
                                ),
                                CardActionButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  label: 'Delete',
                                  onPress: () async {
                                    if (await controller.removeEvent(snapshot
                                        .data!['events'][index]['id'])) {
                                      Get.snackbar('Success', 'Event Deleted');
                                    } else {
                                      Get.snackbar(
                                          'Error', 'Event Not Deleted');
                                    }
                                  },
                                ),
                              ],
                              child: EventCard(
                                eventDate: snapshot.data!['events'][index]
                                    ['eventStartTime'],
                                eventName: snapshot.data!['events'][index]
                                    ['title'],
                                eventPic: snapshot
                                            .data!['events'][index]['galleries']
                                            .length >
                                        0
                                    ? snapshot.data!['events'][index]
                                        ['galleries'][0]['eventPhoto']
                                    : 'https://wallpaperaccess.com/full/3787594.jpg',
                                eventRating: '3',
                                totalRevenue: 100.0,
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              );
            }),
            SizedBox(height: 15),
          ],
        ));
  }
}

class EditProfileIcon extends StatelessWidget {
  const EditProfileIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CompanyProfileController>();
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withAlpha(120),
        borderRadius: BorderRadius.circular(50),
      ),
      child: IconButton(
        onPressed: () {
          controller.name.text = '${controller.args['company']['name']}';
          controller.bio.text = '${controller.args['company']['bio']}';
          controller.coverPic = null;
          controller.profilePic = null;
          Get.bottomSheet(
            const EditCompanyBottomSheet(),
            shape: Get.theme.bottomSheetTheme.shape,
            isScrollControlled: true,
            clipBehavior: Clip.hardEdge,
            useRootNavigator: true,
            enableDrag: true,
          );
        },
        icon: Icon(
          Icons.edit,
          size: 15,
          color: Colors.white,
        ),
      ),
    );
  }
}

Widget buildAdminTab(
    BuildContext context, CompanyProfileController controller) {
  TextEditingController _emailController = TextEditingController();
  void showEmailDialog(BuildContext context) {
    var controller = Get.find<CompanyProfileController>();
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
              onPressed: () async {
                String email = _emailController.text;
                // Do something with email, such as send it to a server for verification
                if (await controller.addAdmin(email)) {
                  Navigator.of(context).pop();
                  controller.getCompanyProfile();
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Admin Succesfully Added")));
                } else {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Check Admin Email")));
                }
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

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;
    return GetBuilder<CompanyProfileController>(builder: (controller) {
      return Container(
          width: w,
          height: 1550.h,
          child: FutureBuilder(
              future: controller.getCompanyProfile(),
              builder: (context, snapshot) {
                return snapshot.connectionState == ConnectionState.done
                    ? snapshot.data!.isEmpty
                        ? Center(
                            child: Text('No Admins'),
                          )
                        : ListView.builder(
                            physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            itemCount: snapshot.data != null
                                ? snapshot.data!['admin'].length
                                : 0,
                            itemBuilder: (context, index) {
                              return Slide(
                                name:
                                    "${snapshot.data!['admin'][index]['user']['fname']} ${snapshot.data!['admin'][index]['user']['lname']}",
                                email: snapshot.data!['admin'][index]['user']
                                    ['email'],
                                profilePic: !snapshot.data!['admin'][index]
                                            ['user']['profile']['profilePic']
                                        .startsWith('https://api.')
                                    ? snapshot.data!['admin'][index]['user']
                                        ['profile']['profilePic']
                                    : 'https://img.freepik.com/free-icon/user_318-159711.jpg',
                              );
                            })
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        padding: const EdgeInsets.all(10),
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: ShimmerWidgets.rectangular(
                                height: 250.h,
                                width: 850.w,
                                baseColor:
                                    const Color.fromARGB(255, 205, 205, 205),
                                highlightColor: Colors.grey[100]!),
                          );
                        });
              }));
    });
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
    var controller = Get.find<CompanyProfileController>();
    return Slidable(
      key: ValueKey(uuid.v4()),
      enabled: email != Get.find<ProfileController>().user!.email,
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(
          onDismissed: () async {
            if (await controller.removeAdmin(email)) {
              // snackbar
              Get.snackbar(
                'Admin Removed',
                'Admin has been removed from the company',
                snackPosition: SnackPosition.BOTTOM,
              );
            } else {
              Get.snackbar(
                'Error',
                'Something went wrong',
                snackPosition: SnackPosition.BOTTOM,
              );
            }
          },
        ),
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
    required this.eventName,
    required this.eventDate,
    required this.eventPic,
    required this.eventRating,
    required this.totalRevenue,
  });
  final String eventName;
  final String eventDate;
  final String eventPic;
  final String eventRating;
  final double totalRevenue;

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ThemeController>();
    DateTime dateTime = DateTime.parse(eventDate);

    String date = DateFormat('MMMM d yyyy').format(dateTime);
    return Container(
      width: 600,
      height: 220,
      decoration: BoxDecoration(
        color: controller.dark
            ? Theme.of(context).colorScheme.primary.darken(10)
            : Theme.of(context).colorScheme.primary.lighten(20),
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
              image: DecorationImage(
                image: CachedNetworkImageProvider(eventPic),
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
                  Text(
                    date,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    eventName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  RatingBar.builder(
                    initialRating: double.parse(eventRating),
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
                      endValue: totalRevenue,
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
