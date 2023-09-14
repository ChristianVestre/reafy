class LineItem {
  String? name;
  int? numberPurchased;
  int? costPerItem;

  LineItem({this.name, this.numberPurchased, this.costPerItem});

  LineItem.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    numberPurchased = json["numberPurchased"];
    costPerItem = json["costPerItem"];
  }
}

class Expense {
  int? totalExpense;
  int? expenseId;
  String? establishmentName;
  int? establishmentId;
  int? mva;
  List<LineItem>? lineItems;

  Expense(
      {this.totalExpense,
      this.expenseId,
      this.mva,
      this.lineItems,
      this.establishmentId,
      this.establishmentName});

  Expense.fromJson(Map<String, dynamic> json) {
    totalExpense = json['totalExpense'];
    expenseId = json['expenseId'];
    mva = json['mva'];
    establishmentName = json['establishmentName'];
    establishmentId = json['establishmentId'];
    lineItems = <LineItem>[];
    json['lineItems'].forEach((v) {
      lineItems!.add(LineItem.fromJson(v));
    });
  }
}
