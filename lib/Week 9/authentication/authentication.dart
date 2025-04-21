import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:pocketcoach/Week%209/authentication/reset.dart';
import 'package:pocketcoach/Week%209/authentication/signup.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'HOME.dart';
import 'authhelper.dart';
import 'check.dart';

class authentication extends StatefulWidget {
  const authentication({super.key});

  @override
  State<authentication> createState() => _authenticationState();
}

class _authenticationState extends State<authentication> {
  final _formKey = GlobalKey<FormState>();
  var show=true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var auth=AuthHelper();
  late Future<User?> user;
  List<Map<String, dynamic>> dataList = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isLoading = false;
  bool isLoading2 = false;

  Future<User?> signInWithEmail(String email, String password) async {

    try {
      print(dataList);
     if(emailExists(dataList, emailController.text)==true){
       UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
         email: email,
         password: password,
       );
       emailController.clear();
       passwordController.clear();
       return userCredential.user;
     }
     else{
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
           content: Text("Account Not Exist"),
           duration: Duration(milliseconds: 400),
         ),
       );
     }
    }  on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Incorrect PassWord Please Change Password Or Reset it."),
            duration: Duration(milliseconds: 400),
          ),
        );
      } else {
        if(e.code=="too-many-requests"){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Too Many Request Try again Later"),
              duration: Duration(milliseconds: 400),
            ),
          );
        }
        print("Signup Error: ${e.code} - ${e.message}");
      }
      return null;
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.clear();
    passwordController.clear();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchFirestoreData();
  }
  void _signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading2 = true;
      });
      User? user = await signInWithEmail(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      setState(() {
        isLoading2 = false;
      });
      if (user != null) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HOME(
                email: user.email,
                login: 'email',
              ),
            ));
        onSignInSuccess(user, 'email');
      } else {
        print("SignIn Failed");
      }
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your email";
    }
    final emailRegex = RegExp(
        r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    if (!emailRegex.hasMatch(value)) {
      return "Enter a valid email address";
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your password";
    }
    return null;
  }
  void onSignInSuccess(User user,String Method) async {
    await saveUserData(user.email!,Method);
    DocumentReference docRef=await _firestore.collection('email').add({
      'email':user.email!.toString()
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
    print("User data saved in SharedPreferences!");
  }
  Future<void> saveUserData(String email,String Method) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("email", email);
    await prefs.setString("method", Method);
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
                    "Welcome Back!",
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Login to your account",
                    style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(height: 32),
              
                  // Email Field
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    maxLength: 35,
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
                    obscureText: show==true?true:false,
                    maxLength: 35,
                    decoration: InputDecoration( suffixIcon: IconButton(onPressed: (){
                      if(show==true){
                        setState(() {
                          show=false;
                        });
                      }
                      else{
                        setState(() {
                          show=true;
                        });
                      }
                    }, icon: show==true?Icon(Icons.remove_red_eye):Icon(Icons.remove_red_eye_outlined)),
                      prefixIcon: Icon(Icons.lock, color: Colors.blueAccent),
                      labelText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: _validatePassword,
                  ),
                  SizedBox(height: 12),
              
                  // Forgot Password?
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPasswordScreen(),));
                        emailController.clear();
                        passwordController.clear();
                      },
                      child: Text("Forgot Password?",
                          style: TextStyle(color: Colors.blueAccent)),
                    ),
                  ),
              
                  SizedBox(height: 24),
              

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
                      child: isLoading2
                        ? CircularProgressIndicator(color: Colors.white)
                        :  Text(
                        "Login",
                        style: GoogleFonts.poppins(
                            fontSize: 18, fontWeight: FontWeight.w600,color: Colors.white),
                      ),
                    ),
                  ),
              
                  SizedBox(height: 16),
              

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?",
                          style: GoogleFonts.poppins(fontSize: 14)),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen(),));
                          emailController.clear();
                          passwordController.clear();
                        },
                        child: Text("Sign Up",
                            style: TextStyle(color: Colors.blueAccent)),
                      ),
                    ],
                  ),
                  SizedBox(height: 30,),
                  ElevatedButton(onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    User? user=await GoogleSignInService.signInWithGoogle();
                    setState(() {
                      isLoading = false;
                    });

                    if (user != null) {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder:  (context) => HOME(email: user.email, login: 'google',),));
                      onSignInSuccess(user,'google');
                    } else {
                      print("SignIn Failed");
                    }
                  }, child:isLoading
                      ? Center(child: SizedBox(height:20,width:20,child: CircularProgressIndicator(color: Colors.black,)))
                    :  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset("assets/google1.svg",height: 30,width: 30,),

                      ),
                      SizedBox(width: 10,),
                      Text("Sign In With Google",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.black)),
                    ],
                  )),
                  SizedBox(height: 10,),
                  ElevatedButton(onPressed: () async {
                    User? user=await FacebookSignInService.signInWithFacebook();
                    if (user != null) {
                      print(user.email);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder:  (context) => HOME(email: user.email, login: 'facebook',),));
                      onSignInSuccess(user,'facebook');
                    } else {
                      print("SignIn Failed");
                    }
                  }, child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset("assets/facebook1.svg",height: 30,width: 30,),

                      ),
                      SizedBox(width: 10,),
                      Text("Sign In With Facebook",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.black)),
                    ],
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}