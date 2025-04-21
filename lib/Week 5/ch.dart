import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoogleAuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
  );

  /// Sign in with Google
  Future<GoogleSignInAccount?> signInWithGoogle() async {
    try {
      await _googleSignIn.signOut(); // Ensure fresh login
      GoogleSignInAccount? user = await _googleSignIn.signIn();

      if (user != null) {
        await _saveGoogleUserData(user);
        print("Google Sign-In Successful ✅: ${user.email}");
        return user;
      } else {
        print("Google Sign-In Canceled ❌");
        return null;
      }
    } catch (error) {
      // Providing more specific error details
      print("Google Sign-In Error 🚨: ${error.toString()}");
      return null;
    }
  }

  /// Sign out from Google
  Future<void> signOutGoogle() async {
    await _googleSignIn.signOut();
    await _clearGoogleUserData();
    print("User Signed Out from Google ✅");
  }

  /// Save user data in SharedPreferences (Google)
  Future<void> _saveGoogleUserData(GoogleSignInAccount user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      // Save user data if available, handling null values appropriately
      await prefs.setString("google_name", user.displayName ?? "");
      await prefs.setString("google_email", user.email);
      await prefs.setString("google_photoUrl", user.photoUrl ?? "");
      await prefs.setBool("google_loggedIn", true);
    } catch (e) {
      print("Error saving Google user data: $e");
    }
  }

  /// Clear Google user data
  Future<void> _clearGoogleUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await prefs.remove("google_name");
      await prefs.remove("google_email");
      await prefs.remove("google_photoUrl");
      await prefs.setBool("google_loggedIn", false);
    } catch (e) {
      print("Error clearing Google user data: $e");
    }
  }

  /// Retrieve user data from SharedPreferences
  Future<Map<String, String>?> getGoogleUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      if (prefs.getBool("google_loggedIn") ?? false) {
        return {
          "name": prefs.getString("google_name") ?? "",
          "email": prefs.getString("google_email") ?? "",
          "photoUrl": prefs.getString("google_photoUrl") ?? "",
        };
      }
    } catch (e) {
      print("Error retrieving Google user data: $e");
    }
    return null;
  }
}
