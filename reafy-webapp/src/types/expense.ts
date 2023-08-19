export type ExpenseLineItem = {
    name: string;
    number: number;
    pricePerItem: number;
}

export type ExpenseData = {
    lineItems: ExpenseLineItem[];
    totalCost: number;
    mva: number;
}