import 'dart:io';
import 'package:hockey/data/db/constants.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();

  Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  Future createDatabase() async {
    return await openDatabase(await databasePath, version: 1, onCreate: initDB, onUpgrade: onUpgrade);
  }

  Future deleteDB() async {
    _database = null;
    return await deleteDatabase(await databasePath);
  }

  static Future<String> get databasePath async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    return join(documentsDirectory.path, "hockey.db");
  }

  Future<bool> get databaseExists async {
    return await databaseFactory.databaseExists(await databasePath);
  }

  //This is optional, and only used for changing DB schema migrations
  void onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {}
  }

  void initDB(Database database, int version) async {
    await database.execute('''
      CREATE TABLE $teamsTable (
        $columnId INTEGER PRIMARY KEY NOT NULL,
        $columnLeagueName TEXT NOT NULL,
        $columnTeamName TEXT NOT NULL,
        $columnCountry TEXT NOT NULL,
        $columnBudget REAL NOT NULL,
        $columnArena TEXT NOT NULL,
        $columnCapacity INTEGER NOT NULL,
        $columnFarmId INTEGER,
        $columnConference TEXT NOT NULL,
        $columnDivision TEXT NOT NULL,
        $columnAbbreviation TEXT NOT NULL,
        $columnColor TEXT NOT NULL,
        $columnEmblem TEXT NOT NULL
      )
      '''
    );
    await database.execute('''
      CREATE TABLE $playersTable (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnTeamId INTEGER NOT NULL,
        $columnSalary REAL NOT NULL,
        $columnFirstName TEXT NOT NULL,
        $columnLastName TEXT NOT NULL,
        $columnTeamPos INTEGER NOT NULL,
        $columnPos TEXT NOT NULL,
        $columnAge INTEGER NOT NULL,
        $columnSkill INTEGER NOT NULL,
        $columnNationality TEXT NOT NULL,
        $columnContract TEXT NOT NULL,
        $columnJerseyNum INTEGER NOT NULL,
        $columnIsAfro TEXT NOT NULL
      )
      '''
    );
    /*await database.execute('''
      CREATE TABLE $scheduleNHLTable (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnHomeId INTEGER NOT NULL,
        $columnAwayId INTEGER NOT NULL,
        $columnHomeScore INTEGER NOT NULL,
        $columnAwayScore INTEGER NOT NULL,
        $columnGameDate TEXT NOT NULL
      )
      '''
    );*/
  }
}
