import { sql } from '@vercel/postgres';
import { PostEstablishmentLogin } from '../../types/establishmentTypes';


export const config = {
    runtime: 'edge',
};


export default async function login(
    request: Request,
) {
    if (request.method == "POST") {
        try {
            const body: PostEstablishmentLogin = await request.json()
            let user = await sql`
                SELECT json_build_object(
                'userName',u.user_name,
                'sub',u.sub,
                'userId',u.establishment_user_id,
                'establishmentName',et.establishment_name,
                'establishmentId', et.establishment_id)
                FROM establishment_user_table u
                INNER JOIN establishment_table et ON u.establishment_id = et.establishment_id
                WHERE u.user_name = ${body!.userName};
            `
            if (user.rowCount == 0) {
                return new Response(
                    JSON.stringify({ "forbidden": "user not found" }),
                    { status: 403 }
                )
            }

            //add sub if user has not logged in before
            if (user.rows[0].json_build_object.sub == null) {
                //todo implement adding the sub
                try {
                    sql`UPDATE establishment_user_table SET establishment_user_sub = ${body!.sub} WHERE establishment_user_name=${body!.userName}`
                } catch (e) {
                    console.log(e)
                    return new Response(
                        JSON.stringify({ "error": "an error has occured" }),
                        { status: 401 }
                    )
                }
                //if there is a sub, dont allow login if its not the same as the one coming with the request.
            } else if (user.rows[0].json_build_object.sub != body!.sub) {
                return new Response(
                    JSON.stringify({ "forbidden": "establishment user is not recognised" }),
                    { status: 403 }
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
                JSON.stringify(data),
                { status: 200 }
            );

        } catch (e) {
            return new Response(
                JSON.stringify({ "error": e }),
                { status: 403 }
            )
        }
    }
}