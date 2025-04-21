import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'HOME.dart';
import 'authhelper.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  var show = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var auth = AuthHelper();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isLoading = false;

  Future<User?> signUp(String email, String password) async {
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
        DocumentReference docRef=await _firestore.collection('email').add({
         'email':emailController.text.trim().toString()
        });
        String docId = docRef.id;
        await docRef.update({
          'id': docId,
        });
        print("Data added successfully!");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("email Added Successfully!"),
            backgroundColor: Colors.green,duration: Duration(milliseconds: 400),
          ),
        );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("User already exists! Please log in."),
            duration: Duration(milliseconds: 600),
          ),
        );
        Navigator.pop(context);
      } else {
        print("Signup Error: ${e.code} - ${e.message}");
      }
      return null;
    }
  }
  void onSignInSuccess(User user) async {
    await saveUserData(user.email!,'email');
    print("User data saved in SharedPreferences!");
  }
  Future<void> saveUserData(String email,String Method) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("email", email);
    await prefs.setString("method", Method);
  }

  void _signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      User? user = await signUp(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      setState(() {
        isLoading = false;
      });
      if (user != null) {
        print("Signup Successful: ${user.email}");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HOME(email: user.email, login: 'email',)),
        );
        onSignInSuccess(user);
      } else {
        print("Signup Failed");
      }
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your email";
    }
    final emailRegex =
    RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    if (!emailRegex.hasMatch(value)) {
      return "Enter a valid email address";
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your password";
    }
    if (value.length < 8) {
      return """Password must contain at least 8
characters, uppercase, lowercase, 
digit, and special character""";
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return """Password must contain at least 8 
characters, uppercase, lowercase, 
digit, and special character""";
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return """Password must contain at least 8 
characters, uppercase, lowercase, 
digit, and special character""";
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return """Password must contain at least 8 
characters, uppercase, lowercase, 
digit, and special character""";
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return """Password must contain at least 8 
characters, uppercase, lowercase, 
digit, and special character""";
    }
    return null;
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
                    "Create an Account!",
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Sign up to get started",
                    style:
                    GoogleFonts.poppins(fontSize: 16, color: Colors.grey),
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
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: _validateEmail,
                  ),
                  SizedBox(height: 16),

                  // Password Field
                  TextFormField(
                    controller: passwordController,
                    obscureText: show,
                    maxLength: 35,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            show = !show;
                          });
                        },
                        icon: show
                            ? Icon(Icons.remove_red_eye)
                            : Icon(Icons.remove_red_eye_outlined),
                      ),
                      prefixIcon:
                      Icon(Icons.lock, color: Colors.blueAccent),
                      labelText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: _validatePassword,
                  ),
                  SizedBox(height: 24),

                  // Sign Up Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _signUp,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child:isLoading
                          ? Center(child: CircularProgressIndicator(color: Colors.white,))
                          :  Text(
                        "Sign Up",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),

                  // Already have an account? Login
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?",
                          style: GoogleFonts.poppins(fontSize: 14)),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);

                        },
                        child: Text("Login",
                            style: TextStyle(color: Colors.blueAccent)),
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
