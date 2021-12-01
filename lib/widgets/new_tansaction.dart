import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//import 'adaptive_flat_button.dart';
import 'dart:io';
//import 'package:json_test1/widgets/adaptive_flat_button.dart';

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
        child: MediaQuery.of(context).orientation == Orientation.landscape
            ? Container(
                //if landscope....
                padding: EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                    bottom: MediaQuery.of(context).viewInsets.bottom + 10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
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
                                padding: EdgeInsets.symmetric(
                                    horizontal: 100, vertical: 7),
                                onPressed: _submitData,
                                color: Theme.of(context).primaryColor,
                                child: Text(
                                  'Add product',
                                  style: TextStyle(color: Colors.white),
                                )),

                            // ignore: deprecated_member_use
                            FlatButton(
                                onPressed: _presentDatePiker,
                                textColor: Theme.of(context).primaryColor,
                                child: Text(
                                  'Choose Date',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                          ],
                        ),
                      ),
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
                    ],
                  ),
                ),
              )
            : Container(
                padding: EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                    bottom: MediaQuery.of(context).viewInsets.bottom + 10),
                child: SingleChildScrollView(
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
                            Platform.isIOS
                                ? CupertinoButton(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(50),
                                    onPressed: _presentDatePiker,
                                    child: Text(
                                      'Choose Date',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ))
                                // ignore: deprecated_member_use
                                : FlatButton(
                                    onPressed: _presentDatePiker,
                                    textColor: Theme.of(context).primaryColor,
                                    child: Text(
                                      'Ch Date',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ))
                            //AdaptiveFlatButton('choose date', _presentDatePiker)
                          ],
                        ),
                      ),

                      // ignore: deprecated_member_use
                      RaisedButton(
                          padding: EdgeInsets.symmetric(
                              horizontal: 100, vertical: 7),
                          onPressed: _submitData,
                          color: Theme.of(context).primaryColor,
                          child: Text(
                            'Add product',
                            style: TextStyle(color: Colors.white),
                          )),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      )
                    ],
                  ),
                ),
              ));
  }
}
