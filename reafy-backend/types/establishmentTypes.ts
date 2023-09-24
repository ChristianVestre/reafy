export type PostEstablishment = {
    establishmentName: string
    orgNumber: number
    address: string
    contactEmail: string
} | null

export type PostEstablishmentUser = {
    userName: string
    establishmentName: string
    email: string
} | null

export type PostEstablishmentLogin = {
    userName: string
    sub: number
} | null

export type PostEstablishmentClient = {
    establishmentId: number
    companyId: number
} | null

export type PostQueueExpense = {
    establishmentUserId: number
    establishmentId: number
    expenseId: number
    companyId: number
    userId: number
    liquor: boolean
}