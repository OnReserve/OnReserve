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
                image: DecorationImage(
                    image: AssetImage('assets/images/Map.png'),
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.topCenter),
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
                      backgroundImage: AssetImage('assets/images/Map.png'),
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
          ],
        ),
      ),
    );
  }
}
