import type { PageServerLoad } from '../$types'


export const load: PageServerLoad = async (event) => {
    const session = await event.locals.getSession()
    const expenseId = await event.cookies.get("expenseId")
    return { expenseId: expenseId, session: session }
}
