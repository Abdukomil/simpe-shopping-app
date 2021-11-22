import 'package:flutter/material.dart';
import 'package:json_test1/widgets/chart.dart';
import 'models/product.dart';
import 'package:json_test1/widgets/new_tansaction.dart';
import 'widgets/transaction_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'myApp',
      theme: ThemeData(
          fontFamily: 'OpenSans',
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
              .copyWith(secondary: Colors.purple)),
      home: Grade(),
    );
  }
}

// ignore: must_be_immutable
class Grade extends StatefulWidget {
  @override
  _GradeState createState() => _GradeState();
}

class _GradeState extends State<Grade> {
  //Product listini yaratish
  final List<Product> _userTransaction = [];
// List<Product> get newMethod => _recentTransactions;
// }

  // ignore: unused_element
  List<Product> get _recentTransactions {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  //Boshqa Classdan "txtTitle" va "txtAmount" miqdorini qabul qilish
  void _addNewTransaction(
      String txtTitle, double txtAmount, DateTime choosenDate) {
    final newTx = Product(
        id: DateTime.now().toString(),
        title: txtTitle,
        amount: txtAmount,
        date: choosenDate);
    print(choosenDate);
    //Qabul qilingan miqdorni darxol yaratilgan Listga saqlash
    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _starAddNewTransaction(BuildContext ctx) {
    //Oyna chiqarib beruvchi Function
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          //1.NewTransaction Clasini ishga tushurish
          //2._addNewTransaction 매개 변수  orqalik "undan" Nom va Narxni olib keladi
          //3. va _addNewTransaction ishga tushib Listga malumotni qo'shadi
          return NewTransaction(_addNewTransaction);
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((element) => element.id == id);
    });
  }

  bool _showChart = false;

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(
        'Online Shop',
        style: TextStyle(fontFamily: 'Open Sans'),
      ),
      centerTitle: true,
      actions: [
        IconButton(
            onPressed: () => _starAddNewTransaction(context),
            icon: Icon(Icons.add))
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Switch(
                  value: _showChart,
                  onChanged: (val) {
                    setState(() {
                      _showChart = val;
                    });
                  },
                ),
                Text("Show Chart")
              ],
            ),
            _showChart
                ? Container(
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height) *
                        0.3,
                    child: Chart())
                //1.TransactionListni ishga tushurish
                //2.TransactionLIstga LISTni yani _serTransactionni yuborish
                : Container(
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height) *
                        0.6,
                    child: TransactionList(
                        _userTransaction, _deleteTransaction, _showChart)),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _starAddNewTransaction(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
