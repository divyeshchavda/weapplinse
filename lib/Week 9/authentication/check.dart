import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GoogleSignInService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
  );
  static final FirebaseAuth _auth = FirebaseAuth.instance;


  static Future<User?> signInWithGoogle() async {
    try {
      // Step 1: Start Google Sign-In Flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        print("❌ User canceled sign-in");
        return null;
      }

      print("✅ Google User Signed In: ${googleUser.displayName}, ${googleUser.email}");

      // Step 2: Get Authentication details
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Step 3: Create a Credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      print("---->" + "${googleAuth.idToken}");
      // Step 4: Sign in with Firebase
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        print("✅ Firebase User: ${user.displayName}, ${user.email}, ${user.photoURL},");
      } else {
        print("❌ User is null after authentication");
      }

      return user;
    } catch (e) {
      print("❌ Google Sign-In Error: $e");
      Fluttertoast.showToast(msg: "❌ Google Sign-In Error: $e");
      return null;
    }
  }

  // Sign Out Function
  static Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}


class FacebookSignInService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<User?> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final OAuthCredential credential = FacebookAuthProvider.credential(result.accessToken!.tokenString);
        final UserCredential userCredential = await _auth.signInWithCredential(credential);
        final User? user = userCredential.user;

        if (user != null) {
          print("✅ Facebook Sign-In Success");
          print("👤 Name: ${user.displayName}");
          print("📧 Email: ${user.email}");
          print("🖼️ Photo URL: ${user.photoURL}");
        } else {
          print("❌ Firebase User is null");
        }

        return user;
      } else {
        print("❌ Facebook Sign-In Failed: ${result.message}");
        return null;
      }
    } catch (e) {
      print("❌ Facebook Sign-In Error: $e");
      Fluttertoast.showToast(msg: "Email Already Exist With Google Or Email");
      return null;
    }
  }

  static Future<void> signOut2() async {
    await FacebookAuth.instance.logOut();
    await _auth.signOut();
  }
}

