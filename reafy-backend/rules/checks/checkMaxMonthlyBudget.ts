import { sql } from '@vercel/postgres';
import { JSONObject } from '../../types/jsonTypes';
import { MaxMonthlyBudgetData } from "../../types/ruleTypes"


export const checkMaxMonthlyBudget = async ({ userId, ruleData }: { userId: number, ruleData: JSONObject }) => {

    const maxMonthlyBudgetData = ruleData as MaxMonthlyBudgetData

    const result = await sql`SELECT SUM(expense_table.total_expense) FROM expense_table
        INNER JOIN expense_transaction_table ON expense_transaction_table.expense_id = expense_table.expense_id
        INNER JOIN expense_template_table ON expense_template_table.created_by = expense_transaction_table.settled_by_id
        WHERE expense_template_table.created_by = ${userId}
        AND (date_part('month', (SELECT settled_timestamp))) = date_part('month', (now()))
        GROUP BY expense_template_table.created_by;
    `
    console.log(result.rows[0])



}