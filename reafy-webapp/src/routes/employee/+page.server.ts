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
    default: async ({ cookies, request, locals }) => {
        const formData = await request.formData()
        const companyId = cookies.get("companyId")
        const expenseId = cookies.get("expenseId")
        const liquor = cookies.get("liquor")
        const session = await locals.getSession()

        const userId = formData.get("userId")?.toString() ?? ""
        await post({
            path: "establishment/expense", data: {
                userId: userId,
                establishmentId: session?.user?.establishmentId,
                establishmentUserId: session?.user?.userId,
                companyId: companyId,
                expenseId: expenseId,
                liquor: liquor
            }
        })
        cookies.set('userId', userId);
        return { success: true };
    }
};