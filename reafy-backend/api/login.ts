import { sql } from '@vercel/postgres';
import { User } from '../types/authTypes';
import { createIdentifier } from '../helpers/helperFunctions';

export const config = {
    runtime: 'edge',
};


export default async function login(
    request: Request,
) {
    if (request.method == "POST") {
        let body: User;
        try {
            body = await request.json();
        } catch (e) {
            body = null;
        }
        console.log(body)
        const identifier = createIdentifier(body!.userName)

        let user = await sql`
            SELECT json_build_object(
            'userName',u.user_name,
            'sub',u.user_sub,
            'userId',u.user_id,
            'companyName',c.company_name,
            'companyId', c.company_id,
            'participantId', u.participant_id,
            'role',u.company_role)
            FROM user_table AS u
            INNER JOIN company_table AS c ON u.company_id = c.company_id
            WHERE u.user_identifier = ${identifier};
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
                sql`UPDATE user_table SET user_sub = ${body!.sub} WHERE user_identifier=${identifier}`
            } catch (e) {
                console.log(e)
                return new Response(
                    JSON.stringify({ "error": "an error has occured" })
                )
            }
            //if there is a sub, dont allow login if its not the same as the one coming with the request.
        } else if (user.rows[0].json_build_object.sub != body!.sub) {
            return new Response(
                JSON.stringify({ "error": "user is not recognised" })
            )
        }

        const data = {
            "userName": user.rows[0].json_build_object.userName,
            "userId": user.rows[0].json_build_object.userId,
            "userSub": user.rows[0].json_build_object.sub,
            "companyName": user.rows[0].json_build_object.companyName,
            "companyId": user.rows[0].json_build_object.companyId,
            "participantId": user.rows[0].json_build_object.participantId,
            "role": user.rows[0].json_build_object.role
        }

        console.log(data)
        return new Response(
            JSON.stringify(data)
        );
    }
}