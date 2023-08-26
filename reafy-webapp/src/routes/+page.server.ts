import { fail, redirect, type Actions } from '@sveltejs/kit';
import * as api from '$lib/api.js';
import type { PageServerLoad } from './$types';
import { signIn } from 'svelte-google-auth/client';

/** @type {import('./$types').PageServerLoad} */
export const load: PageServerLoad = ({ locals }) => {
    console.log("test", locals)

}

export const actions: Actions = {
    default: async ({ cookies, request }) => {
        console.log(request)
        const data = await request.formData();

        const body = await api.post({
            path: 'establishment/login', data: {
                user: {
                    email: data.get('email'),
                    password: data.get('password')
                }
            }
        });
        console.log(body)
        if (body.errors) {
            return fail(401, body);
        }

        const value = btoa(JSON.stringify(body.user));
        cookies.set('jwt', value, { path: '/' });

        throw redirect(307, '/');
    }
};