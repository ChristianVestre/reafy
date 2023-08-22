import { sql } from '@vercel/postgres';
import { EstablishmentRequest } from '../../types/establishmentTypes';


export const config = {
    runtime: 'edge',
};

export default async function handler(
    request: Request,
) {
    let body: EstablishmentRequest;
    try {
        body = await request.json();
    } catch (e) {
        body = null;
    }
    try {
        let establishment = await sql`
        SELECT row_to_json(establishment_table) FROM establishment_table WHERE establishment_name = (${body.establishmentName});
        `

        if (establishment.rowCount == 0) {
            establishment = await sql`
                INSERT INTO establishment_table (establishment_name, org_number, address, contact_email) 
                VALUES (${body.establishmentName},${body.orgNumber}, ${body.address}, ${body.contactEmail} ) 
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