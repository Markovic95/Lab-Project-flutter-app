import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

import '../session/Manager.dart';

class DBHelper {
  /*καλω τον sessio manager για να μπορεσω να παρω το token οπου θα ειναι και το username 
    του χρηστη
  */
  SessionManager prefs = SessionManager();
  //function to insert to database

  static Future<sql.Database> database() async {
    //δημιουργια βασης αν δεν υπαρχει
    final dbPath = await sql
        .getDatabasesPath(); //to path αναλογα android/iOS επιστρεφει ενα future γιαυτο εχουμε βαλει το await.
    return sql.openDatabase(
      path.join(dbPath, 'myydb.db'),
      version: 1,
      onCreate: _createDB,
    ); //αν υπαρχει το αρχειο ανοιγει την βαση διαφορετικα την δημιουργει
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    print(data); //τυπωνω τα δεδομένα για να δω οτι ειναι σωστά
    final db = await DBHelper.database();
    db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.ignore);
    //με το await εδω περιμενουμε να τελειωσουν ολες οι διαδικασιες στην συναρτηση insert
  }

  static Future<List<Map<String, dynamic>>> getlog(table) async {
    final db = await DBHelper.database();
    return db.rawQuery("SELECT username , password from users");
  }

  static Future<List<Map<String, dynamic>>> getuser(Table, String usr) async {
    final db = await DBHelper.database();
    return db.rawQuery("SELECT * from users where " " username = '$usr' ");
  }
  
  static Future<void> update(Table, Map<String, Object> data) async {
    final db = await DBHelper.database();

    final poplst = await updatelisting(data);
    db.update(Table, data, conflictAlgorithm: sql.ConflictAlgorithm.ignore);

    // return db.rawQuery('''update users set name = $data:name,birth = $data:birth,gender = $data:gender,weight = $data:weight,username = $data:username,
    //password = $data:password,email = $data:email where id = ?  [$data]''');
  }

  static Future _createDB(db, version) {
    return db.execute('''
        CREATE TABLE users(
          id INTEGER PRIMARY KEY AUTOINCREMENT, 
          name TEXT NOT NULL, 
          birth DATE NOT NULL, 
          gender TEXT NOT NULL,
          weight TEXT NOT NULL,
          username TEXT NOT NULL,
          password TEXT NOT NULL,
          email TEXT NOT NULL
          )
          ''');
    //επιστρεφει ενα future και με το return ενημερωνει ποτε επιστρεφεται το future
  }

  static Future<List<Map<String, dynamic>>> getData(table) async {
    final db = await DBHelper.database();
    return db.query(table); //επιστρεφει μια λιστα απο maps
  }
}

updatelisting(Map<String, Object> data) async {
  final poplist = data;
  poplist.forEach((key, value) {
    print(value);
  });

 // return poplist;
}
