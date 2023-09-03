import { sql } from '@vercel/postgres';

export const config = {
    runtime: 'edge',
};


export default async function deleteDatabase(
    request: Request
) {
    try {
        let result;
        result = await sql`
            DROP SCHEMA public CASCADE;
             `

        result = await sql`
            CREATE SCHEMA public;
             `

        return new Response(JSON.stringify({ result }));
    } catch (error) {
        console.log(error)
        return new Response(JSON.stringify({ error }));
    }
}
