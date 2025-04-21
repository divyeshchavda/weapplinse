import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';

class BranchService {
  static Future<String?> generateDynamicLink({
    required String userId,
    required String username,
    required String email,
    required String profileImageUrl,
  }) async {
    try {
      // Ensure Branch SDK is initialized before proceeding
      await FlutterBranchSdk.init();

      // Create a Branch Universal Object
      BranchUniversalObject buo = BranchUniversalObject(
        canonicalIdentifier: "user/$userId",
        title: "$username's Profile",
        contentDescription: "Check out $username's profile!",
        publiclyIndex: true,
        locallyIndex: true,
        contentMetadata: BranchContentMetaData()
          ..addCustomMetadata("userId", userId)
          ..addCustomMetadata("username", username)
          ..addCustomMetadata("email", email)
          ..addCustomMetadata("profileImageUrl", profileImageUrl),
      );

      // Create Link Properties
      BranchLinkProperties linkProperties = BranchLinkProperties(
        campaign: "user_sharing",
        feature: "deep_linking",
        stage: "profile_share",
      );

      // Generate short dynamic link
      BranchResponse response = await FlutterBranchSdk.getShortUrl(
        buo: buo,
        linkProperties: linkProperties,
      );

      if (response.success) {
        return response.result; // Generated short link
      } else {
        print("Branch.io Error: ${response.errorMessage}");
        return null;
      }
    } catch (e) {
      print("Error generating Branch link: $e");
      return null;
    }
  }
}
