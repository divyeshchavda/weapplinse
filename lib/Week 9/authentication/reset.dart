import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocketcoach/Week%209/authentication/authentication.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  bool check=false;
  List<Map<String, dynamic>> dataList = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isLoading = false;

  Future<void> _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        if(emailExists(dataList, emailController.text)==true){
          await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Password reset email sent!"), duration: Duration(milliseconds: 500)),
          );
          setState(() {
            isLoading = false;
          });
          Navigator.pop(context);
        }
        else{
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("That Email Not Exists"), duration: Duration(milliseconds: 500)),
          );
        }
      } on FirebaseAuthException catch (e) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? "Something went wrong!"), duration: Duration(milliseconds: 500)),
        );
      }
    }
  }
  bool emailExists(List<Map<String, dynamic>> dataList, String targetEmail) {
    return dataList.any((item) => item['email'] == targetEmail);
  }
  Future<void> fetchFirestoreData() async {
    try {
      QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('email').get();

      if (querySnapshot.docs.isEmpty) {
        print("⚠️ No data found in Firestore!");
      }

      List<Map<String, dynamic>> tempList = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      print("🔥 Firestore Data: $tempList"); // Debug print

      setState(() {
        dataList = tempList;
      });
    } catch (e) {
      print("❌ Error fetching data: $e");
    }
  }


  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return "Please enter your email";
    final emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    if (!emailRegex.hasMatch(value)) return "Enter a valid email address";
    return null;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchFirestoreData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Reset Your Password!",
                    style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Enter your email to receive a password reset link",
                    style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(height: 32),

                  // Email Field
                  TextFormField(
                    controller: emailController,
                    maxLength: 35,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email, color: Colors.blueAccent),
                      labelText: "Email",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    validator: _validateEmail,
                  ),
                  SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: (){
                          _resetPassword();
                          print(dataList);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: isLoading
                          ? Center(child: CircularProgressIndicator(color: Colors.white,))
                          : Text(
                        "Send Reset Link",
                        style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                    ),
                  ),

                  SizedBox(height: 16),

                  // Navigate to Login
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Remember your password?", style: GoogleFonts.poppins(fontSize: 14)),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Login", style: TextStyle(color: Colors.blueAccent)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
