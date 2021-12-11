import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:json_test1/models/product.dart';

class TransactionList extends StatelessWidget {
  final List<Product> transaction;
  final Function deleteTx;
  final bool showChart;
  TransactionList(this.transaction, this.deleteTx, this.showChart);

  @override
  Widget build(BuildContext context) {
    return transaction.isEmpty
        ? LayoutBuilder(builder: (ctx, constrains) {
            return Column(
              children: [
                Text(
                  // ignore: deprecated_member_use
                  ("You have not entered any information yet. Click the button below!"),
                  style: Theme.of(context).textTheme.headline6,
                ),
                MediaQuery.of(context).orientation == Orientation.landscape
                    ? SizedBox(height: 20)
                    : SizedBox(height: 45),
                MediaQuery.of(context).orientation == Orientation.landscape
                    ? Image.asset("assets/images/waiting.png",
                        fit: BoxFit.fitHeight,
                        height: constrains.maxHeight * 0.7)
                    : Image.asset(
                        "assets/images/waiting.png",
                        fit: BoxFit.fitHeight,
                        height: constrains.maxHeight * 0.6,
                      ),
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Dismissible(
                key: UniqueKey(),
                child: Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  elevation: 5,
                  child: Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          child: Padding(
                            padding: EdgeInsets.all(6),
                            child: FittedBox(
                                child: Text('\$${transaction[index].amount}')),
                          ),
                        ),
                        title: Text(
                          transaction[index].title,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        subtitle: Text(
                            DateFormat.yMMMd().format(transaction[index].date)),
                        trailing: MediaQuery.of(context).size.width > 390
                            // ignore: deprecated_member_use
                            ? FlatButton.icon(
                                onPressed: () =>
                                    deleteTx(transaction[index].id),
                                icon: Icon(
                                  Icons.delete_outlined,
                                  size: 35,
                                  color: Colors.red,
                                ),
                                label: Text(
                                  "delete",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                color: Colors.white)
                            : IconButton(
                                icon: Icon(Icons.delete_outlined),
                                color: Theme.of(context).errorColor,
                                iconSize: 35,
                                onPressed: () =>
                                    deleteTx(transaction[index].id),
                              ),
                      ),
                    ],
                  ),
                ),
              );
            },
            itemCount: transaction.length,
          );
  }
}
