import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  NewTransaction(this.addTransaction, {Key key}) : super(key: key);

  final Function addTransaction;

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleControler = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;
  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }

    final enteredTitle = _titleControler.text;
    final enteredAmout = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmout <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTransaction(enteredTitle, enteredAmout, _selectedDate);
    Navigator.of(context).pop();
  }

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            decoration: InputDecoration(labelText: 'Title'),
            controller: _titleControler,
            onSubmitted: (_) => _submitData(),
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Amount'),
            controller: _amountController,
            keyboardType: TextInputType.number,
            onSubmitted: (_) => _submitData(),
          ),
          Container(
            height: 70,
            child: Row(
              children: [
                Expanded(
                  child: Text(_selectedDate == null
                      ? 'No date choosen'
                      : DateFormat.yMd().format(_selectedDate)),
                ),
                TextButton(
                    onPressed: _showDatePicker,
                    child: Text('Choose date'),
                    style: TextButton.styleFrom(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.purple)))
              ],
            ),
          ),
          ElevatedButton(
            onPressed: _submitData,
            child: Text("Add transaction"),
            style: ElevatedButton.styleFrom(primary: Colors.purple),
          )
        ],
      ),
    ));
  }
}
