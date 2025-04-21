import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class addfs extends StatefulWidget {
  @override
  _addfsState createState() => _addfsState();
}

class _addfsState extends State<addfs> {
  final _formKey = GlobalKey<FormState>();
  var a;
  var result = "";
  var data = TextEditingController();
  var data2 = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController designationController = TextEditingController();
  String? gender="Pending";
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String designation = "Select Designation";
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data.text=DateTime.now().toString().substring(0, 11);
  }
  Widget buildTextField(int maxlength,String hint,String label, TextEditingController controller, TextInputType keyboardType, String? Function(String?)? validator) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLength: maxlength,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: Colors.grey[200],
        ),
        validator: validator,
      ),
    );
  }
  String formatTime(TimeOfDay time) {
    final int hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final String period = time.period == DayPeriod.am ? "AM" : "PM";
    return "${hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} $period";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Task", style: GoogleFonts.poppins(color: Colors.white,fontSize: 22, fontWeight: FontWeight.w600)),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Task Details", style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                buildTextField(30,"Enter Task Title","Task Title", nameController, TextInputType.text, (value) => value!.isEmpty ? "Enter Task Title" : null),
                buildTextField(30,"Enter Task Description","Task Description", designationController, TextInputType.text, (value) => value!.isEmpty ? "Enter Task Description" : null),
                TextFormField(readOnly: true,
                    controller: data,
                    validator: (value) =>
                    value!.isEmpty
                        ? 'Enter Create Date'
                        : null,
                    decoration: InputDecoration(
                      labelText: 'Create Date',
                      hintText: 'Enter Create Date',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      filled: true,
                      fillColor: Colors.grey[200],
                      prefixIcon: Icon(Icons.data_saver_on),
                    )),
                SizedBox(height: 20),
                // TextFormField(readOnly: true,
                //     controller: data2,
                //     decoration: InputDecoration(
                //         labelText: 'Done Date',
                //         hintText: 'Enter Done Date',
                //         border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                //         filled: true,
                //         fillColor: Colors.grey[200],
                //         prefixIcon: Icon(Icons.data_saver_on),
                //         suffixIcon: IconButton(
                //             onPressed: () async {
                //               a = await showDatePicker(
                //                 context: context,
                //                 initialDate: DateTime.now(),
                //                 firstDate: DateTime.now(),
                //                 lastDate: DateTime(2050),
                //               );
                //               result = a.toString();
                //               data2.text = result.substring(0, 11);
                //             },
                //             icon: Icon(Icons.date_range)))),
                // SizedBox(height: 20),
                // Text("Status", style: GoogleFonts.poppins(fontSize: 16)),
                // Row(
                //   children: [
                //     Expanded(
                //       child: RadioListTile<String>(
                //         title: Text("Pending",style: TextStyle(fontSize:14)),
                //         value: "Pending",
                //         groupValue: gender,
                //         onChanged: (value) => setState(() => gender = value),
                //       ),
                //     ),
                //     Expanded(
                //       child: RadioListTile<String>(
                //         title: Text("Complete",style: TextStyle(fontSize:14),),
                //         value: "Complete",
                //         groupValue: gender,
                //         onChanged: (value) => setState(() => gender = value),
                //       ),
                //     ),
                //   ],
                // ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      if (_formKey.currentState!.validate()) {
                        if(data2.text.isEmpty==true){
                          setState(() {
                            gender="Pending";
                          });
                        }
                        else{
                          setState(() {
                            gender="Complete";
                          });
                        }
                        try {
                          DocumentReference docRef=await _firestore.collection('TODO').add({
                            'task_title':nameController.text,
                            'task_description': designationController.text,
                            'createDate': data.text,
                            'doneDate':"In Process...",
                            'status': "Pending",
                          });
                          String docId = docRef.id;
                          await docRef.update({
                            'id': docId,
                          });
                          print("Data added successfully!");
                          nameController.clear();
                          designationController.clear();
                          data.clear();
                          data2.clear();
                          gender="Pending";
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Task Added Successfully!"),
                              backgroundColor: Colors.green,duration: Duration(milliseconds: 400),
                            ),
                          );
                          setState(() {
                            isLoading = false;
                          });
                          Navigator.pop(context);
                        } catch (e) {
                          setState(() {
                            isLoading = false;
                          });
                          print("Error adding data: $e");
                        }
                      }
                    },
                    child: isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        :  Text("Add Task", style: GoogleFonts.poppins(color: Colors.white,fontSize: 18, fontWeight: FontWeight.w600)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
