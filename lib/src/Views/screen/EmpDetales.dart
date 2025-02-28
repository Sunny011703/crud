import 'package:appcurd/src/Views/screen/AddNewEmp.dart';
import 'package:appcurd/src/Views/screen/EditBottomSheet.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          "Employee Details",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.blueAccent,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.logout, color: Colors.red),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(
            () => const AddnewempScreens(),
            transition: Transition.rightToLeftWithFade,
            duration: const Duration(milliseconds: 400),
          );
        },
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Column(
            children: List.generate(5, (index) => buildEmployeeCard(index + 1)),
          ),
        ),
      ),
    );
  }

  Widget buildEmployeeCard(int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 1),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Employee $index",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 5),
          Text("Employee ID", style: GoogleFonts.poppins(fontSize: 14)),
          Text("Employee Name", style: GoogleFonts.poppins(fontSize: 14)),
          Text("DOB: 01/01/2000", style: GoogleFonts.poppins(fontSize: 14)),
          Text("Gender: Male", style: GoogleFonts.poppins(fontSize: 14)),
          Text("Phone no: 88666788", style: GoogleFonts.poppins(fontSize: 14)),
          Text("Salary: 15000", style: GoogleFonts.poppins(fontSize: 14)),
          Text("Address: Luckoow", style: GoogleFonts.poppins(fontSize: 14)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  Get.bottomSheet(
                    const BottomSheetEditScreen(),
                    isScrollControlled: true, // Fullscreen enable karega
                    backgroundColor:
                        Colors.transparent, // Transparent issue fix karega
                  );
                },
                icon: const Icon(Icons.edit, color: Colors.blueAccent),
              ),

              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.delete, color: Colors.redAccent),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
