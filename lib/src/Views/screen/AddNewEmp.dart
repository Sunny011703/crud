import 'package:appcurd/src/Views/screen/EmpDetales.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddnewempScreens extends StatefulWidget {
  const AddnewempScreens({super.key});

  @override
  State<AddnewempScreens> createState() => _AddnewempScreensState();
}

class _AddnewempScreensState extends State<AddnewempScreens> {
  String? selectedGender;
  DateTime? selectedDate;

  final TextEditingController empIdController = TextEditingController();
  final TextEditingController empNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  User? user = FirebaseAuth.instance.currentUser;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void saveData() async {
    var empID = empIdController.text.trim();
    var empName = empNameController.text.trim();
    var empPhone = phoneController.text.trim();
    var empSalary = salaryController.text.trim();
    var empAddress = addressController.text.trim();

    if (empID.isEmpty ||
        empName.isEmpty ||
        empPhone.isEmpty ||
        empSalary.isEmpty ||
        empAddress.isEmpty ||
        selectedDate == null ||
        selectedGender == null) {
      Get.snackbar(
        "Error",
        "Please fill all fields",
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    try {
      await FirebaseFirestore.instance.collection("Employee").doc().set({
        'CreatedAt': DateTime.now(),
        'EmpID': empID,
        'EmpName': empName,
        'EmpDOB':
            "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
        'EmpGender': selectedGender,
        'EmpPhone': empPhone,
        'EmpSalary': empSalary,
        'EmpAddress': empAddress,
        'UserID': user?.uid, // **Ye line add karo**
      });
      Get.to(() => HomeScreen());
      Get.snackbar(
        "Success",
        "Account created successfully!",
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to save data",
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = Get.width;
    double screenHeight = Get.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Add Emp",
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTextField("Emp ID", empIdController,TextInputType.number),
              buildTextField("Emp Name", empNameController,TextInputType.name),
              Row(
                children: [
                  Expanded(child: buildDatePicker(context, screenWidth)),
                  const SizedBox(width: 10),
                  Expanded(child: buildGenderDropdown(screenWidth)),
                ],
              ),
              buildTextField("Phone Number", phoneController,TextInputType.number),
              buildTextField("Salary", salaryController,TextInputType.number),
              buildTextField("Emp Address", addressController,TextInputType.text),
              SizedBox(height: screenHeight * 0.04),
              Center(
                child: SizedBox(
                  height: screenHeight * 0.05,
                  width: screenWidth * 0.8,
                  child: ElevatedButton(
                    onPressed: saveData,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                    ),
                    child: Text(
                      "Save Data",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller,TextInputType keyboardType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 5),
        TextFormField(
          controller: controller,
          keyboardType:keyboardType ,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            hintText: "Enter $label",
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget buildDatePicker(BuildContext context, double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "DOB",
          style: GoogleFonts.poppins(
            fontSize: screenWidth * 0.04,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 5),
        GestureDetector(
          onTap: () => _selectDate(context),
          child: AbsorbPointer(
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                prefixIcon: const Icon(Icons.calendar_today),
                hintText:
                    selectedDate == null
                        ? "Select DOB"
                        : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildGenderDropdown(double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Gender",
          style: GoogleFonts.poppins(
            fontSize: screenWidth * 0.04,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 5),
        DropdownButtonFormField<String>(
          isExpanded: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            prefixIcon: const Icon(Icons.person_outline),
          ),
          value: selectedGender,
          hint: Text("Select Gender"),
          items:
              ["Male", "Female", "Other"].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
          onChanged: (newValue) {
            setState(() {
              selectedGender = newValue;
            });
          },
        ),
      ],
    );
  }
}
