import { sql } from '@vercel/postgres';
import { PostEstablishmentUser } from '../../types/establishmentTypes';


export const config = {
    runtime: 'edge',
};

export default async function user(
    request: Request,
) {
    if (request.method == "POST")
        try {

            const body: PostEstablishmentUser = await request.json();

            let establishment = await sql`
                SELECT row_to_json(establishment_table) FROM establishment_table WHERE establishment_name = (${body!.establishmentName});
            `

            if (establishment.rowCount == 0) {
                return new Response(JSON.stringify({
                    "error": "Please add an establishment with that name first."
                }));
            }

            const establishmentUser = await sql`
                INSERT INTO establishment_user_table
                (user_name, email, establishment_id)
                SELECT ${body!.userName}, ${body!.email}, ${establishment.rows[0]?.row_to_json?.establishment_id}
                WHERE
                    NOT EXISTS (
                        SELECT user_name FROM establishment_user_table WHERE user_name = ${body!.userName}
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