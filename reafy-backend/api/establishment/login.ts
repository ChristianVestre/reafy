import { sql } from '@vercel/postgres';
import { createIdentifier } from '../../helpers/helperFunctions';
import { User } from '../../types/authTypes';
import { EstablishmentLoginRequest } from '../../types/establishmentTypes';


export const config = {
    runtime: 'edge',
};


export default async function handler(
    request: Request,
) {
    let body: EstablishmentLoginRequest;
    try {
        body = await request.json();
    } catch (e) {
        body = null;
    }

    let user = await sql`
    SELECT json_build_object(
    'userName',u.establishment_user_name,
    'sub',u.establishment_user_sub,
    'userId',u.establishment_user_id,
    'establishmentName',et.establishment_name,
    'establishmentId', et.establishment_id)
    FROM establishment_user_table u
    INNER JOIN establishment_table et ON u.establishment_id = et.establishment_id
    WHERE u.establishment_user_name = ${body.userName};
    `

    if (user.rowCount == 0) {
        return new Response(
            JSON.stringify({ "error": "user not found" })
        )
    }

    //add sub if user has not logged in before
    if (user.rows[0].json_build_object.sub == null) {
        //todo implement adding the sub
        try {
            sql`UPDATE establishment_user_table SET establishment_user_sub = ${body.sub} WHERE establishment_user_name=${body.userName}`
        } catch (e) {
            console.log(e)
            return new Response(
                JSON.stringify({ "error": "an error has occured" })
            )
        }
        //if there is a sub, dont allow login if its not the same as the one coming with the request.
    } else if (user.rows[0].json_build_object.sub != body.sub) {
        return new Response(
            JSON.stringify({ "error": "establishment user is not recognised" })
        )
    }

    const data = {
        "userName": user.rows[0].json_build_object.userName,
        "userId": user.rows[0].json_build_object.userId,
        "userSub": user.rows[0].json_build_object.sub,
        "establishmentName": user.rows[0].json_build_object.establishmentName,
        "establishmentId": user.rows[0].json_build_object.establishmentId
    }

    return new Response(
        JSON.stringify(data)
    );
}