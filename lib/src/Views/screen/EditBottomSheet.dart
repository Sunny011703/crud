import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomSheetEditScreen extends StatefulWidget {
  const BottomSheetEditScreen({super.key});

  @override
  State<BottomSheetEditScreen> createState() => _BottomSheetEditScreenState();
}

class _BottomSheetEditScreenState extends State<BottomSheetEditScreen> {
  DateTime? selectedDate;
  String? selectedGender;

  final TextEditingController empIdController = TextEditingController();
  final TextEditingController empNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return DraggableScrollableSheet(
      initialChildSize: 0.95, // Fullscreen bottom sheet
      minChildSize: 0.95,
      maxChildSize: 1.0,
      builder: (context, scrollController) {
        return Container(
          padding: EdgeInsets.all(screenWidth * 0.05),
          decoration: const BoxDecoration(
            color: Colors.white, // Transparent issue fix
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)), // Smooth top radius
          ),
          child: SingleChildScrollView(
            controller: scrollController, // Scroll enable karega
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Text("Emp ID",
                    style: GoogleFonts.poppins(fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500)),
                SizedBox(height: screenHeight * 0.01),
                TextFormField(
                  controller: empIdController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    hintText: "Enter Emp ID",
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Text("Emp Name",
                    style: GoogleFonts.poppins(fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500)),
                SizedBox(height: screenHeight * 0.01),
                TextFormField(
                  controller: empNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    hintText: "Enter Emp Name",
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("DOB",
                              style: GoogleFonts.poppins(fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500)),
                          SizedBox(height: screenHeight * 0.01),
                          GestureDetector(
                            onTap: () => _selectDate(context),
                            child: AbsorbPointer(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                                  prefixIcon: const Icon(Icons.calendar_today),
                                  hintText: selectedDate == null
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
                          Text("Gender",
                              style: GoogleFonts.poppins(fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500)),
                          SizedBox(height: screenHeight * 0.01),
                          DropdownButtonFormField<String>(
                            isExpanded: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                              prefixIcon: const Icon(Icons.person_outline),
                            ),
                            value: selectedGender,
                            items: ["Male", "Female", "Other"].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value, overflow: TextOverflow.ellipsis),
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
                SizedBox(height: screenHeight * 0.02),
                Text("Phone Number",
                    style: GoogleFonts.poppins(fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500)),
                SizedBox(height: screenHeight * 0.01),
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    hintText: "Enter Phone Number",
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Text("Salary",
                    style: GoogleFonts.poppins(fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500)),
                SizedBox(height: screenHeight * 0.01),
                TextFormField(
                  controller: salaryController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    hintText: "Enter Salary",
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Text("Emp Address",
                    style: GoogleFonts.poppins(fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500)),
                SizedBox(height: screenHeight * 0.01),
                TextFormField(
                  controller: addressController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    hintText: "Enter Address",
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
                Center(
                  child: SizedBox(
                    height: screenHeight * 0.05,
                    width: screenWidth * 0.8,
                    child: ElevatedButton(
                      onPressed: () {
                        // Save data logic
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      child: Text(
                        "Save Data",
                        style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
