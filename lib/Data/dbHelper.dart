import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DbHelper{

  static const String TABLE_NOTES= "notesTable";
  static const String COLUMN_TITLE = "title";
  static const String COLUMN_DATA = "data";
  static const String COLUMN_ID = "id";

  DbHelper._();
  static final DbHelper getInstance = DbHelper._();

  Database? _myDB;

  Future<Database> _getDB() async{
    _myDB = _myDB?? await _openDB();

    return _myDB!;
  }

  Future<Database> _openDB() async{
    Directory appDir = await getApplicationDocumentsDirectory();
    String dbPath = join(appDir.path,"notesDB.db");

    return await openDatabase(
      dbPath,   
      version:1,
      onCreate: (db, version) => 
      db.execute("create table $TABLE_NOTES ($COLUMN_ID integer primary key autoincrement, $COLUMN_TITLE string not null,$COLUMN_DATA string)"),);
  }

  Future<bool> addNotes({required String title, required String data}) async{
    _myDB = await _getDB();

    int rowAffected = await _myDB!.insert(TABLE_NOTES, {COLUMN_DATA:data,COLUMN_TITLE:title});

    return rowAffected>0;
  }

  Future<List<Map<String,dynamic>>> getAllNotes() async{
    _myDB = await _getDB();
    List<Map<String,dynamic>> data = await _myDB!.rawQuery("select * from $TABLE_NOTES");

    debugPrint("$data");

    return data;
  }

  Future<bool> deleteNote({required int id}) async{

    _myDB = await _getDB();

    int rowAffected = await _myDB!.delete(TABLE_NOTES,where:"id=?",whereArgs: [id]);

    return rowAffected>0;
  }    
}