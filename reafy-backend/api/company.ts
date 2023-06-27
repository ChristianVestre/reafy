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

    const company = await db
    .insertInto('company_table')
    .values(request.body)
    .returning('company_id')
    .executeTakeFirstOrThrow()

    response.status(200).json({
      body: request.body,
      query: request.query,
      cookies: request.cookies,
    });
  }