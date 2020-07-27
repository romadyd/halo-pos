import 'dart:async';
import 'dart:io' as io;

import 'package:halopos/models/account_model.dart';
import 'package:halopos/models/config_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if(_db != null)
      return _db;
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "halopos.db");
    var theDb = await openDatabase(path, version: 4, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return theDb;
  }


  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute("CREATE TABLE Account(ID TEXT PRIMARY KEY, GoogleID TEXT, FacebookID TEXT, UniqueID TEXT, FullName TEXT, Email TEXT, DateOfBirth TEXT, Phone TEXT, Mobile TEXT, IdentityType TEXT, IdentityNumber TEXT, Address TEXT, Photo TEXT, Token TEXT, FirebaseToken TEXT, MobileStatus TEXT, EmailStatus TEXT, Status TEXT, CreatedAt TEXT, CreatedBy TEXT, UpdatedAt TEXT, UpdatedBy TEXT)");
    await db.execute("CREATE TABLE Config(ID INTEGER PRIMARY KEY, CurrentBusinessID TEXT, CurrentBusiness TEXT)");
    print("Created tables");
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    if (oldVersion < newVersion) {
      db.execute("DROP TABLE Config");
//      _onCreate(db, newVersion);

      db.execute("CREATE TABLE Config(ID TEXT PRIMARY KEY, CurrentBusinessID TEXT, CurrentBusiness TEXT)");
    }
  }

  Future<int> saveUser(Account user) async {
    var dbClient = await db;
    int res = await dbClient.insert("Account", user.toMap());
    return res;
  }

  Future<int> udpateUser(Account user) async {
    var dbClient = await db;
    int res = await dbClient.update("Account", user.toMap(), where: 'ID = ?', whereArgs: [user.id]);
    return res;
  }

  Future<int> deleteUsers() async {
    var dbClient = await db;
    int res = await dbClient.delete("Account");
    return res;
  }

  Future<bool> isLoggedIn() async {
    var dbClient = await db;
    var res = await dbClient.query("Account");
    return res.length > 0? true: false;
  }

  Future<Account> getUserSession() async {
    var dbClient = await db;
    var res = await dbClient.query("Account");
    return Account.map(res[0]);
  }

  Future<int> saveConfig(Config user) async {
    var dbClient = await db;
    int res = await dbClient.insert("Config", user.toMap());
    return res;
  }

  Future<int> udpateConfig(Config config) async {
    var dbClient = await db;
    int res = await dbClient.update("Config", config.toMap(), where: 'ID = ?', whereArgs: [config.id]);
    return res;
  }

  Future<int> deleteConfig() async {
    var dbClient = await db;
    int res = await dbClient.delete("Config");
    return res;
  }

  Future<bool> isConfigured() async {
    var dbClient = await db;
    var res = await dbClient.query("Config");
    return res.length > 0? true: false;
  }

  Future<Config> getConfig() async {
    var dbClient = await db;
    var res = await dbClient.query("Config");
    return Config.map(res[0]);
  }

}