import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:on_reserve/Controllers/profile_controller.dart';
import 'package:on_reserve/Pages/Profile%20Bottom%20Sheets/add_company.dart';
import 'package:on_reserve/Pages/Profile%20Bottom%20Sheets/edit_profile.dart';
import 'package:on_reserve/helpers/routes.dart';

class ProfilePage extends StatelessWidget {
  final ProfileController profileController = Get.find();
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              height: MediaQuery.of(context).size.height * 0.35,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        "http://res.cloudinary.com/dsgpxgwxs/image/upload/v1686293226/onReserve/Profile/wlru9yrmbxu9lfkfj9fu.jpg",
                        //  progressIndicatorBuilder: (context, url, downloadProgress) =>
                        //          CircularProgressIndicator(value: downloadProgress.progress),
                        //  errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.topCenter,
                      scale: 0.5)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40),
                  GestureDetector(
                    onTap: () {
                      print(profileController.user!.profilePic ??
                          'https://img.freepik.com/free-icon/user_318-159711.jpg');
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: !profileController.user!.profilePic!
                              .startsWith("https://api.dicebear")
                          ? CircleAvatar(
                              radius: 40,
                              backgroundImage: CachedNetworkImageProvider(
                                  profileController.user!.profilePic ??
                                      'https://img.freepik.com/free-icon/user_318-159711.jpg'))
                          : SvgPicture.network(
                              profileController.user!.profilePic!,
                              semanticsLabel: 'username',
                              placeholderBuilder: (BuildContext context) =>
                                  Container(
                                      padding: const EdgeInsets.all(30.0),
                                      child: const CircularProgressIndicator()),
                            ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "${profileController.user!.firstName} ${profileController.user!.lastName}",
                            style: TextStyle(
                              fontSize: 78.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                          tooltip: 'Edit Profile',
                          onPressed: () {
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
                            size: 80.sp,
                          ))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      profileController.user!.bio!.isEmpty
                          ? 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam tincidunt et velit id interdum...'
                          : profileController.user!.bio!,
                      style: TextStyle(
                        fontSize: 50.sp,
                      ),
                    ),
                  ),
                ],
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
                    onAdd: () {
                      Get.bottomSheet(
                        const AddCompanyBottomSheet(),
                        shape: Get.theme.bottomSheetTheme.shape,
                        isScrollControlled: true,
                        clipBehavior: Clip.hardEdge,
                        useRootNavigator: true,
                        enableDrag: true,
                      );
                    },
                    onTap: () {
                      Get.toNamed(Routes.myCompanies);
                    },
                  ),
                  SizedBox(height: 50),
                  Details(
                    title: 'My Events',
                    addable: true,
                    editable: false,
                    onAdd: () {
                      Get.toNamed(Routes.addEvent);
                    },
                    onTap: () {},
                  ),
                  SizedBox(height: 50),
                  Details(
                    title: 'My Tickets',
                    addable: false,
                    editable: false,
                    onAdd: () {
                      Get.bottomSheet(
                        const AddCompanyBottomSheet(),
                        shape: Get.theme.bottomSheetTheme.shape,
                        isScrollControlled: true,
                        clipBehavior: Clip.hardEdge,
                        useRootNavigator: true,
                        enableDrag: true,
                      );
                    },
                    onTap: () {},
                  ),
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
}

class Details extends StatelessWidget {
  final String title;
  final bool editable;
  final bool addable;
  final void Function() onAdd;
  final void Function() onTap;
  const Details(
      {super.key,
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
        ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 580.h),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return SingleChildScrollView(
                    physics: PageScrollPhysics(),
                    child: Container(
                      width: double.infinity,
                      height: 200.h,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: ElevatedButton(
                        onPressed: null,
                        child: Text(
                          'Logout',
                          style: TextStyle(
                              fontSize: 60.sp,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.background),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  );
                }))
      ]),
    );
  }
}
