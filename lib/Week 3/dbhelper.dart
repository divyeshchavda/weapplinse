import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class dbhelper{
  static Database? db;
  Future<Database> getdb() async{
    if(db!=null) return db!;
    String path=join(await getDatabasesPath(),'std.db');
    db=await openDatabase(path,version: 1,onCreate: (db,version){
      db.execute('''Create table std_de(rno Integer Primary key,name Text,city Text,password Text)''');
    });
    return db!;
  }
  Future<int> add(int i,String t,String c,String d) async {
    final db=await getdb();
    return await db.insert('std_de', {'rno':i,'name':t,'city':c,'password':d});
  }
  Future<int> update(int i,String? t,String? c,String? d) async {
    final db=await getdb();
    return await db.update('std_de', {'name':t,'city':c,'password':d},where:'rno=?',whereArgs: [i]);
  }
  Future<int> delete(int i) async {
    final db=await getdb();
    return await db.delete('std_de',where:'rno=?',whereArgs: [i]);
  }
  Future<List<Map<String,dynamic>>> display() async{
    final db=await getdb();
    return db.query('std_de');
}
}
