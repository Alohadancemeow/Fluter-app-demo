import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/models/transactions.dart';
import 'package:flutter_application_1/database/transaction_db.dart';

class TransactionProvider with ChangeNotifier {
  // list cards
  List<Transactions> transaction = [];

  //getter
  List<Transactions> getTransaction() {
    return transaction;
  }

  void initData() async {
    //open DB
    var db = TransactionDB(databaseName: "database");
    //query data form database
    transaction = await db.loadAllData();

    //notify to consumer
    notifyListeners();
  }

  //setter
  void addTransaction(Transactions statement) async {
    //open DB
    var db = TransactionDB(databaseName: "database");
    // log("$db");

    //save data to database
    await db.insertData(statement);

    //query data form database
    transaction = await db.loadAllData();

    //insert row
    // transaction.insert(0, statement);

    //notify to consumer
    notifyListeners();
  }
}
