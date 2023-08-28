import { JSONArray } from "./jsonTypes"

export type Participant = {
    participantId: number | null,
    participantName: string,
    companyName: string,
    relation: string | null
} | null

export type ParticipantRequest = {
    participantName: string
    companyName: string
    relation: string
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
} | null

export type ExpenseLineItem = {
    name: string
    numberPurchased: number
    costPerItem: number
    expenseId: number
} | null