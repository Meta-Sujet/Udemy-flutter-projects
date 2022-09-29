import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/widgets/chart_bar.dart';

import '../models/transaction.dart';

class Chart extends StatelessWidget {
  const Chart({
    Key? key,
    required this.recentTransactions,
  }) : super(key: key);

  final List<Transaction> recentTransactions;

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      final weekDays = DateTime.now().subtract(
        Duration(days: (DateTime.now().weekday - 1) - index),
      );

      double totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return {
        // 'day': DateFormat.E().format(weekDay),
        'day': DateFormat.E().format(weekDays).substring(0, 1),
        'amount': totalSum,
      };
    });
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (previousValue, element) {
      return previousValue += element['amount'] as double;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(DateTime.now().weekday);
    // print(groupedTransactionValues);
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: groupedTransactionValues
              .map(
                // Expanded == Flexible(fit: FlexFit.tight).
                (data) => Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                    label: data['day'] as String,
                    spendingAmount: data['amount'] as double,
                    spendingPctOfTotal: totalSpending == 0.0
                        ? 0.0
                        : (data['amount'] as double) / totalSpending,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

// abstract class Tst {
//   String get name;
// }

// class bla implements Tst {
//   String name = 'asd';
// }