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
}

export type AddCompanyRequest = {
    companyName: string
    contactEmail: string
    orgNumber: string
}

export type AddUserRequest = {
    userName: string
    email: string
    companyName: string
    companyRole: string
    relation: string
}