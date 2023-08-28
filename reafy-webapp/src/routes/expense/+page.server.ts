import { get, post } from '$lib/api'
import { fail, redirect } from '@sveltejs/kit'
import type { Actions, PageServerLoad } from '../$types'

export const load: PageServerLoad = async (event) => {
    const session = await event.locals.getSession()
    //@ts-ignore
    const establishmentId = session?.user?.establishmentId
    const expenses = await get({ path: `expense/expense?id=${establishmentId}` })
    //@ts-ignore
    return { ...expenses, "establishmentName": session?.user?.establishmentName }
}

export const actions: Actions = {
    default: async ({ cookies, request }) => {
        const formData = await request.formData()
        const expenseId = formData.get("expenseId")?.toString() ?? ""
        cookies.set('expenseId', expenseId);
        return { success: true };
        /*    const data = await request.formData();
    
            const body = await post({
                path: 'establishment/login', data: {
                    user: {
                        email: data.get('email'),
                        password: data.get('password')
                    }
                }
            });
            
            if (body.errors) {
                return fail(401, body);
            }
    
            const value = btoa(JSON.stringify(body.user));
            cookies.set('jwt', value, { path: '/' });
    
            throw redirect(307, '/');*/
    }
};