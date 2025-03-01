import 'package:appcurd/src/Views/auth/login.dart';
import 'package:appcurd/src/Views/screen/AddNewEmp.dart';
import 'package:appcurd/src/Views/screen/EditBottomSheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  void deleteEmployee(String empID) {
    FirebaseFirestore.instance.collection("Employee").doc(empID).delete();
  }

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
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Get.offAll(() => LoginScreen());
            },
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
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: StreamBuilder(
          stream:
              FirebaseFirestore.instance
                  .collection("Employee")
                  .where("UserID", isEqualTo: user?.uid) // **Ab match hoga**
                  .snapshots(),

          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            print("Snapshot: ${snapshot.data}");
            if (snapshot.hasError) {
              return const Center(child: Text("Something went wrong!"));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CupertinoActivityIndicator());
            }
            if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
              return const Center(child: Text("No Data Found"));
            }
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var data = snapshot.data!.docs[index];
                  print("Employee Data: ${data.data()}");
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Employee ${index + 1}",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Emp ID - ${data['EmpID']}",
                          style: GoogleFonts.poppins(fontSize: 14),
                        ),
                        Text(
                          "Emp Name - ${data['EmpName']}",
                          style: GoogleFonts.poppins(fontSize: 14),
                        ),
                        Text(
                          "EmpDOB - ${data['EmpDOB']}",
                          style: GoogleFonts.poppins(fontSize: 14),
                        ),
                        Text(
                          "Gender - ${data['EmpGender']}",
                          style: GoogleFonts.poppins(fontSize: 14),
                        ),
                        Text(
                          "Phone no - ${data['EmpPhone']}",
                          style: GoogleFonts.poppins(fontSize: 14),
                        ),
                        Text(
                          "Salary - ${data['EmpSalary']}",
                          style: GoogleFonts.poppins(fontSize: 14),
                        ),
                        Text(
                          "Address - ${data['EmpAddress']}",
                          style: GoogleFonts.poppins(fontSize: 14),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {
                                Get.bottomSheet(
                                  BottomSheetEditScreen(
                                    empData: {
                                      'EmpID': data['EmpID'],
                                      'EmpName': data['EmpName'],
                                      'EmpDOB': data['EmpDOB'],
                                      'EmpGender': data['EmpGender'],
                                      'EmpPhone': data['EmpPhone'],
                                      'EmpSalary': data['EmpSalary'],
                                      'EmpAddress': data['EmpAddress'],
                                      'docID':
                                          data.id, // Ye docID bhi bhejna hoga update ke liye
                                    },
                                  ),
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                );
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.blueAccent,
                              ),
                            ),
                            IconButton(
                              onPressed: () => deleteEmployee(data.id),
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.redAccent,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
