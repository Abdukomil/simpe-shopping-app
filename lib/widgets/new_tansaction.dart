import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
//
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
    if (_amountController.text.isEmpty) {
      return;
    }
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    Navigator.of(context).pop();
    widget.addTx(enteredTitle, enteredAmount, _selectedDate);
  }

  void _presentDatePiker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
    print('....');
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
              controller: _titleController,
              keyboardType: TextInputType.text,
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              // onChanged: (val) => amountInput = val,
              controller: _amountController,
              onSubmitted: (_) => _submitData(),
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(_selectedDate == null
                        ? 'No date shoosen!'
                        : 'Picked date: ${DateFormat.yMd().format(_selectedDate!)}'),
                  ),
                  // ignore: deprecated_member_use
                  FlatButton(
                      onPressed: _presentDatePiker,
                      textColor: Theme.of(context).primaryColor,
                      child: Text(
                        'Choose Date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ),

            // ignore: deprecated_member_use
            RaisedButton(
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 7),
                onPressed: _submitData,
                color: Theme.of(context).primaryColor,
                child: Text(
                  'Add product',
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
