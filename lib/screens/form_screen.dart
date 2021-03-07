import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/models/transactions.dart';
import 'package:flutter_application_1/providers/transaction_provider.dart';
import 'package:provider/provider.dart';

class FormScreen extends StatelessWidget {
  //key
  final formKey = GlobalKey<FormState>();

  //controller
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Page 2 : Form"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          //create form
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: new InputDecoration(labelText: "Name"),
                  autofocus: false,
                  validator: (String str) {
                    if (str.isEmpty) {
                      return "Please enter statement";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: amountController,
                  decoration: new InputDecoration(labelText: "Amount"),
                  keyboardType: TextInputType.number,
                  validator: (String str) {
                    if (str.isEmpty) {
                      return "Please enter amount";
                    }
                    if (double.parse(str) <= 0) {
                      return "Amount must be > 0";
                    }
                    return null;
                  },
                ),
                // ignore: deprecated_member_use
                FlatButton(
                  onPressed: () {
                    //validate data
                    if (formKey.currentState.validate()) {
                      //get data from view
                      var title = titleController.text;
                      var amount = amountController.text;

                      log("Statement : $title");
                      log("Amount : $amount");

                      //prepare data to provider
                      //create an object
                      Transactions statement = Transactions(
                          title: title,
                          amount: double.parse(amount),
                          date: DateTime.now());

                      //call provider
                      var provider = Provider.of<TransactionProvider>(context,
                          listen: false);
                      //add
                      provider.addTransaction(statement);

                      // <- Back to page 1
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              fullscreenDialog: true,
                              builder: (context) {
                                return MyHomePage();
                              }));
                    }
                  },
                  child: Text("Add statement"),
                  color: Colors.blue,
                  textColor: Colors.white,
                )
              ],
            ),
          ),
        ));
  }
}
