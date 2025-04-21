import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddEmployeeScreen extends StatefulWidget {
  @override
  _AddEmployeeScreenState createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController designationController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  String? gender="Male";
  String designation = "Select Designation";
  bool isLoading=false;
  Future<bool> checkIfEmailExists(String email) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref().child("Employees");

    DataSnapshot snapshot = await ref.orderByChild("email").equalTo(email).get();

    return snapshot.exists;
  }
  bool isValidName(String name) {
    RegExp regex = RegExp(r'^[a-zA-Z ]+$');
    return regex.hasMatch(name);
  }
  bool isNumber(String text) {
    final regExp = RegExp(r'^-?\d+$');
    return regExp.hasMatch(text);
  }
  Future<void> addEmployee() async {
    setState(() {
      isLoading = true;
    });
    bool t= await checkIfEmailExists(emailController.text);
    print(t);
    if(t==false){
      if (_formKey.currentState!.validate()) {
        if(designation!="Select Designation"){
          DatabaseReference ref = FirebaseDatabase.instance.ref("Employees");
          String newKey = ref.push().key!;

          ref.child(newKey).set({
            "id": newKey,
            "name": nameController.text.trim(),
            "designation": designation,
            "gender": gender,
            "mobile_no": mobileController.text.trim(),
            "salary": int.parse(salaryController.text.trim()),
            "email": emailController.text.trim()
          }).then((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Employee Added Successfully!"),
                duration: Duration(milliseconds: 400),
                backgroundColor: Colors.green,
              ),
            );
            nameController.clear();
            designation="Select Designation";
            mobileController.clear();
            salaryController.clear();
            emailController.clear();
            setState(() {
              isLoading = false;
            });
            Navigator.pop(context);
          }).catchError((error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Error: $error"),
                backgroundColor: Colors.red,
              ),
            );
          });
        }
        else{
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Enter Valid Designation"),
              backgroundColor: Colors.red,duration: Duration(milliseconds: 400),
            ),
          );
        }
      }
    }
    else{
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Email Already Exist!!"),
          backgroundColor: Colors.black,
          duration: Duration(milliseconds: 200),
        ),
      );
    }
  }

  Widget buildTextField(int maxlength,String label, TextEditingController controller, TextInputType keyboardType, String? Function(String?)? validator) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLength: maxlength,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: Colors.grey[200],
        ),
        validator: validator,
      ),
    );
  }

  void changedesignation(String design){
    setState(() {
      designation = design;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Employee", style: GoogleFonts.poppins(color: Colors.white,fontSize: 22, fontWeight: FontWeight.w600)),
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
                Text("Employee Details", style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                buildTextField(30,"Full Name", nameController, TextInputType.text, (value) {
                  if (value!.isEmpty) return "Enter Employee Name";
                  if (!isValidName(nameController.text)) {
                    return "Enter a valid Characters";
                  }
                  return null;
                }),
                Container(
                  width: 350,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    border: Border.all(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: DropdownButton<String>(
                      borderRadius: BorderRadius.circular(20),
                      value: designation,
                      menuWidth: 350,
                      dropdownColor:Colors.grey.shade200,
                      menuMaxHeight: 350,style: TextStyle(color: Colors.grey.shade800),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          changedesignation(newValue);
                        }
                      },
                      items: [
                        DropdownMenuItem(value: 'Select Designation', child: Text("Select Designation")),
                        DropdownMenuItem(value: 'Employee', child: Text("Employee")),
                        DropdownMenuItem(value: 'Trainee', child: Text("Trainee")),
                        DropdownMenuItem(value: 'BDE', child: Text("BDE")),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Text("Gender", style: GoogleFonts.poppins(fontSize: 16)),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                        title: Text("Male"),
                        value: "Male",
                        groupValue: gender,
                        onChanged: (value) => setState(() => gender = value),
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: Text("Female"),
                        value: "Female",
                        groupValue: gender,
                        onChanged: (value) => setState(() => gender = value),
                      ),
                    ),
                  ],
                ),
                buildTextField(10,"Mobile Number", mobileController, TextInputType.phone, (value) {
                  if (value!.length != 10) return "Enter Valid 10 Number";
                  if (!isNumber(mobileController.text)) {
                    return "Enter a valid Numbers";
                  }
                  return null;
                }),
                buildTextField(10,"Salary", salaryController, TextInputType.number, (value) {
                  if (value!.isEmpty) return "Enter Salary";
                  if (!isNumber(salaryController.text)) {
                    return "Enter a valid Numbers";
                  }
                  return null;
                }),
                buildTextField(30,"Email", emailController, TextInputType.emailAddress, (value) {
                  if (value!.isEmpty) return "Enter email";
                  if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}").hasMatch(value)) {
                    return "Enter a valid email";
                  }
                  return null;
                }),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: addEmployee,
                    child:  isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text("Add Employee", style: GoogleFonts.poppins(color: Colors.white,fontSize: 18, fontWeight: FontWeight.w600)),
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
