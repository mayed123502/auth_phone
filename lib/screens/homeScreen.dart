import 'package:auth_phone/screens/phone_auth_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  static const String screenRoute = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(
              "يا مرحبا",
              style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () async {
                _auth.signOut();

                Navigator.pushReplacementNamed(context, PhoneAuth.screenRoute);
              },
              child: Text(
                "LogOut",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                ),
              ),
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(110, 50),
                  primary: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6))),
            ),
          ],
        ),
      ),
    );
  }
}
