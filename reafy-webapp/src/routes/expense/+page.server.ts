import { SignJWT } from "jose";

const secret = new TextEncoder().encode('DetteErReafySecurityToken!!');
const alg = 'HS256';

const jwt = await new SignJWT({})
    .setProtectedHeader({ alg })
    .sign(secret);

/** @type {import('./$types').PageServerLoad} */
export async function load({ params }: { params: any }) {
    console.log(params)
    /* const response = await fetch('http://localhost:3000/api/establishment/login', {
         method: 'POST',
         mode: 'cors',
         headers: {
             Accept: 'application/json',
             'Content-Type': 'text/plain',
             Authorization: `Bearer ${jwt}`
         },
         body: JSON.stringify({
         })
     });
     return {
     };*/
}