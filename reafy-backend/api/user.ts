import type { VercelRequest, VercelResponse } from '@vercel/node';
import { createKysely } from "@vercel/postgres-kysely";

interface Database {
    user: user_table;
  }      

export default async function expense(
    request: VercelRequest,
    response: VercelResponse,
  ) {
    const db = createKysely<Database>();
    console.log(request.body)
    let company_id = await db
      .selectFrom('company_table')
      .select("company_id")
      .where('company_name', '=', request.body.company_name)
      .executeTakeFirst()
    console.log(company_id)
    if(!company_id) {
      company_id = await db
        .insertInto('company_table')
        .values({"company_name":request.body.company_name})
        .returning('company_id')
        .executeTakeFirstOrThrow()
    }
    console.log(company_id)
/*    const user = await db
      .insertInto('user_table')
      .values(request.body)
      .returning('user_id')
      .executeTakeFirstOrThrow() */
    

    response.status(200).json({
        body: company_id,
        query: request.query,
        cookies: request.cookies,
    });
}