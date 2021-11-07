import 'package:flutter/material.dart';
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
          primarySwatch: Colors.blue,
          accentColor: Colors.purple,
          fontFamily: 'OpenSans'),
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

  //Boshqa Classdan "txtTitle" va "txtAmount" miqdorini qabul qilish
  void _addNewTransaction(String txtTitle, double txtAmount) {
    final newTx = Product(
        id: 'null', title: txtTitle, amount: txtAmount, date: DateTime.now());

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //1.TransactionListni ishga tushurish
            //2.TransactionLIstga LISTni yani _serTransactionni yuborish
            TransactionList(_userTransaction),
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
