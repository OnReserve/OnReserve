import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              height: MediaQuery.of(context).size.height * 0.4,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromARGB(255, 223, 223, 223),
                // image: DecorationImage(
                //     image: AssetImage('assets/images/Map.png'),
                //     fit: BoxFit.fitWidth,
                //     alignment: Alignment.topCenter),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/Images/Map.png'),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'John Doe',
                      style: TextStyle(
                        fontSize: 78.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam tincidunt et velit id interdum...',
                      style: TextStyle(
                        fontSize: 50.sp,
                        color: Colors.black87,
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
                color: Color.fromARGB(255, 223, 223, 223),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Email',
                          style: TextStyle(
                            fontSize: 60.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {},
                          child: Text('Add new'),
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
                    constraints: BoxConstraints(maxHeight: 450.h),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return ListTile(
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
                                style: TextStyle(fontSize: 50.sp),
                              ),
                            ));
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
