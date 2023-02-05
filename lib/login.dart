import 'package:flutter/material.dart';
import 'package:the_dog_project_admin/auth_service.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 75.0,
              left: 30,
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Row(
                children: const [
                  Text(
                    'Login',
                    style: TextStyle(fontFamily: "BebasNeue", fontSize: 50),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          Center(
            child: Image.asset(
              'assets/images/petAdoption.png',
              height: MediaQuery.of(context).size.height / 3,
            ),
          ),
          const Center(
            child: Text('Life is better with a dog',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "BebasNeue",
                    fontSize: 30)),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30, bottom: 30),
            child: GestureDetector(
              onTap: () => {
                // context.read<TemporaryData>().retrieveData(context),
                AuthService().signInWithGoogle(),
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    top: 20,
                    bottom: 20,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        'assets/images/google.png',
                        height: 35,
                      ),
                      const Text("Continue with google",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "BebasNeue",
                              fontSize: 30)),
                      const Text(" ",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "BebasNeue",
                              fontSize: 30)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
