import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  NewTransaction(
    this.addTx, {
    Key? key,
  }) : super(key: key) {
    print('NewTransaction Widget Constructor');
  }

  final Function addTx;

  @override
  State<NewTransaction> createState() {
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  _NewTransactionState() {}

  // String? titleInput;      <---- am shemtxvevashi final-s ver gavucert
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  DateTime? _selectedDate;

  void _submitData(BuildContext context) {
    if (_amountController.text.isEmpty) {
      return;
    }

    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate != null) {
        setState(() {
          _selectedDate = pickedDate;
        });
        print(_selectedDate);
      }
    });
    // showDateRangePicker(
    //   context: context,
    //   firstDate: DateTime.now(),
    //   lastDate: DateTime(2023),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            decoration: const InputDecoration(
              labelText: 'Title',
            ),
            // onChanged: (val) {
            //   titleInput = val;
            // },
            controller: _titleController,
            onSubmitted: (_) => _submitData(context),
          ),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Amount',
            ),
            // onChanged: (val) => amountInput = val,
            controller: _amountController,
            keyboardType:
                // TextInputType.numberWithOptions(signed: true, decimal: true),
                const TextInputType.numberWithOptions(signed: true),
            onSubmitted: (_) => _submitData(context),
            // onSubmitted: (str) {
            //   print(str);
            //   submitData();
            // },
          ),
          SizedBox(
            height: 70,
            child: Row(
              // if we remove Expanded around Text, we youse this method below.
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    _selectedDate == null
                        ? 'No Date Chosen!'
                        : 'Picked Date: ${DateFormat.yMd().format(_selectedDate!)}',
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () => _presentDatePicker(context),
                    child: const Text(
                      'Choose Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () => _submitData(context),
            child: const Text(
              'Add Transaction',
            ),
          ),
        ],
      ),
    );
  }
}
