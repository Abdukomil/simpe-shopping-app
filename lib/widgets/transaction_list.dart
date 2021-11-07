import 'package:flutter/material.dart';
import 'package:json_test1/models/product.dart';

class TransactionList extends StatelessWidget {
  final List<Product> transaction;
  TransactionList(this.transaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      child: transaction.isEmpty
          ? Column(
              children: [
                Text(
                  // ignore: deprecated_member_use
                  'Hali malumot yaratilmadi. Iltimos malumotni yaratib qaytada urinib ko\'ring',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 100),
                // Image.network(
                //   "https://reqres.in/img/faces/8-image.jpg",
                // ),
                Image.asset(
                  "assets/images/waiting.png",
                  fit: BoxFit.fitHeight,
                  height: 300,
                  width: 300,
                )
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 10,
                  margin: EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      Container(
                        height: 90,
                        width: 110,
                        margin: EdgeInsets.only(right: 20, left: 10),
                        decoration: BoxDecoration(),
                        padding: EdgeInsets.all(0),
                        child: Image(
                          image: AssetImage(
                            'images/divan.jpeg',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Text(transaction[index].title),
                            Text(transaction[index].amount.toString() + "₩"),
                            Text("" + transaction[index].date.toString()),
                            // ignore: deprecated_member_use
                            FlatButton(
                              onPressed: () {},
                              child: Text('Bay',
                                  style: TextStyle(color: Colors.white)),
                              color: Theme.of(context).primaryColor,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
              itemCount: transaction.length,
            ),
    );
  }
}
