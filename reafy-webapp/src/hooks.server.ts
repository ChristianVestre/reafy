import { SvelteKitAuth } from "@auth/sveltekit";
import Google from "@auth/core/providers/google";
import client_secret from '../client_secret.json';
import GitHub from "@auth/core/providers/github";
import { redirect, type Handle } from "@sveltejs/kit";
import { sequence } from "@sveltejs/kit/hooks";
import { SignJWT } from "jose";
import type { EstablishmentUser } from "./types/user";

const secret = new TextEncoder().encode('DetteErReafySecurityToken!!');
const alg = 'HS256';

async function authorization({ event, resolve }) {
    // Protect any routes under /authenticated
    console.log(event.url)
    if (event.url.pathname != "/") {
        console.log("test what")
        const session = await event.locals.getSession();
        if (!session) {
            throw redirect(303, "/");
        }
    }

    // If the request is still here, just proceed as normally
    return resolve(event);
}

export const handle = sequence(
    SvelteKitAuth({
        providers: [Google({ clientId: client_secret.web.client_id, clientSecret: client_secret.web.client_secret })],
        secret: "test",
        callbacks: {
            signIn: async ({ profile }) => {
                const jwt = await new SignJWT({})
                    .setProtectedHeader({ alg })
                    .sign(secret);
                const response = await fetch('http://localhost:3000/api/establishment/login', {
                    method: 'POST',
                    mode: 'cors',
                    headers: {
                        Accept: 'application/json',
                        'Content-Type': 'text/plain',
                        Authorization: `Bearer ${jwt}`
                    },
                    body: JSON.stringify({
                        userName: profile?.name,
                        sub: profile?.sub
                    })
                });
                if (response.status != 200) {
                    return false
                }
                const body = await response.json()
                profile!.userId = body?.userId
                profile!.establishmentId = body?.establishmentId
                profile!.establishmentName = body?.establishmentName

                return true
            },
            redirect: async ({ url, baseUrl }) => {
                if (url.startsWith("/")) return `${baseUrl}${url}`
                // Allows callback URLs on the same origin
                else if (new URL(url).origin === baseUrl) return url
                return baseUrl
            },
            session: async ({ session, token }) => {
                if (!session) return;
                if (token && session.user) {
                    session.user.userId = token.userId;
                    session.user.name = token.name;
                    session.user.establishmentId = token.establishmentId;
                    session.user.establishmentName = token.establishmentName;
                }
                return session

            },
            jwt: async ({ user, token, profile }) => {
                if (user) {
                    token.userId = profile?.userId
                    token.name = profile?.name
                    token.establishmentId = profile?.establishmentId
                    token.establishmentName = profile?.establishmentName
                }
                return token
            }
        }
    }),
    authorization
);
