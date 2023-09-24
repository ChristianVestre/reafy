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
  int? vat;
  bool? liquor;
  List<LineItem>? lineItems;

  Expense(
      {this.totalExpense,
      this.expenseId,
      this.vat,
      this.liquor,
      this.lineItems,
      this.establishmentId,
      this.establishmentName});

  Expense.fromJson(Map<String, dynamic> json) {
    print(json);
    totalExpense = json['totalExpense'];
    expenseId = json['expenseId'];
    vat = json['vat'];
    liquor = json['liquor'];
    establishmentName = json['establishmentName'];
    establishmentId = json['establishmentId'];
    lineItems = <LineItem>[];
    json['lineItems'].forEach((v) {
      lineItems!.add(LineItem.fromJson(v));
    });
  }
}
