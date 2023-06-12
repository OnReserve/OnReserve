import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:on_reserve/Components/shimmer.dart';
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
            ],
          ),
          SizedBox(height: 50),
          buildAdminTab(),
          SizedBox(height: 100),
        ],
      ),
    ));
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

  Widget buildAdminTab() {
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
            Header(),
            SlidableList(),
            SizedBox(height: 15),
          ],
        ));
  }
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
  });

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
                    'Admins',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 20, top: 10),
                child: IconButton(onPressed: () {}, icon: Icon(Icons.add)),
              )
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
