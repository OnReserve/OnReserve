import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:on_reserve/Controllers/profile_controller.dart';

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
                  image: DecorationImage(
                      image: AssetImage('assets/Images/Map.png'),
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.topCenter)),
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
                              backgroundImage: NetworkImage(profileController
                                      .user!.profilePic ??
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
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "${profileController.user!.firstName} ${profileController.user!.lastName}",
                      style: TextStyle(
                        fontSize: 78.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              padding: EdgeInsets.all(15),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'My Companies',
                          style: TextStyle(
                            fontSize: 60.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            'Add new',
                            style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.background),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 480.h),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return SingleChildScrollView(
                          physics: PageScrollPhysics(),
                          child: ListTile(
                              dense: true,
                              horizontalTitleGap: 0,
                              title: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Addis Concert ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 55.sp,
                                    ),
                                  ),
                                  // Image.asset('assets/images/Blue_tick.png',
                                  //     height: 70.r, width: 80.r)
                                ],
                              ),
                              trailing: ElevatedButton(
                                onPressed: () {},
                                child: Text(
                                  'Edit',
                                  style: TextStyle(fontSize: 45.sp),
                                ),
                              )),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 50),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'My Events',
                          style: TextStyle(
                            fontSize: 60.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            'Add new',
                            style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.background),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 480.h),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return SingleChildScrollView(
                          physics: PageScrollPhysics(),
                          child: ListTile(
                              dense: true,
                              horizontalTitleGap: 0,
                              title: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Addis Concert ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 55.sp,
                                    ),
                                  ),
                                  // Image.asset('assets/images/Blue_tick.png',
                                  //     height: 70.r, width: 80.r)
                                ],
                              ),
                              trailing: ElevatedButton(
                                onPressed: () {},
                                child: Text(
                                  'Edit',
                                  style: TextStyle(fontSize: 45.sp),
                                ),
                              )),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            // Logout Button
            Container(
              width: double.infinity,
              height: 150.h,
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: ElevatedButton(
                onPressed: profileController.logout,
                child: Text(
                  'Logout',
                  style: TextStyle(
                      fontSize: 60.sp,
                      color: Theme.of(context).colorScheme.background),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo[500],
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
