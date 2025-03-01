import 'package:appcurd/src/Views/auth/RegisterScreen.dart';
import 'package:appcurd/src/Views/auth/forgetPassword.dart';
import 'package:appcurd/src/Views/auth/home.dart';
import 'package:appcurd/src/Views/screen/EmpDetales.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController userLoginEmailController =
      TextEditingController();
  final TextEditingController userLoginPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;

  //-------- Method to toggle password visibility-------

  void togglePasswordVisiblity() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  // Email validation
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  // Password validation
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = Get.width;
    double screenHeight = Get.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 55.0, horizontal: 16.0),
          child: Form(
            key: _globalKey,
            child: Column(
              children: [
                Text(
                  "Login",
                  style: GoogleFonts.poppins(
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.w600,
                    color: Colors.blueAccent,
                  ),
                ),
                Container(
                  width: screenWidth * 0.9,
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        spreadRadius: 2,
                        offset: const Offset(2, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "Welcome to Login Page",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: screenWidth * 0.04,
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.04),
                      Text(
                        "Email",
                        style: GoogleFonts.poppins(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      TextFormField(
                        controller: userLoginEmailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: const Icon(Icons.email),
                          hintText: "Enter your email",
                        ),
                        validator: validateEmail,
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      Text(
                        "Password",
                        style: GoogleFonts.poppins(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      TextFormField(
                        obscureText: isPasswordVisible,
                        controller: userLoginPasswordController,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            onPressed: togglePasswordVisiblity,
                            icon: Icon(
                              isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                          hintText: "Enter your password",
                        ),
                        validator:validatePassword ,
                      ),
                      SizedBox(height: screenHeight * 0.04),
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_globalKey.currentState!.validate()) {
                              var loginUserEmail =
                                  userLoginEmailController.text.trim();
                              var loginUserPassword =
                                  userLoginPasswordController.text.trim();
                              try {
                                final User? firebaseuser =
                                    (await FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                          email: loginUserEmail,
                                          password: loginUserPassword,
                                        )).user;
                                if (firebaseuser != null) {
                                  userLoginEmailController.clear();
                                  userLoginPasswordController.clear();
                                  Get.offAll(
                                    () => HomeScreen(),
                                    transition: Transition.rightToLeftWithFade,
                                    duration: Duration(milliseconds: 400),
                                  );
                                }
                                
                              } on FirebaseAuthException catch (e) {
                                Get.snackbar(
                                  "Login Failed ",
                                  e.message!,
                                  snackPosition: SnackPosition.TOP,
                                );
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.3,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            "Login",
                            style: GoogleFonts.poppins(
                              fontSize: screenWidth * 0.045,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: TextButton(
                            onPressed: () {
                              Get.bottomSheet(forgetPasswordScreen());
                            },
                            child: Text(
                              "Forget Password?",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account ..!"),
                            SizedBox(width: 5),
                            GestureDetector(
                              onTap: () {
                                Get.to(
                                  () => RegisterScreen(),
                                  transition: Transition.rightToLeftWithFade,
                                  duration: Duration(milliseconds: 400),
                                );
                              },
                              child: Text(
                                "Registration",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blueAccent,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: screenWidth * 0.8,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        spreadRadius: 2,
                        offset: const Offset(2, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      buildSocialLoginButton(
                        screenWidth,
                        "assets/googleImage.png",
                        "Login with Google",
                      ),
                      const SizedBox(height: 10),
                      buildSocialLoginButton(
                        screenWidth,
                        "assets/facebook.png",
                        "Login with Facebook",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSocialLoginButton(
    double screenWidth,
    String imagePath,
    String text,
  ) {
    return Container(
      width: screenWidth * 0.7,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 0.5, color: Colors.black12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath, width: 30, height: 30),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Colors.black,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
