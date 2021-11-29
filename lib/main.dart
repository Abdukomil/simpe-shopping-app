import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:json_test1/widgets/chart.dart';
import 'models/product.dart';
import 'dart:io';
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
      debugShowCheckedModeBanner: false,
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
    final isLandscope =
        MediaQuery.of(context).orientation == Orientation.portrait;

    final PreferredSizeWidget isIOSAppBar = CupertinoNavigationBar(
      middle: Text("GIFT BOX"),
      trailing: Row(
        children: [
          GestureDetector(
            child: Icon(CupertinoIcons.add),
            onTap: () => _starAddNewTransaction(context),
          )
        ],
      ),
    );
    final PreferredSizeWidget isAndroidAppBar = AppBar(
      title: Text(
        'GIFT BOX',
        style: TextStyle(fontFamily: 'Open Sans'),
      ),
      centerTitle: true,
      actions: [
        IconButton(
            onPressed: () {
              _starAddNewTransaction(context);
              print(isLandscope);
              print(MediaQuery.of(context).size.height);
              print(MediaQuery.of(context).size.width);
            },
            icon: Icon(Icons.add))
      ],
    );
    final appBar = Platform.isIOS ? isIOSAppBar : isAndroidAppBar;
    final txListWidget = Container(
        height:
            (MediaQuery.of(context).size.height - appBar.preferredSize.height) *
                0.6,
        child:
            TransactionList(_userTransaction, _deleteTransaction, _showChart));
    final chartWidget = Container(
        height:
            (MediaQuery.of(context).size.height - appBar.preferredSize.height) *
                0.3,
        child: Chart());
    final switchWidget = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Show Chart",
          style: Theme.of(context).textTheme.subtitle1,
        ),
        Switch.adaptive(
          // ignore: deprecated_member_use
          activeColor: Theme.of(context).accentColor,
          value: _showChart,
          onChanged: (val) {
            setState(() {
              _showChart = val;
            });
          },
        )
      ],
    );
    final bodyPage = SafeArea(
        child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (isLandscope) chartWidget,
          if (!isLandscope) switchWidget,
          if (_showChart) chartWidget,
          txListWidget
        ],
      ),
    ));

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: bodyPage,
            navigationBar: CupertinoNavigationBar(
              middle: Text('GIFT BOX'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    child: Icon(CupertinoIcons.add),
                    onTap: () => _starAddNewTransaction(context),
                  )
                ],
              ),
            ))
        : Scaffold(
            appBar: appBar,
            body: bodyPage,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () => _starAddNewTransaction(context),
                    child: Icon(Icons.add),
                  ),
          );
  }
}
