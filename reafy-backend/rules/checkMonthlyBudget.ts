import { sql } from '@vercel/postgres';

export const checkMonthlyBudget = (userId: number) => {

    const result = sql`SUM (expense_table.net_expense) FROM expense_table
    where date_part('month', (SELECT current_timestamp)) expense_template_table.created_by=${userId}
    LEFT_JOIN expense_template_table ON
    GROUP_BY expense_template_table.created_by 
    `






}