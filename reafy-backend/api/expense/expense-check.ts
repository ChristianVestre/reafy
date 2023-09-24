import { sql } from '@vercel/postgres';
import { PostExpenseCheck, PostExpenseTransaction } from '../../types/expenseTypes';
import { ruleChecker } from '../../rules/ruleChecker';
import { checkVatExemption } from '../../rules/universalChecks/checkVatExemption';
import { checkTeamWelfare } from '../../rules/universalChecks/checkTeamWelfare';

export const config = {
    runtime: 'edge',
};

export default async function expenseTransaction(
    request: Request
) {
    if (request.method == "POST") {
        try {
            let body: PostExpenseCheck = await request.json();

            const teamWelfare: boolean = await checkTeamWelfare({ expenseTemplateId: body.expenseTemplateId });
            if (teamWelfare) {
                return new Response(
                    JSON.stringify({
                        type: "Velferd"
                    }), { status: 200 }
                )
            }

            const vatExempt: boolean = await checkVatExemption({ expenseId: body.expenseId, expenseTemplateId: body.expenseTemplateId });
            if (vatExempt) {
                return new Response(
                    JSON.stringify({
                        type: "Fradragsberettiget representasjon"
                    }), { status: 200 }
                )
            }

            return new Response(
                JSON.stringify({
                    type: "Ikke fradragsberettiget representasjon"
                }), { status: 200 }
            )
        } catch (e) {
            console.log(e)
            return Response.error()
        }
    }
}