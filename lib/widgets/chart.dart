import 'package:flutter/material.dart';
import 'package:json_test1/models/product.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Product> recentTransactions;
  Chart(this.recentTransactions);

  List<Map<String, Object>> get grupedTransactionValued {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.weekday == weekDay.weekday &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return {'day': DateFormat.E(weekDay), 'amount': totalSum};
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 9,
      margin: EdgeInsets.all(20),
      child: Row(),
    );
  }
}
