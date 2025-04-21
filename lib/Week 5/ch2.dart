import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FacebookAuthService {
  Future<Map<String, dynamic>?> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final userData2 = await FacebookAuth.instance.getUserData();
        await _saveFacebookUserData(userData2);
        return userData2;
      }
    } catch (error) {
      print("Facebook Login Error: $error");
    }
    return null;
  }

  Future<void> signOutFacebook() async {
    await FacebookAuth.instance.logOut();
    await _clearFacebookUserData();
    print("User Signed Out from Facebook ✅");
  }

  Future<void> _saveFacebookUserData(Map<String, dynamic> userData2) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("facebook_name", userData2["name"] ?? "");
    prefs.setString("facebook_email", userData2["email"] ?? "");
    prefs.setString("facebook_photoUrl", userData2["picture"]["data"]["url"] ?? "");
    prefs.setBool("facebook_loggedIn", true);
  }

  Future<void> _clearFacebookUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("facebook_name");
    prefs.remove("facebook_email");
    prefs.remove("facebook_photoUrl");
    prefs.setBool("facebook_loggedIn", false);
  }

  Future<Map<String, String>?> getFacebookUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("facebook_loggedIn") ?? false) {
      return {
        "name": prefs.getString("facebook_name") ?? "",
        "email": prefs.getString("facebook_email") ?? "",
        "photoUrl": prefs.getString("facebook_photoUrl") ?? "",
      };
    }
    return null;
  }
}
