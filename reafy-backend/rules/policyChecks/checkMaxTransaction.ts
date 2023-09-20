import { sql } from "@vercel/postgres"
import type { JSONObject } from "../../types/jsonTypes"
import { MaxTransaction } from "../../types/ruleTypes"

export const checkMaxTransaction = async (rule_data: JSONObject, userId: number, total_cost: number) => {
    const maxTransactionData = rule_data as MaxTransaction

    if (maxTransactionData.maxValue < total_cost) {
        return true
    }

    return false
}