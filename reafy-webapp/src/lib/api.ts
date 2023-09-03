import { error } from '@sveltejs/kit';
import { SignJWT } from 'jose';

const secret = new TextEncoder().encode('DetteErReafySecurityToken!!');
const alg = 'HS256';


const token = await new SignJWT({})
    .setProtectedHeader({ alg })
    .sign(secret);

const base: string = 'http://localhost:3000/api'

async function send({ method, path, data }: ({ method: string, path: string, data?: any, token: string })) {
    const opts: {
        method: string, headers: { "Content-Type"?: string, "Authorization"?: string, "Accept"?: string }, body?: any
    } = { method, headers: {} };
    console.log(token)
    if (data) {
        opts.headers['Content-Type'] = 'application/json';
        opts.headers['Accept'] = 'application/json',

            opts.body = JSON.stringify(data);
    }

    if (token) {
        opts.headers['Authorization'] = `Bearer ${token}`;
    }

    try {
        const res = await fetch(`${base}/${path}`, opts);


        if (res.ok || res.status === 422) {
            const text = await res.text();
            return text ? JSON.parse(text) : {};
        }

        throw error(res.status);
    }
    catch (e) {
        console.log(e)
    }
}

export function get({ path }: { path: string }) {
    return send({ method: 'GET', path, token });
}

export function del({ path }: { path: string }) {
    return send({ method: 'DELETE', path, token });
}

export function post({ path, data }: { path: string, data: Object }) {
    return send({ method: 'POST', path, data, token });
}

export function put({ path, data }: { path: string, data: any }) {
    return send({ method: 'PUT', path, data, token });
}
