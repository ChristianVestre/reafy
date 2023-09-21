import { JSONObject } from '../types/jsonTypes';
import { checkMaxTransaction } from './policyChecks/checkMaxTransaction';
import { checkMaxMonthlyBudget } from './policyChecks/checkMaxMonthlyBudget';
import { checkMinParticipants } from './policyChecks/checkMinParticipants';


export const ruleChecker = async ({ ruleName, ruleData, userId, expenseId, expenseTemplateId }: { ruleName: string, ruleData: JSONObject, userId: number, expenseId: number, expenseTemplateId: number }) => {
    console.log(ruleName)
    switch (ruleName) {
        case "Max transaction":
            return await checkMaxTransaction(ruleData, userId, expenseId)
        case "Max monthly budget":
            return await checkMaxMonthlyBudget({ ruleData: ruleData, userId: userId })
        case "Min participants":
            return await checkMinParticipants({ ruleData: ruleData, expenseTemplateId: expenseTemplateId })

    }

}

