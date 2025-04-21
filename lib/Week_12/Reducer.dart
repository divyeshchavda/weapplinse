import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'counter_state.dart';

class reducer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counterState = context.watch<CounterState>(); // Access inside widget tree

    return Scaffold(
      appBar: AppBar(title: Text("Reducer")),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),backgroundColor: Colors.black),
              onPressed: () => counterState.dispatch(IncrementAction()),
              child: Text("+",style: GoogleFonts.poppins(fontSize: 40,fontWeight: FontWeight.w700,color: Colors.white),),
            ),
            SizedBox(width: 20),
            Container(
              width: 120,
              child: Center(
                child: Text(counterState.state.count.toString(),
                    style: TextStyle(fontSize: 40)),
              ),
            ),
            SizedBox(width: 20),
            ElevatedButton(style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),backgroundColor: Colors.black),
              onPressed: () => counterState.dispatch(DecrementAction()),
              child: Text("-",style: GoogleFonts.poppins(fontSize: 40,fontWeight: FontWeight.w700,color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}
