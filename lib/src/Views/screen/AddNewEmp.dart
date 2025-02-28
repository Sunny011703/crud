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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
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
              Text(
                "Emp ID",
                style: GoogleFonts.poppins(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Container(
                height: screenHeight * 0.06,
                width: screenWidth * 0.9,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.fromBorderSide(
                    BorderSide(width: 0.9, color: Colors.black),
                  ),
                ),
                child: TextFormField(
                  controller: empIdController,
                  decoration: const InputDecoration(
                    border: InputBorder.none, //------------Border removed
                    hintText: "Enter your ID", //-----------Placeholder text
                  ),
                ),
              ),
              Text(
                "Emp Name",
                style: GoogleFonts.poppins(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Container(
                height: screenHeight * 0.06,
                width: screenWidth * 0.9,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.fromBorderSide(
                    BorderSide(width: 0.9, color: Colors.black),
                  ),
                ),
                child: TextFormField(
                  controller: empNameController,
                  decoration: const InputDecoration(
                    border: InputBorder.none, // ✅ Border removed
                    hintText: "Enter your Name",
                  ),
                ),
              ),
              // DOB & Gender Row
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "DOB",
                          style: GoogleFonts.poppins(
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
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
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Gender",
                          style: GoogleFonts.poppins(
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        DropdownButtonFormField<String>(
                          isExpanded: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            prefixIcon: const Icon(Icons.person_outline),
                          ),
                          value: selectedGender,
                          items:
                              ["Male", "Female", "Other"].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                );
                              }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              selectedGender = newValue;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                "Phone Number",
                style: GoogleFonts.poppins(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Container(
                height: screenHeight * 0.06,
                width: screenWidth * 0.9,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.fromBorderSide(
                    BorderSide(width: 0.9, color: Colors.black),
                  ),
                ),
                child: TextFormField(
                  controller:phoneController,
                  decoration: const InputDecoration(
                    border: InputBorder.none, // ✅ Border removed
                    hintText: "Enter Phone Number",
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                "Salary",
                style: GoogleFonts.poppins(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Container(
                height: screenHeight * 0.06,
                width: screenWidth * 0.9,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.fromBorderSide(
                    BorderSide(width: 0.9, color: Colors.black),
                  ),
                ),
                child: TextFormField(
                  controller: salaryController,
                  decoration: const InputDecoration(
                    border: InputBorder.none, // ✅ Border removed
                    hintText: "Enter Salary",
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                "Emp Address",
                style: GoogleFonts.poppins(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Container(
                height: screenHeight * 0.06,
                width: screenWidth * 0.9,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.fromBorderSide(
                    BorderSide(width: 0.9, color: Colors.black),
                  ),
                ),
                child: TextFormField(
                  controller: addressController,
                  decoration: const InputDecoration(
                    border: InputBorder.none, // ✅ Border removed
                    hintText: "Enter your Address",
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.04),
              Center(
                child: SizedBox(
                  height: screenHeight * 0.05,
                  width: screenWidth * 0.8,
                  child: ElevatedButton(
                    onPressed: () {},
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
}
