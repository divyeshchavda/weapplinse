import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocketcoach/Week%209/firestore/addfs.dart';
import 'package:pocketcoach/Week%209/firestore/updatefs.dart';

class fsdatabase extends StatefulWidget {
  @override
  _fsdatabaseState createState() => _fsdatabaseState();
}

class _fsdatabaseState extends State<fsdatabase> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Firestore Database",
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
          actions: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                    alignment: Alignment.topRight,
                    child: Card(
                      elevation: 10,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        width: 50,
                        height: 50,
                        child: InkWell(
                            onTap: () async {
                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => addfs(),
                                  ));
                            },
                            child: Icon(
                              Icons.add,
                              size: 30,
                            )),
                      ),
                    )),
              ),
            )
          ]),
      body: StreamBuilder<QuerySnapshot>(
        stream:_firestore
            .collection('TODO')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.hasData) {
            var documents = snapshot.data!.docs;

            if (documents.isEmpty) {
              return Center(
                child: Text(
                  "No tasks available",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              );
            }
            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                var data = documents[index].data() as Map<String, dynamic>;
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(data['task_title'],
                        style: GoogleFonts.poppins(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    subtitle: Text(data['task_description']),
                    trailing: Card(
                      elevation: 5,
                      child: Container(
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => updatefs(
                                          task_title: data['task_title'],
                                          task_description:
                                              data['task_description'],
                                          createDate: data['createDate'],
                                          doneDate: data['doneDate'],
                                          status: data['status'],
                                          id: data['id']),
                                    ));
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Colors.blueAccent,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("Confirm Delete"),
                                      content: const Text(
                                          "Are you sure you want to delete this item?"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("Cancel"),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            try {
                                              await _firestore
                                                  .collection('TODO')
                                                  .doc(data['id'])
                                                  .delete();
                                              print(
                                                  "Document deleted successfully");
                                              print(data['id']);
                                              Navigator.pop(context);
                                            } catch (e) {
                                              print(
                                                  "Error deleting document: $e");
                                            }
                                          },
                                          style: TextButton.styleFrom(
                                              foregroundColor: Colors.red),
                                          child: const Text("Delete"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            )
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
                            title: Center(
                                child: Text("ALL DETAILS",
                                    style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold))),
                            content: Column(
                              children: [
                                Text("Task Title : ${data['task_title']}",
                                    style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600)),
                                Text(
                                    "Task Description : ${data['task_description']}",
                                    style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600)),
                                Text("Create Date : ${data['createDate']}",
                                    style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600)),
                                Text("Done Date : ${data['doneDate']}",
                                    style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600)),
                                Text("Status : ${data['status']}",
                                    style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600)),
                                SizedBox(
                                  height: 20,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Cancel",
                                        style: GoogleFonts.poppins(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red)))
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
          }

          return Center(child: Text("No data available"));
        },
      ),
    );
  }
}
