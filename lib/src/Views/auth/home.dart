import 'package:appcurd/src/Views/auth/RegisterScreen.dart';
import 'package:appcurd/src/Views/auth/controller/home_Controller.dart';
import 'package:appcurd/src/Views/auth/login.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreenAuth extends StatelessWidget {
  HomeScreenAuth({super.key});

  final HomeController controller = Get.put(HomeController()); // GetX controller initialize

  @override
  Widget build(BuildContext context) {
    double screenWidth = Get.width;
    double screenHeight = Get.height;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
          ),
          Positioned(
            top: screenHeight * 0.1,
            left: screenWidth * 0.1,
            right: screenWidth * 0.1,
            child: SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => controller.isLoginSelected.value = true,
                    child: Obx(() => Container(
                          width: screenWidth * 0.35,
                          height: screenHeight * 0.06,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: controller.isLoginSelected.value ? Colors.blue : Colors.white,
                            border: Border.all(color: Colors.blue),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Login",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: screenWidth * 0.05,
                              color: controller.isLoginSelected.value ? Colors.white : Colors.black,
                            ),
                          ),
                        )),
                  ),
                  SizedBox(width: screenWidth * 0.05),
                  GestureDetector(
                    onTap: () => controller.isLoginSelected.value = false,
                    child: Obx(() => Container(
                          width: screenWidth * 0.35,
                          height: screenHeight * 0.06,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: !controller.isLoginSelected.value ? Colors.blue : Colors.grey.shade300,
                            border: Border.all(color: Colors.blue),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Registration ",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: screenWidth * 0.04,
                              color: !controller.isLoginSelected.value ? Colors.white : Colors.black,
                            ),
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.17,
            left: 0,
            right: 0,
            child: Obx(() => controller.isLoginSelected.value ? const LoginScreen() : const RegisterScreen()),
          ),
        ],
      ),
    );
  }
}
