import { sql } from '@vercel/postgres';
import { createIdentifier } from '../../helpers/helperFunctions';
import { EstablishmentUserRequest } from '../../types/establishmentTypes';


export const config = {
    runtime: 'edge',
};

export default async function handler(
    request: Request,
) {
    let body: EstablishmentUserRequest;
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
            return new Response(JSON.stringify({
                "error": "Please add an establishment with that name first."
            }));
        }
        console.log(establishment)
        const establishmentUser = await sql`
            INSERT INTO establishment_user_table
            (establishment_user_name, establishment_user_email, establishment_id)
            SELECT ${body.userName}, ${body.email}, ${establishment.rows[0]?.row_to_json?.establishment_id}
            WHERE
                NOT EXISTS (
                    SELECT establishment_user_name FROM establishment_user_table WHERE establishment_user_name = ${body.userName}
                )
            RETURNING row_to_json(establishment_user_table);
        `
        return new Response(JSON.stringify(
            establishmentUser
        ));
    } catch (e) {
        console.log(e)
        return new Response(JSON.stringify(
            e
        ));
    }

}

/*
        const establishmentUser = await sql`
            INSERT INTO establishment_user_table
            (establishment_user_name, establishment_user_email, establishment_id)
            SELECT ${body.userName}, ${body.email}, ${body.email}, ${establishment.rows[0]?.row_to_json?.establishemnt_id}
            WHERE
                NOT EXISTS (
                    SELECT establishment_user_name FROM establishment_user_table WHERE establishment_user_name = ${body.userName}
                )
            RETURNING row_to_json(establishment_user_table);
        `
*/