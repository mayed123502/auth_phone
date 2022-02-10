import 'package:auth_phone/screens/homeScreen.dart';
import 'package:auth_phone/screens/otp_screen.dart';
import 'package:auth_phone/screens/phone_auth_Provider.dart';
import 'package:auth_phone/screens/phone_auth_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

late String initialRoute;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  FirebaseAuth.instance.authStateChanges().listen((user) {

    if (user == null) {
      initialRoute = PhoneAuth.screenRoute;
    } else {
      initialRoute = HomeScreen.screenRoute;

    }
  });
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PhoneProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: initialRoute,
          routes: {
            PhoneAuth.screenRoute: (context) => PhoneAuth(),
            OtpsScreen.screenRoute: (context) => OtpsScreen(),
            HomeScreen.screenRoute: (context) => HomeScreen(),
          });
    });
  }
}
