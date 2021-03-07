import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/models/transactions.dart';
import 'package:flutter_application_1/providers/transaction_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // Query data when start app.
    super.initState();
    Provider.of<TransactionProvider>(context, listen: false).initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Page 1 : Home Statement"),
          actions: [
            IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  // -> exit from app
                  SystemNavigator.pop();
                })
          ],
        ),
        body: Consumer(
            builder: (context, TransactionProvider provider, Widget child) {
          //check list
          var count = provider.transaction.length;
          if (count <= 0) {
            return Center(
              child: Text(
                "No statemens",
                style: TextStyle(fontSize: 35),
              ),
            );
          } else {
            return ListView.builder(
                itemCount: count,
                itemBuilder: (context, int index) {
                  Transactions data = provider.transaction[index];
                  //cardView
                  return Card(
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    elevation: 5,
                    //listView
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 20,
                        child: FittedBox(
                          child: Text("${data.amount}"),
                        ),
                      ),
                      title: Text(data.title),
                      subtitle:
                          Text(DateFormat("dd/MMM/yyyy").format(data.date)),
                    ),
                  );
                });
          }
        }));
  }
}
