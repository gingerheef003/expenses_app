import 'package:expenses_app/models/expense_item.dart';
import 'package:hive/hive.dart';

class HiveDatabase {

  final _myBox = Hive.box('expense_db');

  void saveData(List<ExpenseItem> allExpense) {
    List<List<dynamic>> allExpenseFormatted = [];

    for(var expense in allExpense) {
      List<dynamic> expenseFormatted = [
        expense.name,
        expense.amount,
        expense.dateTime,
      ];
      allExpenseFormatted.add(expenseFormatted);
    }

    _myBox.put('ALL_EXPENSES', allExpenseFormatted);
  }

  List<ExpenseItem> readData() {
    List allExpenseFormatted = _myBox.get('ALL_EXPENSES') ?? [];

    List<ExpenseItem> allExpense = [];

    for(int i = 0; i < allExpenseFormatted.length; i++) {
      ExpenseItem expense = ExpenseItem(name: allExpenseFormatted[i][0], amount: allExpenseFormatted[i][1], dateTime: allExpenseFormatted[i][2]);
      allExpense.add(expense);
    }
    
    return allExpense;

  }
}