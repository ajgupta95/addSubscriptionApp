import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import '../models/myPlan.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  String planTable = 'plan_table';
  String colId = 'id';
   String colCurrency = 'currency';
  String colAmount = 'amount';
  String colName = 'name';
   String colDescription = 'description';

  String colEvery = 'every';
  String colTimePeriod='timePeriod';
  String colFirstPayment='firstPayment'
  ;
  String colExpiryDate = 'expiryDate';
  String colColor='color';
     String colPaymentMethod = 'paymentMethod';
       String colNote='note';



  String colDate = 'date';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }


     Future <Database> get database async{
       if(_database==null){
         _database =await initializeDatabase();
       }

       return _database;
     } 

     Future<Database> initializeDatabase ()async{
       Directory directory = await getApplicationDocumentsDirectory();

       String path =directory.path + 'Plans.db';
    
    
    // opening/creating db at a given path
      
      
       var planDatabase= await openDatabase( path,version:1,onCreate:_createDb);

       return planDatabase;
     }

     void _createDb(Database db, int newVersion)async{
      await db.execute(
        'CREATE TABLE  $planTable ($colId INTEGER PRIMARY KEY AUTOINCREMENT,$colCurrency,$colAmount,$colName,'
        '$colDescription, $colEvery,$colTimePeriod,$colFirstPayment,$colColor,$colPaymentMethod,$colNote,$colDate ) ');
     }


   //To get all contacts
   Future<List<Map<String,dynamic>>> getPlanMapList()async{
     Database db= await this.database;
     var result = await db.query(planTable,orderBy:'$colAmount ASC');
     return result;
   }

   //To insert new Contact
   Future<int> insertPlan(Plan plan) async{
     Database db= await this.database;
     var result =await db.insert(planTable, plan.toMap());

     return result;
   }

   // To update Contact

   Future<int>  updateContact(Plan plan)async{
     Database db= await this.database;

     var result =await db.update(planTable, plan.toMap(),where: '$colId=?',whereArgs: [plan.id]);
     return result;
   }
   //To delete contact
   Future<int> deleteContact(int id) async {
		var db = await this.database;
		int result = await db.rawDelete('DELETE FROM $planTable WHERE $colId = $id');
		return result;
	}

  Future<int> getCount()async{
     Database db= await this.database;
    List<Map<String, dynamic>> x=await db.rawQuery('SELECT COUNT(*)from$planTable');
    int result= Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Plan>> getPlanList() async {

		var planMapList = await getPlanMapList(); // Get 'Map List' from database
		int count = planMapList.length;         // Count the number of map entries in db table

		List<Plan>  planList = List<Plan>();
		// For loop to create a 'Note List' from a 'Map List'
		for (int i = 0; i < count; i++) {
			planList.add(Plan.fromMap(planMapList[i]));
		}

		return planList;
	}



}
