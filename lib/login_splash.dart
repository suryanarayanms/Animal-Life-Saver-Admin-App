import 'dart:async';

import 'package:flutter/material.dart';

import 'package:the_dog_project_admin/auth_service.dart';

class LoginSplashScreen extends StatefulWidget {
  const LoginSplashScreen({Key key}) : super(key: key);

  @override
  LoginSplashScreenState createState() => LoginSplashScreenState();
}

class LoginSplashScreenState extends State<LoginSplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 2),
        () => {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AuthService().handleAuthState()))
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffDC0937),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Taking you in",
                style: TextStyle(
                    fontFamily: "BebasNeue", fontSize: 50, color: Colors.white),
              ),
            ),
            CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
