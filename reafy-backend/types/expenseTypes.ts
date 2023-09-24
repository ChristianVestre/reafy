import { JSONArray } from "./jsonTypes"

export type Participant = {
    participantId: number | null,
    participantName: string,
    companyId: string,
    relation: string | null
} | null

export type PostParticipant = {
    participantName: string
    companyName: string
    relation: string
    ownerCompanyId: number
} | null

export type PostCompany = {
    companyName: string
    contactEmail: string
    orgNumber: string
} | null

export type PostUser = {
    userName: string
    email: string
    companyName: string
    companyRole: string
    relation: string
} | null
export type PostUsers = PostUser[] | null

export type PostExpense = {
    establishmentId: number
    expenseIntent: string
    expenseType: string
    settledBy: string
    expenseTimestamp: string
    totalExpense: number
    active: boolean
    tip: number
    currency: string
    lineItems: JSONArray
    vat: number
} | null

export type ExpenseLineItem = {
    name: string
    numberPurchased: number
    costPerItem: number
    expenseId: number
} | null

export type PostExpenseTemplate = {
    expenseIntent: string
    expenseType: string
    createdBy: string //user id
    participants: JSONArray
}

export type PostExpenseTransaction = {
    settledById: number
    establishmentUserId: number
    expenseId: number
    expenseTemplateId: number
    companyId: number
    type: string
    role: string
    establishmentId: number
}

export type PostExpenseCheck = {
    expenseId: number,
    expenseTemplateId: number
}