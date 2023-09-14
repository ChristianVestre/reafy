import { get, post } from '$lib/api'
import { fail, redirect } from '@sveltejs/kit'
import type { Actions, PageServerLoad } from '../$types'

export const load: PageServerLoad = async (event) => {
    const session = await event.locals.getSession()
    //@ts-ignore
    const establishmentId = session?.user?.establishmentId
    const expenses = await get({ path: `establishment/expense?id=${establishmentId}` })
    //@ts-ignore
    return { ...expenses, "establishmentName": session?.user?.establishmentName }
}

export const actions: Actions = {
    default: async ({ cookies, request }) => {
        const formData = await request.formData()
        const expenseId = formData.get("expenseId")?.toString() ?? ""
        console.log(expenseId)
        cookies.set('expenseId', expenseId);
        return { success: true };
    }
};