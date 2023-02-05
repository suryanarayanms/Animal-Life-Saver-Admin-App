import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:the_dog_project_admin/login_splash.dart';
import 'package:the_dog_project_admin/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: ((context) => TemporaryData()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'The Dog Project Admin',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const LoginSplashScreen(),
        ));
  }
}
