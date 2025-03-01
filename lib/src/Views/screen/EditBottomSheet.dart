import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomSheetEditScreen extends StatefulWidget {
  final Map<String, dynamic> empData;

  const BottomSheetEditScreen({Key? key, required this.empData}) : super(key: key);

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

  @override
  void initState() {
    super.initState();
    empIdController.text = widget.empData['EmpID'] ?? '';
    empNameController.text = widget.empData['EmpName'] ?? '';
    phoneController.text = widget.empData['EmpPhone'] ?? '';
    salaryController.text = widget.empData['EmpSalary'] ?? '';
    addressController.text = widget.empData['EmpAddress'] ?? '';
    selectedGender = widget.empData['EmpGender'] ?? 'Male';
    selectedDate = widget.empData['EmpDOB'] != null
        ? DateTime.tryParse(widget.empData['EmpDOB'])
        : null;
  }

  Future<void> _updateEmployee() async {
    try {
      await FirebaseFirestore.instance
          .collection("Employee")
          .doc(widget.empData['docID'])
          .update({
        'EmpID': empIdController.text,
        'EmpName': empNameController.text,
        'EmpDOB': selectedDate?.toIso8601String(),
        'EmpGender': selectedGender,
        'EmpPhone': phoneController.text,
        'EmpSalary': salaryController.text,
        'EmpAddress': addressController.text,
      });
      Get.back();
    } catch (e) {
      Get.snackbar("Error", "Failed to update employee");
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
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
      initialChildSize: 0.95,
      minChildSize: 0.95,
      maxChildSize: 1.0,
      builder: (context, scrollController) {
        return Container(
          padding: EdgeInsets.all(screenWidth * 0.05),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Get.back(),
                  ),
                ),
                _buildTextField("Emp ID", empIdController),
                _buildTextField("Emp Name", empNameController),
                Row(
                  children: [
                    Expanded(
                      child: _buildDatePicker(context),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildDropdownField(),
                    ),
                  ],
                ),
                _buildTextField("Phone Number", phoneController, keyboardType: TextInputType.phone),
                _buildTextField("Salary", salaryController, keyboardType: TextInputType.number),
                _buildTextField("Emp Address", addressController),
                SizedBox(height: screenHeight * 0.04),
                Center(
                  child: SizedBox(
                    height: screenHeight * 0.05,
                    width: screenWidth * 0.8,
                    child: ElevatedButton(
                      onPressed: _updateEmployee,
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

  Widget _buildTextField(String label, TextEditingController controller, {TextInputType keyboardType = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500)),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            hintText: "Enter $label",
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("DOB", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500)),
        SizedBox(height: 8),
        GestureDetector(
          onTap: () => _selectDate(context),
          child: AbsorbPointer(
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                prefixIcon: const Icon(Icons.calendar_today),
                hintText: selectedDate == null ? "Select DOB" : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Gender", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500)),
        SizedBox(height: 8),
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