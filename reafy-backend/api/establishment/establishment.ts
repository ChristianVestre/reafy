import { sql } from '@vercel/postgres';
import { PostEstablishment } from '../../types/establishmentTypes';

export const config = {
    runtime: 'edge',
};

export default async function establishment(
    request: Request,
) {
    if (request.method === 'OPTIONS') {
        return new Response(JSON.stringify({ "status": "ok" }))

    }
    if (request.method == "POST") {
        try {
            let body: PostEstablishment = await request.json();

            let establishment = await sql`
                SELECT row_to_json(establishment_table) FROM establishment_table WHERE establishment_name = (${body!.establishmentName});
            `

            if (establishment.rowCount == 0) {
                establishment = await sql`
                INSERT INTO establishment_table (establishment_name, org_number, address, contact_email) 
                VALUES (${body!.establishmentName},${body!.orgNumber}, ${body!.address}, ${body!.contactEmail} ) 
                RETURNING row_to_json(establishment_table);
            `
            }

            return new Response(JSON.stringify(
                establishment
            ));

        } catch (e) {
            console.log(e)
            return new Response(JSON.stringify(
                e
            ));
        }
    }
}