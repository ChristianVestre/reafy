import type { VercelRequest, VercelResponse } from '@vercel/node';
import { createKysely } from "@vercel/postgres-kysely";

interface Database {
    lineItem: expense_line_item_table; // see github.com/kysely-org/kysely
  }      

export default async function expense(
    request: VercelRequest,
    response: VercelResponse,
  ) {


    const db = createKysely<Database>();
      console.log(request.body.lineItems)
    request.body.lineItems.map( (lineItem) => console.log(lineItem.item))

    const insertArray = request.body.lineItems.map( (lineItem) => ({
        "line_item_name":lineItem.item,
        "number_purchased":lineItem.number,
        "cost_per_item":lineItem.price,
        "expense_id":13344
        }))

    const search = await db.selectFrom('expense_line_item_table')
    .select('line_item_name')
    .execute()
    console.log("test", search)
    const lineItems = await db
    .insertInto('expense_line_item_table')
    .values(insertArray)
    .returning('line_item_id')
    .executeTakeFirstOrThrow()

    console.log(request.body)
    response.status(200).json({
      body: request.body,
      query: request.query,
      cookies: request.cookies,
    });
  }