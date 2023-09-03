import type { DefaultSession, User, Profile } from "@auth/core/types";
import type { JWT } from '@auth/core/jwt'


declare module "@auth/core/types" {
    interface EstablishmentUser extends User {
        userId: number;
        userName: string;
        establishmentId: number;
        establishmentName: string;
    }
    interface Profile {
        userId: number;
        userName: string;
        establishmentId: number;
        establishmentName: string;
    }


    interface Session extends DefaultSession {
        user?: EstablishmentUser;
    }
}

declare module "@auth/core/jwt" {
    interface JWT {
        userId: number;
        userName: string;
        establishmentId: number;
        establishmentName: string;

    }
}
