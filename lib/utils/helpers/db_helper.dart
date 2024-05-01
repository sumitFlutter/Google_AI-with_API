import 'dart:io';
import 'package:google_gemini/screen/home/model/db_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
class DBHelper{
  static DBHelper dbHelper= DBHelper._();
  DBHelper._();
  Database? database;
  Future<Database?> checkDB() async {
    if(database!=null)
    {
      return database;
    }
    else{
      var db=await initDB();
      return db;
    }
  }
  Future<Database> initDB() async {
    Directory d1=await getApplicationSupportDirectory();
    String path=d1.path;
    String joinPath=join(path,"gemini.db");
    return openDatabase(joinPath,onCreate: (db, version) {
      db.execute('CREATE TABLE gemini(id INTEGER PRIMARY KEY,textMsg TEXT,date TEXT,time TEXT,isQ INTEGER)');
    },version: 1);
  }
  Future<void> insertMsg(GeminiDBModel geminiDBModel) async {
    Database dbi=(await checkDB())!;
    dbi.insert("gemini",{"textMsg":geminiDBModel.text,"date":geminiDBModel.date,"time":geminiDBModel.time,"isQ":geminiDBModel.isQ} );
  }
  Future<List<GeminiDBModel>> readMsg() async {
    Database dbc=(await checkDB())!;
    List <Map>l1 =await dbc.rawQuery("SELECT * FROM gemini");
    List<GeminiDBModel> c=l1.map((e) => GeminiDBModel.mapToModel(e)).toList();
    return c;
  }
  Future<void> deleteChat({required int id}) async {
    Database dbd=(await checkDB())!;
    dbd.delete("gemini",whereArgs: [id],where: "id==?");
  }

}