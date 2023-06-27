import type { VercelRequest, VercelResponse } from '@vercel/node';
import { createKysely } from "@vercel/postgres-kysely";

interface Database {
    company: company_table;
  }      

export default async function expense(
    request: VercelRequest,
    response: VercelResponse,
  ) {


    const db = createKysely<Database>();

    const insertArray = request.body.lineItems.map( (lineItem) => ({
        "company_id":lineItem.item,
        "participant_id":lineItem.number,
        }))

    const peopleWhitelist = await db
    .insertInto('people_whitelist_table')
    .values(request.body)
    .returning('people_whitelist_id')
    .executeTakeFirstOrThrow()

    response.status(200).json({
        body: request.body,
        query: request.query,
        cookies: request.cookies,
    });
}