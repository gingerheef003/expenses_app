import 'package:expenses_app/bar%20graph/bar_graph.dart';
import 'package:expenses_app/data/expense_data.dart';
import 'package:expenses_app/datetime/datetime_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfWeek;
  const ExpenseSummary({
    super.key,
    required this.startOfWeek,
  });

  double calculateMax(
    ExpenseData value,
    String sun,
    String mon,
    String tue,
    String wed,
    String thu,
    String fri,
    String sat,
  ) {
    double? max = 100;

    List<double> values = [
      value.calculateDailyExpenseSummary()[sun] ?? 0,
      value.calculateDailyExpenseSummary()[mon] ?? 0,
      value.calculateDailyExpenseSummary()[tue] ?? 0,
      value.calculateDailyExpenseSummary()[wed] ?? 0,
      value.calculateDailyExpenseSummary()[thu] ?? 0,
      value.calculateDailyExpenseSummary()[fri] ?? 0,
      value.calculateDailyExpenseSummary()[sat] ?? 0,
    ];

    values.sort();
    max = values.last * 1.1;

    return max == 0 ? 100 : max;
  }

   String calculateWeekTotal(
    ExpenseData value,
    String sun,
    String mon,
    String tue,
    String wed,
    String thu,
    String fri,
    String sat,
  ) {
     List<double> values = [
      value.calculateDailyExpenseSummary()[sun] ?? 0,
      value.calculateDailyExpenseSummary()[mon] ?? 0,
      value.calculateDailyExpenseSummary()[tue] ?? 0,
      value.calculateDailyExpenseSummary()[wed] ?? 0,
      value.calculateDailyExpenseSummary()[thu] ?? 0,
      value.calculateDailyExpenseSummary()[fri] ?? 0,
      value.calculateDailyExpenseSummary()[sat] ?? 0,
    ];

    double total = 0;

    for(int i = 0; i < 7; i++) {
      total += values[i];
    }

    return total.toStringAsFixed(2);
  }


  @override
  Widget build(BuildContext context) {

    String sun = convertDateTimeToString(startOfWeek.add(const Duration(days: 0)));
    String mon = convertDateTimeToString(startOfWeek.add(const Duration(days: 1)));
    String tue = convertDateTimeToString(startOfWeek.add(const Duration(days: 2)));
    String wed = convertDateTimeToString(startOfWeek.add(const Duration(days: 3)));
    String thu = convertDateTimeToString(startOfWeek.add(const Duration(days: 4)));
    String fri = convertDateTimeToString(startOfWeek.add(const Duration(days: 5)));
    String sat = convertDateTimeToString(startOfWeek.add(const Duration(days: 6)));
    
    return Consumer<ExpenseData>(
        builder: (context, value, child) => Column(
          children: [
            Padding(
              padding: EdgeInsets.all(25.0),
              child: Row(
                children: [
                  const Text('Weeks Total:', style: TextStyle(fontWeight: FontWeight.bold),),
                  Text('₹${calculateWeekTotal(value, sun, mon, tue, wed, thu, fri, sat)}')
                ],
              ),
            ),
            SizedBox(
                  height: 200,
                  child: MyBarGraph(
                      maxY: 100,
                      sunAmount: value.calculateDailyExpenseSummary()[sun] ?? 0,
                      monAmount: value.calculateDailyExpenseSummary()[mon] ?? 0,
                      tueAmount: value.calculateDailyExpenseSummary()[tue] ?? 0,
                      wedAmount: value.calculateDailyExpenseSummary()[thu] ?? 0,
                      thuAmount: value.calculateDailyExpenseSummary()[wed] ?? 0,
                      friAmount: value.calculateDailyExpenseSummary()[fri] ?? 0,
                      satAmount: value.calculateDailyExpenseSummary()[sat] ?? 0,),
                ),
          ],
        ));
  }
}
