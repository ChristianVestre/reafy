import { sql } from '@vercel/postgres';
import { PostExpenseTransaction } from '../../types/expenseTypes';
import { ruleChecker } from '../../rules/ruleChecker';

export const config = {
    runtime: 'edge',
};

export default async function expenseTransaction(
    request: Request
) {
    if (request.method == "POST") {
        try {
            let body: PostExpenseTransaction = await request.json();
            console.log(body);
            const rules = await sql`
                SELECT row_to_json(expense_rule_table) FROM expense_rule_table WHERE employee_role = ${body.role} and company_id = ${body.companyId} and active=true
            `
            let ruleResult;
            let failedFlag: boolean = false;
            const failedExplainations: string[] = [];

            const checks = await Promise.all(rules.rows.map(async (rule) => {
                console.log(rule)
                ruleResult = await ruleChecker({ ruleName: rule.row_to_json.rule_name, ruleData: rule.row_to_json.rule_data, userId: body.settledById, expenseId: body.expenseId, expenseTemplateId: body.expenseTemplateId })
                return {
                    result: ruleResult,
                    rejectionReason: rule.row_to_json.explaination
                }
            }))

            for (let check of checks) {
                if (check.result == false) {
                    failedFlag = true
                    failedExplainations.push(check.rejectionReason)
                }
            }

            if (failedFlag) {
                return new Response(
                    JSON.stringify({
                        paymentRejected: true,
                        rejectionReason: failedExplainations
                    }), { status: 200 }
                )
            }

            await sql`
            INSERT INTO expense_transaction_table (settled_by_id, settled_timestamp, expense_id, expense_template_id, company_id, establishment_id) 
            VALUES (${body.settledById}, now()::timestamp,${body.expenseId},${body.expenseTemplateId},${body.companyId},${body.establishmentId});
        `

            await sql`
                UPDATE expense_table
                SET active=false
                WHERE expense_id = ${body.expenseId};
            `

            await sql`
                UPDATE expense_queue_table
                SET queued=false
                WHERE expense_id = ${body.expenseId};
            `
            return new Response(
                JSON.stringify({
                    paymentRejected: false,
                    rejectionReason: [],
                }), { status: 200 }
            )
        } catch (e) {
            console.log(e)
            return Response.error()
        }
    }
}