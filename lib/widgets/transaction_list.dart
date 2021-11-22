import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:json_test1/models/product.dart';

class TransactionList extends StatelessWidget {
  final List<Product> transaction;
  final Function deleteTx;
  TransactionList(this.transaction, this.deleteTx);

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
                SizedBox(height: 100),
                Image.asset(
                  "assets/images/waiting.png",
                  fit: BoxFit.fitHeight,
                  height: 300,
                  width: 300,
                )
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
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
                      trailing: IconButton(
                        icon: Icon(Icons.delete_outlined),
                        color: Theme.of(context).errorColor,
                        iconSize: 35,
                        onPressed: () => deleteTx(transaction[index].id),
                      ),
                    ),
                  ],
                ),
              );
            },
            itemCount: transaction.length,
          );
  }
}
