import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
//
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }
    Navigator.of(context).pop();
    widget.addTx(
      enteredTitle,
      enteredAmount,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(14),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              keyboardType: TextInputType.text,
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              // onChanged: (val) => amountInput = val,
              controller: amountController,
              onSubmitted: (_) => submitData(),
            ),
            // ignore: deprecated_member_use
            FlatButton(
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 7),
                onPressed: submitData,
                color: Theme.of(context).primaryColor,
                child: Text(
                  'Add date',
                  style: TextStyle(color: Colors.white),
                )),
            // ignore: deprecated_member_use
            FlatButton(
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 7),
                onPressed: () {},
                color: Theme.of(context).primaryColor,
                child: Text(
                  'Delete data',
                  style: TextStyle(color: Colors.white),
                )),
          ],
        ),
      ),
    );
  }
}
