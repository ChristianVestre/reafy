import NextAuth, { DefaultSession, User } from "next-auth";


declare module "next-auth" {
    interface EstablishmentUser extends User {
        userId?: number;
        establishmentId?: number;
        establishmentName: string;
    }

    interface Session extends DefaultSession {
        user?: EstablishmentUser;
    }
}

declare module "next-auth/jwt" {
    interface JWT {
        role?: Role;
        subscribed: boolean;
    }
}

declare module "auth" {
    interface EstablishmentUser extends User {
        userId?: number;
        establishmentId?: number;
        establishmentName: string;
    }

    interface Session extends DefaultSession {
        user?: EstablishmentUser;
    }
}
