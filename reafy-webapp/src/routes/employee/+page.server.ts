import { get, post } from '$lib/api'
import { fail, redirect } from '@sveltejs/kit'
import type { Actions, PageServerLoad } from '../$types'
import { getContext } from 'svelte'

export const load: PageServerLoad = async (event) => {
    const session = await event.locals.getSession()
    const companyId = await event.cookies.get("companyId")
    const employees = await get({ path: `users?id=${companyId}` })
    return { employees: employees, session: session }
}


export const actions: Actions = {
    default: async ({ cookies, request }) => {
        const formData = await request.formData()
        console.log(formData)
        const userId = formData.get("userId")?.toString() ?? ""
        cookies.set('userId', userId);
        return { success: true };
    }
};