import 'dart:developer';
import 'dart:io';
import 'package:flutter_application_1/models/transactions.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class TransactionDB {
  //create database

  String databaseName;

  TransactionDB({this.databaseName});

  //example -> /data/user/0/com.example.flutter_application_1/app_flutter/database
  Future<Database> openDatabase() async {
    //find location
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String locationDB = join(appDirectory.path, databaseName);

    //create database
    DatabaseFactory dbFactory = databaseFactoryIo;
    Database db = await dbFactory.openDatabase(locationDB);

    return db;
  }

  //add data to database
  Future<int> insertData(Transactions statement) async {
    //database -> store
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store("expense");

    //JSON object
    var keyID = store.add(db, {
      "title": statement.title,
      "amount": statement.amount,
      "date": statement.date.toIso8601String() //format date
    });
    db.close();

    return keyID; //primary ID.
  }

  //query data
  Future<List<Transactions>> loadAllData() async {
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store("expense");

    //find data and sort new to old by keyID
    var snapshot = await store.find(db,
        finder: Finder(sortOrders: [SortOrder(Field.key, false)]));
    log("$snapshot");

    //loop data
    // ignore: deprecated_member_use
    List transactionList = List<Transactions>();
    for (var record in snapshot) {
      transactionList.add(Transactions(
          title: record["title"],
          amount: record["amount"],
          date: DateTime.parse(record["date"])));
    }

    return transactionList;
  }
}
