import type { Actions } from "@sveltejs/kit";

export const actions: Actions = {
    default: async ({ cookies, request }) => {
        const formData = await request.formData()
        const licor = formData.get("licor")?.toString() ?? ""
        cookies.set('llicor', licor);
        return { success: true };
    }
};