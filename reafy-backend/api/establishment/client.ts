import { sql } from '@vercel/postgres';
import { PostEstablishmentClient } from '../../types/establishmentTypes';


export const config = {
    runtime: 'edge',
};

export default async function client(
    request: Request,
) {
    if (request.method == "POST") {

        try {
            let body: PostEstablishmentClient = await request.json();

            let client = await sql`
                SELECT row_to_json(establishment_client_table) FROM establishment_client_table WHERE company_id = (${body!.companyId}) AND establishment_id = (${body!.establishmentId});
            `

            if (client.rowCount == 0) {
                client = await sql`
                INSERT INTO establishment_client_table (establishment_id, company_id) 
                VALUES (${body!.establishmentId},${body!.companyId} ) 
                RETURNING row_to_json(establishment_client_table);
            `}

            return new Response(JSON.stringify(
                client
            ));

        } catch (e) {
            console.log(e)
            return new Response(JSON.stringify(
                e
            ));
        }
    }
}