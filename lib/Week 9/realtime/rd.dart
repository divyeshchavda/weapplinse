import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocketcoach/Week%209/realtime/update.dart';

import 'add.dart';

class EmployeeListScreen extends StatefulWidget {
  @override
  _EmployeeListScreenState createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  final DatabaseReference databaseRef = FirebaseDatabase.instance.ref("Employees");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee List"),
        actions: [
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Card(
                  elevation: 10,
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(15))),
                    width: 50,
                    height: 50,
                    child: InkWell(
                      onTap: () async {
                        await Navigator.push(context, MaterialPageRoute(builder: (context) => AddEmployeeScreen()));
                      },
                      child: Icon(Icons.add, size: 30),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: databaseRef.onValue, // Listen for real-time updates
        builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
          if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
            return Center(child: Text("No Employees Found!"));
          }

          Map<dynamic, dynamic> employees = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
          List<Map<String, dynamic>> employeeList =
              employees.entries.map((entry) {
                Map<String, dynamic> employee = Map<String, dynamic>.from(entry.value);
                employee['id'] = entry.key; // Add Firebase key as ID
                return employee;
              }).toList();

          return ListView.builder(
            itemCount: employeeList.length,
            itemBuilder: (context, index) {
              var employee = employeeList[index];
              return Card(
                margin: EdgeInsets.all(10),
                child: ListTile(
                  title: Text(employee['name'], style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
                  subtitle: Text("${employee['designation']}"),
                  trailing: Card(
                    elevation: 5,
                    child: Container(
                      width: 100,
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => update(
                                        name: employee['name'],
                                        designation: employee['designation'],
                                        gender: employee['gender'],
                                        mobile_no: employee['mobile_no'],
                                        salary: employee['salary'].toString(),
                                        email: employee['email'],
                                        id: employee['id'],
                                      ),
                                ),
                              );
                            },
                            icon: Icon(Icons.edit, color: Colors.blueAccent),
                          ),
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Confirm Delete"),
                                    content: const Text("Are you sure you want to delete this item?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Cancel"),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          Navigator.pop(context);
                                          DatabaseReference ref = FirebaseDatabase.instance.ref("Employees/${employee['id']}");

                                          try {
                                            await ref.remove();
                                            print("Employee deleted successfully!");
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Employee deleted successfully!"), duration: Duration(milliseconds: 500)));
                                          } catch (error) {
                                            print("Failed to delete employee: $error");
                                          }
                                        },
                                        style: TextButton.styleFrom(foregroundColor: Colors.red),
                                        child: const Text("Delete"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            icon: Icon(Icons.delete, color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          scrollable: true,
                          title: Center(child: Text("ALL DETAILS", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold))),
                          content: Column(
                            children: [
                              Text("Name : ${employee['name']}", style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600)),
                              Text("Designation : ${employee['designation']}", style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600)),
                              Text("Gender : ${employee['gender']}", style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600)),
                              Text("Mobile : ${employee['mobile_no']}", style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600)),
                              Text("Salary : Rs ${employee['salary']}", style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600)),
                              Text("Email : ${employee['email']}", style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600)),
                              SizedBox(height: 20),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Cancel", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red)),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
