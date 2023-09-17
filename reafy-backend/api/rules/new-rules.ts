import { sql } from '@vercel/postgres';
import { PostRules } from '../../types/ruleTypes';

export const config = {
    runtime: 'edge',
};

export default async function newRules(
    request: Request,
) {
    if (request.method == "POST") {
        try {
            let body: PostRules[] = await request.json();
            let result;
            await Promise.all(body.map(async (rule) => {
                result = await sql`
                    INSERT INTO expense_rule_table (rule_name, employee_role, company_id, rule_data, explaination, created_by, active)
                    VALUES (${rule.ruleName},${rule.role},${rule.companyId},${rule.ruleData},${rule.explaination},${rule.userId},true);
                `
            }))


            return new Response(JSON.stringify(
                result
            ));
        } catch (e) {
            console.log(e)
            return Response.error()
        }
    }
}