import type { VercelRequest, VercelResponse } from '@vercel/node';
import { createKysely } from "@vercel/postgres-kysely";

interface Database {
    company: people_whitelist_table;
  }      

export default async function expense(
    request: VercelRequest,
    response: VercelResponse,
  ) {

    const db = createKysely<Database>();

    const dataArray = request.body.map((participant) => ({
        "company":participant.company,
        "participant":participant.name,
        }))
    
    const insertArray = []
      
    for (let i = 0; i<dataArray.length;i++){
      let company_id = await db
      .selectFrom('company_table')
      .select("company_id")
      .where('company_name', '=', dataArray[i].company)
      .executeTakeFirst()
      if(!company_id) {
        company_id = await db
          .insertInto('company_table')
          .values({"company_name":dataArray[i].company})
          .returning('company_id')
          .executeTakeFirstOrThrow()
      }
      let participant_id = await db
      .selectFrom('participant_table')
      .select("participant_id")
      .where('participant_name', '=', dataArray[i].participant)
      .executeTakeFirst()
      if(!participant_id) {
        participant_id = await db
          .insertInto('participant_table')
          .values({"company_id":company_id.company_id, "participant_name":dataArray[i].participant})
          .returning('participant_id')
          .executeTakeFirstOrThrow()
      }
      insertArray.push({
        "participant_id":participant_id.participant_id,
        "company_id": company_id.company_id
      })
    }

    const peopleWhitelist = await db
    .insertInto('people_whitelist_table')
    .values(insertArray)
    .returning('people_whitelist_id')
    .executeTakeFirstOrThrow()

    response.status(200).json({
        body: request.body,
        query: request.query,
        cookies: request.cookies,
    });
}