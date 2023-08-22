export type EstablishmentRequest = {
    establishmentName: string
    orgNumber: number
    address: string
    contactEmail: string
}

export type EstablishmentUserRequest = {
    userName: string
    establishmentName: string
    email: string
}

export type EstablishmentLoginRequest = {
    userName: string
    sub: number
}

export type EstablishmentAddClientRequest = {
    establishmentId: number
    companyId: number
}

export type GetEstablishmentClientsRequest = {
    establishmentId: number
}