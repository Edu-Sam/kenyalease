import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/module.dart';

class DatabaseService {

  static final DatabaseService _instance=DatabaseService.internal();
  factory DatabaseService()=>_instance;
  static  Database? _db;

  DatabaseService.internal();

  initDB() async{
    final database=openDatabase(join(await getDatabasesPath(),"somalease.db"),
        version: 2,onCreate: _onCreate,onUpgrade: _onUpgrade
    );

    return database;
  }

  void _onCreate(Database db,int version) async{

    Batch batch=db.batch();

    batch.execute("CREATE TABLE IF NOT EXISTS users(id INTEGER PRIMARY KEY AUTOINCREMENT,user_id INTEGER "
        " NOT NULL,firstname TEXT,lastname TEXT,email TEXT,phone TEXT,"
        "email_verified_at TEXT,otp TEXT,created_at TEXT,updated_at TEXT,email_verified INTEGER,"
        "email_verification_code TEXT,role_id INTEGER,remember_token TEXT,status INTEGER)");
    batch.execute("CREATE TABLE IF NOT EXISTS preferences(id INTEGER  PRIMARY KEY AUTOINCREMENT,"
        "user_id INTEGER,account_type INTEGER,isLoggedIn bit,user_state TEXT)");
    batch.execute("CREATE TABLE IF NOT EXISTS user_account_type(id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "user_id INTEGER,role_id INTEGER)");

    List<dynamic> res=await batch.commit();
  }

  void _onUpgrade(Database db,int oldVersion,int newVersion) async{
    db.execute('DROP TABLE IF EXISTS users');
    db.execute('DROP TABLE IF EXISTS preferences');
    db.execute('DROP TABLE IF EXISTS user_account_type');
  }

  Future<Database?> get db async{


    if(_db!=null){
      return _db;
    }

    else{
      _db=await initDB();

    }

    return _db;

  }

   Future<dynamic> insertUser(User user) async{
     final Database? dbClient = await db;

     if(dbClient!=null){
       print("user id is " + user.user_id.toString());
       print("firstname is " + user.firstname.toString());
       print("lastname is " + user.lastname.toString());
       print("Phone no is " + user.phone.toString());
       print("email is " + user.email.toString());
       print("email verified at " + user.email_verified_at.toString());
       print("otp is " + user.otp.toString());
       print("created at " + user.created_at.toString());
       print("updated at " + user.updated_at.toString());
       print("email verified " + user.email_verified.toString());
       print("email verified code is " + user.email_verification_code.toString());

       int result = await dbClient.insert("users",user.toJson(),conflictAlgorithm: ConflictAlgorithm.replace);
       return result;
     }

     else{
       return -100;
     }
   }

  Future<int> insertPreference(Preferences preferences) async{
    final Database? dbClient=await db;

    if(dbClient!=null){
      return await dbClient.insert("preferences",preferences.toJson(),conflictAlgorithm: ConflictAlgorithm.replace);
    }

    else{
      return -100;
    }
  }

  Future<int> insertUserAccountType(UserAccountType userAccountType) async{
    final Database? dbClient=await db;

    if(dbClient!=null){
      return await dbClient.insert("user_account_type",userAccountType.toJson(),conflictAlgorithm: ConflictAlgorithm.replace);
    }

    else{
      return -100;
    }
  }

  Future<int> deleteAccount() async{
    final Database? dbClient=await db;

    if(dbClient!=null){
      return await dbClient.delete("preferences").then((value) async{
        await deleteUser();
        await deleteUserAccountType();
        return value;
      });
    }

    else{
      return -100;
    }
  }

  Future<int> deleteUser() async{
    final Database? dbClient=await db;

    if(dbClient!=null){
      return await dbClient.delete("users").then((value){
        return value;
      });
    }

    else{
      return -100;
    }
  }

  Future<int> deleteUserAccountType() async{
    final Database? dbClient=await db;

    if(dbClient!=null){
      return await dbClient.delete("user_account_type").then((value){
        return value;
      });
    }

    else{
      return -100;
    }
  }

  Future<Preferences?> getPreferences(int isLoggedIn) async{
    try{
      final Database? dbClient=await db;
      if(dbClient!=null){
        final Map<String,dynamic>? account_map=await dbClient.query(
            'preferences',columns: [
          "id","user_id","isLoggedIn","account_type",
        ],
            where: "isLoggedIn=?",
            whereArgs: [isLoggedIn]
        ).then((value){
          if(value.isNotEmpty){
            return value.first;
          }

          else{
            return null;
          }
        });

        if(account_map!=null){
          Preferences preferences = Preferences.fromJson(account_map);
          preferences.user=await getUserByID(preferences.user_id);
          print("The preference user id is " + preferences.user!.user_id.toString());
          print("The get preferences user id is " + preferences.user_id.toString());
          return preferences;
        }

        else{
          return null;
        }
      }

      else{
        return null;
      }

    }

    catch(Exception,stacktrace){
      print("Error: " + stacktrace.toString());
      return null;
    }
  }

  Future<User> getUser() async{
    try{
      final Database? dbClient=await db;
      if(dbClient!=null){
        Map<String,dynamic>? userMap = await dbClient.query('users',columns: ["id","user_id",
          "firstname","lastname","email","phone","remember_token","email_verified_at","otp",
          "created_at","updated_at","email_verified","email_verification_code","role_id",
          "status"
        ]).then((value){
          if(value.isNotEmpty){
            return value.first;
          }

          else{
            return null;
          }
        });

        if(userMap!.isNotEmpty){
          User user = User.fromDB(userMap);
          print("Retrieved user id is" + user.user_id.toString());
          return user;
        }

        else{
          return User.init();
        }
      }

      else{
        return User.init();
      }

    }

    catch(Exception,stacktrace){
      print("ERROR: " + stacktrace.toString());
      return User.init();
    }
  }

  Future<User> getUserByID(int user_id) async{
    try{
      final Database? dbClient=await db;
      if(dbClient!=null){
        Map<String,dynamic>? userMap = await dbClient.query('users',columns: ["id","user_id",
          "firstname","lastname","email","phone","remember_token","email_verified_at","otp",
          "created_at","updated_at","email_verified","email_verification_code","role_id",
          "status"
        ],
            where: "user_id=?",
            whereArgs: [user_id]
        ).then((value){
          if(value.isNotEmpty){
            return value.first;
          }

          else{
            return null;
          }
        });

        if(userMap!.isNotEmpty){
          User user = User.fromDB(userMap);
          return user;
        }

        else{
          return User.init();
        }
      }

      else{
        return User.init();
      }

    }

    catch(Exception,stacktrace){
      print("ERROR: " + stacktrace.toString());
      return User.init();
    }
  }
}