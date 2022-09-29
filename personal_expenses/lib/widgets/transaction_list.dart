import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import 'transaction_item.dart';

class TransactionList extends StatelessWidget {
  const TransactionList(
    this.transactions,
    this.deleteTx, {
    Key? key,
  }) : super(key: key);

  final List<Transaction> transactions;
  final Function deleteTx;

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: <Widget>[
                  Text(
                    'No transactions added yet!',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'lib/assets/images/waiting.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              );
            },
          )
        : ListView(
            children: transactions
                .map(
                  (tx) => TransactionItem(
                    key: ValueKey(tx.id),
                    transaction: tx,
                    deleteTx: deleteTx,
                  ),
                )
                .toList(),
          );

    // ----- ListView.builder-tan ValueKey ar mushaobs.

    // ListView.builder(
    //     itemCount: transactions.length,
    //     itemBuilder: (ctx, index) {
    //       return TransactionItem(
    //         transaction: transactions[index],
    //         deleteTx: deleteTx,
    //       );

    //       //-------- Another way:
    //       // return Card(
    //       //   child: Row(
    //       //     children: [
    //       //       Container(
    //       //         margin: const EdgeInsets.symmetric(
    //       //           horizontal: 15,
    //       //           vertical: 10,
    //       //         ),
    //       //         padding: const EdgeInsets.all(10),
    //       //         decoration: BoxDecoration(
    //       //           border: Border.all(
    //       //             color: Theme.of(context).primaryColor,
    //       //             width: 2,
    //       //           ),
    //       //         ),
    //       //         child: Text(
    //       //           '\$${transactions[index].amount.toStringAsFixed(2)}',
    //       //           style: Theme.of(context).textTheme.headline1,
    //       //         ),
    //       //       ),
    //       //       Column(
    //       //         crossAxisAlignment: CrossAxisAlignment.start,
    //       //         children: [
    //       //           Text(
    //       //             transactions[index].title,
    //       //             style: Theme.of(context).textTheme.bodyText1,
    //       //           ),
    //       //           Text(
    //       //             // '${tx.date.year}/${tx.date.month}/${tx.date.day}',
    //       //             // DateFormat('yyyy-MM-dd').format(tx.date),
    //       //             DateFormat.yMMMd().format(transactions[index].date),
    //       //             style: Theme.of(context).textTheme.bodyText2,
    //       //           ),
    //       //         ],
    //       //       ),
    //       //     ],
    //       //   ),
    //       // );
    //     },
    //   );
  }
}
