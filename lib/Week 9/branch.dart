import 'package:flutter/material.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';

class branch extends StatefulWidget {
  const branch({Key? key}) : super(key: key);

  @override
  State<branch> createState() => _branchState();
}

class _branchState extends State<branch> {
  String? link;
  void initState() {
    super.initState();
  }

  Future<void> generateBranchLink() async {
    // Define link parameters
    BranchUniversalObject buo = BranchUniversalObject(
      canonicalIdentifier: 'content/12345',
      title: 'Open PN Page',
      contentDescription: 'Click to open the PN page in the app.',
      contentMetadata: BranchContentMetaData()..addCustomMetadata('deeplink_path', '/pn'),
    );

    BranchLinkProperties lp = BranchLinkProperties(
      channel: 'app',
      feature: 'sharing',
      campaign: 'user_share',
      stage: 'new_user',
    );

    // Generate the link
    BranchResponse response = await FlutterBranchSdk.getShortUrl(buo: buo, linkProperties: lp);

    if (response.success) {
      print('Branch Link: ${response.result}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Link: ${response.result}')),
      );
      setState(() {
        link=response.result;
      });
    } else {
      print('Error: ${response.errorMessage}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dynamic Link Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            link?.isNotEmpty==true?SelectableText("$link"):SizedBox(),
            ElevatedButton(
              onPressed: generateBranchLink,
              child: const Text('Create Dynamic Link'),
            ),
          ],
        ),
      ),
    );
  }
}
