import 'dart:typed_data';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBhelper2 {
  static Database? db;

  // Get database instance
  Future<Database> getdb() async {
    if (db != null) return db!;
    String path = join(await getDatabasesPath(), 'new2.db');
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE std_de (
            rno INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            email TEXT,
            password TEXT,
            image BLOB
          )
        ''');
      },
    );
    return db!;
  }

  // Insert data
  Future<int> add(String t, String e, String d, Uint8List imageData) async {
    final db = await getdb();
    return await db.insert('std_de', {
      'name': t,
      'email': e,
      'password': d,
      'image': imageData,
    });
  }

  // Update data
  Future<int> update(int i, String? t, String? e, String? d, Uint8List? imageData) async {
    final db = await getdb();
    Map<String, dynamic> updateValues = {};
    if (t != null) updateValues['name'] = t;
    if (e != null) updateValues['email'] = e;
    if (d != null) updateValues['password'] = d;
    if (imageData != null) updateValues['image'] = imageData;

    return await db.update('std_de', updateValues, where: 'rno = ?', whereArgs: [i]);
  }

  // Delete data
  Future<int> delete(int i) async {
    final db = await getdb();
    return await db.delete('std_de', where: 'rno = ?', whereArgs: [i]);
  }

  // Display all data
  Future<List<Map<String, dynamic>>> display() async {
    final db = await getdb();
    return db.query('std_de');
  }

  // Display data for a specific ID
  Future<List<Map<String, dynamic>>> displayd(int i) async {
    final db = await getdb();
    return db.query('std_de', where: 'rno = ?', whereArgs: [i]);
  }
}
