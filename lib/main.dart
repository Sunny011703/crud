import 'package:appcurd/src/Views/auth/home.dart';
import 'package:appcurd/src/Views/auth/login.dart';
import 'package:appcurd/src/Views/screen/EmpDetales.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? user;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    checkUser();
  }

  void checkUser() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulating delay
    setState(() {
      user = FirebaseAuth.instance.currentUser;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: isLoading
          ? const Scaffold(
            backgroundColor: Colors.blueAccent,
              body: Center(
                child: CircularProgressIndicator(color: Colors.white,),
            
              ),
            )
          : (user != null ? const HomeScreen() : const LoginScreen()),
    );
  }
}
