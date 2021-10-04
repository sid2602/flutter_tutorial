import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/transactions.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  TransactionList(this.userTransactions);

  final List<Transaction> userTransactions;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: userTransactions.isEmpty
            ? Column(
                children: [
                  Text('No transactions added yet'),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 200,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              )
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                  width: 2)),
                          padding: EdgeInsets.all(10),
                          child: Text(
                            '\$' +
                                userTransactions[index]
                                    .amount
                                    .toStringAsFixed(2),
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userTransactions[index].title,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              DateFormat.yMd()
                                  .format(userTransactions[index].date),
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
                itemCount: userTransactions.length));
  }
}
