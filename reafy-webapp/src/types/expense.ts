export type ExpenseLineItem = {
    name: string;
    numberPurchased: number;
    costPerItem: number;
}

export type ExpenseData = {
    expenseId: number
    lineItems: ExpenseLineItem[];
    totalExpense: number;
    establishmentName: string;
    mva: number;
}

export type ExpenseProcess = {
    expenseId: number | null
    settledBy: number | null
}