import { JSONObject } from "./jsonTypes"

export type PostRules = {
    ruleName: string
    ruleData: string
    companyId: number
    explaination: string
    role: string
    userId: number
}

export type MaxTransaction = {
    maxValue: number
}

export type MaxMonthlyBudgetData = {
    maxValue: number
}

export type MinParticipantsData = {
    minParticipants: number
}

export type ExpenseTemplateData = {
    participants: Participant[]
}

export type Participant = {
    participantName: string
    participantId: number
    relation: string
}