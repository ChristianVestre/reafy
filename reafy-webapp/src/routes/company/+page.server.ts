import { get } from '$lib/api'
import type { Actions } from '@sveltejs/kit'
import type { PageServerLoad } from '../$types'

export const load: PageServerLoad = async (event) => {
    const session = await event.locals.getSession()
    //@ts-ignore
    const companies = await get({ path: `establishment/clients?id=${session?.user?.establishmentId}` })
    return { companies: companies }
}


export const actions: Actions = {
    default: async ({ cookies, request }) => {
        const formData = await request.formData()
        console.log(formData)
        const companyId = formData.get("companyId")?.toString() ?? ""
        console.log(companyId)
        cookies.set('companyId', companyId);
        return { success: true };
    }
};