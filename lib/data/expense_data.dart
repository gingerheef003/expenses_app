import 'package:expenses_app/data/hive_database.dart';
import 'package:expenses_app/datetime/datetime_helper.dart';
import 'package:expenses_app/models/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseData extends ChangeNotifier{
  List<ExpenseItem> overallExpenseList = [];

  List<ExpenseItem> getAllExpenseList() {
    return overallExpenseList;
  }

  final db = HiveDatabase();
  void prepareData() {
    if(db.readData().isNotEmpty) {
      overallExpenseList = db.readData();
    }
  }

  void addNewExpense(ExpenseItem newExpense) {
    overallExpenseList.add(newExpense);
    notifyListeners();
    db.saveData(overallExpenseList);
  }

  void deleteExpense(ExpenseItem  expense) {
    overallExpenseList.remove(expense);
    notifyListeners();
    db.saveData(overallExpenseList);
  }

  String getDayName(DateTime dateTime) {
    switch(dateTime.weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  DateTime startOfWeekDate() {
    DateTime today = DateTime.now();
    DateTime startOfWeek  = today.subtract(Duration(days: today.weekday%7));

    return startOfWeek;
  }

  Map<String,double> calculateDailyExpenseSummary() {
    Map<String,double> dailyExpenseSummary = {};

    for(var expense in overallExpenseList) {
      String date = convertDateTimeToString(expense.dateTime);
      double amount = double.parse(expense.amount);

      if(dailyExpenseSummary.containsKey(date)) {
        double currentAmount = dailyExpenseSummary[date]!;
        currentAmount += amount;
        dailyExpenseSummary[date] = currentAmount;
      } else {
        dailyExpenseSummary.addAll({date: amount});
      }
    }

    return dailyExpenseSummary;
  }
  
}