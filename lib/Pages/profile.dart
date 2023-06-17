import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:on_reserve/Components/shimmer.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:on_reserve/Controllers/profile_controller.dart';
import 'package:on_reserve/Pages/Profile%20Bottom%20Sheets/add_company.dart';
import 'package:on_reserve/Pages/Profile%20Bottom%20Sheets/edit_profile.dart';
import 'package:on_reserve/helpers/routes.dart';

class ProfilePage extends StatelessWidget {
  final ProfileController profileController = Get.find();
  final double coverHeight = 220;
  final double profileHeight = 80;
  final double maxHeight = 1000.h;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile',
            style: TextStyle(fontSize: 70.sp, fontWeight: FontWeight.bold)),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  buildCoverImage(),
                  Positioned(
                    top: coverHeight - (profileHeight * 1.2),
                    left: 30,
                    child: biuldProfileImage(),
                  ),
                  Positioned(
                    bottom: 40,
                    right: 20,
                    child: buildEditProfileIcon(context),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 3),
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 2),
              child: Text(
                profileController.user!.firstName +
                    ' ' +
                    profileController.user!.lastName,
                style: TextStyle(
                  fontSize: 65.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(
                profileController.user!.bio!.isEmpty
                    ? 'Empty Bio...'
                    : profileController.user!.bio!,
                style: TextStyle(
                  fontSize: 55.sp,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Details(
                    title: "My Companies",
                    addable: true,
                    editable: true,
                    list: ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: maxHeight),
                        child: FutureBuilder(
                            future: profileController.getCompanies(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                // Show a loading indicator while the future is waiting
                                return ListView.builder(
                                    physics: const BouncingScrollPhysics(
                                        parent:
                                            AlwaysScrollableScrollPhysics()),
                                    padding: const EdgeInsets.all(10),
                                    itemCount: 3,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 5),
                                        child: ShimmerWidgets.rectangular(
                                            height: 260.h,
                                            width: 280.w,
                                            baseColor: const Color.fromARGB(
                                                255, 189, 185, 189),
                                            highlightColor:
                                                const Color.fromARGB(
                                                    255, 246, 242, 245)),
                                      );
                                    });
                              } else {
                                // When the future is done, check if it has an error or not
                                if (snapshot.hasError) {
                                  // Show an error message if the future has an error
                                  return Text('Error: ${snapshot.error}');
                                }
                              }
                              // If the future is successful, but empty then show a message
                              if (snapshot.data!.length == 0) {
                                return Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 50.h),
                                      Icon(
                                        Icons.event_busy,
                                        size: 150.w,
                                        color: Colors.grey[400],
                                      ),
                                      Text('No Companies Yet',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.grey[400],
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ],
                                  ),
                                );
                              }
                              // If the future is successful, display the booked tickets
                              return ListView.builder(
                                padding: EdgeInsets.all(10),
                                physics: BouncingScrollPhysics(
                                    parent: AlwaysScrollableScrollPhysics()),
                                itemCount: snapshot.data!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.toNamed(Routes.companyProfile,
                                          arguments: snapshot.data![index]
                                              ['company']);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(right: 10),
                                      margin: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 2),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary
                                            .withOpacity(0.6),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                              margin: const EdgeInsets.only(
                                                  right: 11),
                                              height: 220.h,
                                              width: 220.w,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                image: DecorationImage(
                                                  image:
                                                      CachedNetworkImageProvider(
                                                          snapshot.data![index]
                                                                  ['company']
                                                              ['profPic']),
                                                  fit: BoxFit.cover,
                                                ),
                                              )),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                snapshot.data![index]['company']
                                                    ['name'],
                                                style: TextStyle(
                                                    fontSize: 60.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .background),
                                              ),
                                              Text(
                                                snapshot.data![index]['company']
                                                    ['bio'],
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 42.sp,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .background),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            })),
                    onAdd: () {
                      profileController.coverPic = null;
                      profileController.profilePic = null;
                      profileController.bio.text =
                          profileController.user!.bio ?? '';
                      profileController.lname.text =
                          profileController.user!.lastName;
                      profileController.fname.text =
                          profileController.user!.firstName;
                      profileController.phoneNumber.text =
                          profileController.user!.phoneNumber ?? '';
                      profileController.name.text = '';
                      Get.bottomSheet(
                        const AddCompanyBottomSheet(),
                        shape: Get.theme.bottomSheetTheme.shape,
                        isScrollControlled: true,
                        clipBehavior: Clip.hardEdge,
                        useRootNavigator: true,
                        enableDrag: true,
                      );
                    },
                    onTap: () async {
                      Get.toNamed(Routes.myCompanies, arguments: {
                        'companies': await profileController.getCompanies()
                      });
                    },
                  ),
                  SizedBox(height: 50),
                  Details(
                    title: 'My Events',
                    list: ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: maxHeight),
                      child: FutureBuilder(
                        future: profileController.getUserEvents(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            // Show a loading indicator while the future is waiting
                            return ListView.builder(
                                physics: const BouncingScrollPhysics(
                                    parent: AlwaysScrollableScrollPhysics()),
                                padding: const EdgeInsets.all(10),
                                itemCount: 3,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 5),
                                    child: ShimmerWidgets.rectangular(
                                        height: 260.h,
                                        width: 310.w,
                                        baseColor: const Color.fromARGB(
                                            255, 189, 185, 189),
                                        highlightColor: const Color.fromARGB(
                                            255, 246, 242, 245)),
                                  );
                                });
                          } else {
                            // When the future is done, check if it has an error or not
                            if (snapshot.hasError) {
                              // Show an error message if the future has an error
                              return Text('Error: ${snapshot.error}');
                            }
                          }
                          // If the future is successful, but empty then show a message
                          if (snapshot.data!.length == 0) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: 50.h),
                                  Icon(
                                    Icons.event_busy,
                                    size: 150.w,
                                    color: Colors.grey[400],
                                  ),
                                  Text('No Events Yet',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.grey[400],
                                        fontWeight: FontWeight.bold,
                                      )),
                                ],
                              ),
                            );
                          }
                          // If the future is successful, display the booked tickets
                          return ListView.builder(
                            padding: EdgeInsets.all(10),
                            physics: BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              String timestamp =
                                  snapshot.data![index]['createdAt'];

                              // Parse the given timestamp into a DateTime object
                              DateTime parsedTime = DateTime.parse(timestamp);

                              // Get the current time
                              DateTime currentTime = DateTime.now();

                              // Calculate the difference between the parsed time and the current time
                              Duration difference =
                                  parsedTime.difference(currentTime);

                              // Format the remaining time using the timeago package
                              String remainingTime = timeago
                                  .format(currentTime.subtract(difference));
                              return GestureDetector(
                                onTap: null,
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 5),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                snapshot.data![index]['title'],
                                                style: TextStyle(
                                                    fontSize: 60.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .background),
                                              ),
                                              Text(
                                                remainingTime,
                                                style: TextStyle(
                                                    fontSize: 50.sp,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .background
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
                                              Color(0xFFb3a8d1)
                                                  .withOpacity(0.5),
                                              Color(0xFFb3a8d1),
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
                                            image: DecorationImage(
                                              image: NetworkImage(snapshot
                                                      .data![index]['galleries']
                                                  [0]['eventPhoto']),
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
                        },
                      ),
                    ),
                    addable: true,
                    editable: false,
                    onAdd: () {
                      Get.toNamed(
                        Routes.addEvent,
                        arguments: {
                          'companies': profileController.companies,
                          'categories': profileController.categories,
                        },
                      );
                    },
                    onTap: () {},
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            // Logout Button
            Container(
              width: double.infinity,
              height: 160.h,
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: ElevatedButton(
                onPressed: profileController.logout,
                child: Text(
                  'Logout',
                  style: TextStyle(
                      fontSize: 60.sp,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.background),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 200.h,
            )
          ],
        ),
      ),
    );
  }

  Widget buildEditProfileIcon(BuildContext context) {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background.withAlpha(100),
        borderRadius: BorderRadius.circular(50),
      ),
      child: IconButton(
        onPressed: () {
          profileController.coverPic = null;
          profileController.profilePic = null;
          profileController.bio.text = profileController.user!.bio ?? '';
          profileController.lname.text = profileController.user!.lastName;
          profileController.fname.text = profileController.user!.firstName;
          profileController.phoneNumber.text =
              profileController.user!.phoneNumber ?? '';
          profileController.name.text = '';
          Get.bottomSheet(
            const EditProfileBottomSheet(),
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
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Widget buildCoverImage() {
    return Container(
      height: coverHeight,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            alignment: Alignment.topCenter,
            image: CachedNetworkImageProvider(
              profileController.user!.coverPic ??
                  'https://img.freepik.com/free-icon/user_318-159711.jpg',
            ),
          )),
    );
  }

  Widget biuldProfileImage() {
    return !profileController.user!.profilePic!
            .startsWith("https://api.dicebear")
        ? CircleAvatar(
            radius: 40,
            backgroundImage: CachedNetworkImageProvider(
                profileController.user!.profilePic ??
                    'https://img.freepik.com/free-icon/user_318-159711.jpg'))
        : SvgPicture.network(
            profileController.user!.profilePic!,
            semanticsLabel: 'username',
            placeholderBuilder: (BuildContext context) => Container(
                padding: const EdgeInsets.all(30.0),
                child: const CircularProgressIndicator()),
          );
  }
}

class Details extends StatelessWidget {
  final String title;
  final bool editable;
  final bool addable;
  final Widget list;
  final void Function() onAdd;
  final void Function() onTap;
  const Details(
      {super.key,
      required this.list,
      required this.title,
      required this.onAdd,
      required this.onTap,
      this.editable = true,
      this.addable = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.primary.withOpacity(0.15),
      ),
      padding: EdgeInsets.fromLTRB(20, 12, 20, 20),
      child: Column(children: [
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: onTap,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 60.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            addable
                ? IconButton(
                    onPressed: onAdd,
                    icon: Icon(
                      Icons.add_circle,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )
                : SizedBox()
          ],
        ),
        Divider(
          color: Colors.grey,
          thickness: 1,
        ),
        list
      ]),
    );
  }
}
