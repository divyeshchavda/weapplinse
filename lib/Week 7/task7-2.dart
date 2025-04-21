import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class task712 extends StatefulWidget {
  @override
  _task712State createState() => _task712State();
}

class _task712State extends State<task712> {
  List<int> randomNumbers = [];
  void generateRandomNumbers() {
    Random random = Random();
    List<int> numbers = List.generate(15, (index) => random.nextInt(100));
    setState(() {
      randomNumbers = numbers;
    });
  }


  Future<void> _onRefresh() async {
    await Future.delayed(Duration(seconds: 1));
    generateRandomNumbers();
  }

  @override
  void initState() {
    super.initState();
    generateRandomNumbers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pull to Refresh'),
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh, 
        child: ListView.builder(
          itemCount: randomNumbers.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Card(
                child: ListTile(
                  title: Text('Number: ${randomNumbers[index]}',style: GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.bold),),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
