import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'local.dart';

class task83 extends StatefulWidget {
  @override
  _task83State createState() => _task83State();
}

class _task83State extends State<task83> with WidgetsBindingObserver {
  String selectedLanguage = "en";
  late LocalizationHelper localizationHelper;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _resetToSystemLanguage();
  }


  Future<void> _initializeLanguage() async {
    String preferredLanguage = await LocalizationHelper.getPreferredLanguageCode();

    setState(() {
      selectedLanguage = preferredLanguage;
    });

    localizationHelper = LocalizationHelper(Locale(preferredLanguage));
    await localizationHelper.load();

    setState(() {
      isLoading = false;
    });
  }

  void _changeLanguage(String languageCode) async {
    setState(() {
      selectedLanguage = languageCode;
      isLoading = true;
    });

    localizationHelper = LocalizationHelper(Locale(languageCode));
    await localizationHelper.load();

    await LocalizationHelper.saveLanguageCode(languageCode);

    setState(() {
      isLoading = false;
    });
  }
void system(){
  Locale systemLocale = window.locale;
  String systemLanguage = systemLocale.languageCode;
  print("System Language: $systemLanguage");

  List<String> supportedLanguages = ['en', 'es', 'fr', 'zh-CN', 'gu', 'hi'];
  if(supportedLanguages.contains(systemLanguage)){
    _changeLanguage(systemLanguage);
  }
  else{
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("System Language is Not Supported By app"),duration: Duration(milliseconds: 400),));
  }
}
  void _resetToSystemLanguage() async {
    Locale systemLocale = window.locale;
    String systemLanguage = systemLocale.languageCode;
    print("System Language: $systemLanguage");

    List<String> supportedLanguages = ['en', 'es', 'fr', 'zh-CN', 'gu', 'hi'];

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedLanguage = prefs.getString('selected_language');

    if (savedLanguage == null) {
      if(supportedLanguages.contains(systemLanguage)){
        _changeLanguage(systemLanguage);
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("System Language is Not Supported By app"),duration: Duration(milliseconds: 400),));
      }
    } else if (savedLanguage != null) {
      _changeLanguage(savedLanguage);
    } else {
      _changeLanguage('en');
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Localization"),
        actions: [
          ElevatedButton(onPressed: (){
            system();
          }, child: Text("SYSTEM"))
        ],
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: 350,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton<String>(
                    borderRadius: BorderRadius.circular(20),
                    value: selectedLanguage,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                    icon: Icon(Icons.language, color: Colors.black),
                    dropdownColor: Colors.white,
                    menuMaxHeight: 350,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        _changeLanguage(newValue);
                      }
                    },
                    items: [
                      DropdownMenuItem(value: 'en', child: Text("English")),
                      DropdownMenuItem(value: 'gu', child: Text("ગુજરાતી")),
                      DropdownMenuItem(value: 'hi', child: Text("हिंदी")),
                      DropdownMenuItem(value: 'es', child: Text("Español")),
                      DropdownMenuItem(value: 'fr', child: Text("Français")),
                      DropdownMenuItem(value: 'zh-CN', child: Text("中国人")),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              localizationHelper.translate('title'),
              style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black),
            ),
            Text(
              localizationHelper.translate('greeting'),
              style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black),
            ),
            Text(
              localizationHelper.translate('message'),
              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}