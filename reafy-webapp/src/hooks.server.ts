import { SvelteKitAuth } from "@auth/sveltekit";
import Google from "@auth/core/providers/google";
import client_secret from '../client_secret.json';
import { redirect } from "@sveltejs/kit";
import { sequence } from "@sveltejs/kit/hooks";
import { SignJWT } from "jose";
import { base } from "./lib/api";


const secret = new TextEncoder().encode(process.env.USER_TOKEN);
const alg = 'HS256';

export const handle = sequence(
    SvelteKitAuth({
        providers: [Google({ clientId: client_secret.web.client_id, clientSecret: client_secret.web.client_secret })],
        secret: "test",
        callbacks: {
            signIn: async ({ profile }) => {
                const jwt = await new SignJWT({})
                    .setProtectedHeader({ alg })
                    .sign(secret);
                const response = await fetch(`${base}/establishment/login`, {
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
                profile!.userName = body?.userName
                profile!.establishmentId = body?.establishmentId
                profile!.establishmentName = body?.establishmentName

                return true
            },

            //@ts - ignore 
            session: async ({ session, token }) => {

                if (token && session.user) {
                    session.user.userId = token.userId;
                    session.user.userName = token.userName;
                    session.user.establishmentId = token.establishmentId;
                    session.user.establishmentName = token.establishmentName;
                }
                return session
            },
            jwt: async ({ user, token, profile }) => {
                if (user && profile) {
                    token.userId = profile.userId
                    token.userName = profile.userName
                    token.establishmentId = profile.establishmentId
                    token.establishmentName = profile.establishmentName
                }
                return token
            }
        }
    }),
    async function authorization({ event, resolve }) {
        // Protect any routes under /authenticated
        if (event.url.pathname != "/") {
            const session = await event.locals.getSession();
            if (!session) {
                throw redirect(303, "/");
            }
        }
        if (event.url.pathname == "/") {
            const session = await event.locals.getSession();
            if (session) {
                throw redirect(303, "/expense")
            }
        }

        // If the request is still here, just proceed as normally
        return resolve(event);
    }
);
