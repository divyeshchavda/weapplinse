import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class updatefs extends StatefulWidget {
  String? task_title,task_description,createDate,doneDate,status,id;

  updatefs(
      {required this.task_title,
        required this.task_description,
        required this.createDate,
        required this.doneDate,
        required this.status,
        required this.id});

  @override
  _updatefsState createState() => _updatefsState();
}

class _updatefsState extends State<updatefs> {
  final _formKey = GlobalKey<FormState>();
  var a;
  var result = "";
  var data = TextEditingController();
  var data2 = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController designationController = TextEditingController();
  String? gender="Pending";
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isLoading=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text=widget.task_title!;
    designationController.text=widget.task_description!;
    data.text=widget.createDate!;
    data2.text=widget.doneDate!;
    gender=widget.status;
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
        title: Text("Update Task", style: GoogleFonts.poppins(color: Colors.white,fontSize: 22, fontWeight: FontWeight.w600)),
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
                TextFormField(readOnly: true,
                    controller: data2,
                    decoration: InputDecoration(
                        labelText: 'Done Date',
                        hintText: 'Enter Done Date',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        filled: true,
                        fillColor: Colors.grey[200],
                        prefixIcon: Icon(Icons.data_saver_on),
                        suffixIcon: IconButton(
                            onPressed: () async {
                              a = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.parse(widget.createDate!.trim()),
                                lastDate: DateTime.now(),
                              );
                              result = a.toString();
                              data2.text = result.substring(0, 11);
                            },
                            icon: Icon(Icons.date_range)))),
                SizedBox(height: 20),
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
                // SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      if (_formKey.currentState!.validate()) {
                        try {
                          await _firestore.collection('TODO').doc(widget.id).update({
                            'task_title':nameController.text,
                            'task_description': designationController.text,
                            'createDate': data.text,
                            'doneDate': data2.text.isEmpty==true?"In Process...":data2.text,
                            'status': data2.text=="In Process..."?"Pending":"Complete",
                          });
                          print("Data added successfully!");
                          nameController.clear();
                          designationController.clear();
                          data.clear();
                          data2.clear();
                          gender="Pending";
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Task Updated Successfully!"),duration: Duration(milliseconds: 400),
                              backgroundColor: Colors.green,
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
                        : Text("Update Task", style: GoogleFonts.poppins(color: Colors.white,fontSize: 18, fontWeight: FontWeight.w600)),
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
