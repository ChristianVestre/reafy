import { sql } from '@vercel/postgres';

import { getUrlParams } from '../../helpers/helperFunctions';

export const config = {
    runtime: 'edge',
};

export default async function expensePayed(
    request: Request
) {
    if (request.method == "GET") {
        try {
            const params = getUrlParams(request.url)
            const expense = await sql`
         SELECT row_to_json(expense_table) FROM expense_table WHERE expense_id = ${params.id}
       `

            const data = {
                active: expense.rows[0].row_to_json.active,
                expenseId: expense.rows[0].row_to_json.expense_id,
                settledBy: expense.rows[0].row_to_json.settledBy
            }

            return new Response(
                JSON.stringify(data)
            )
        } catch (e) {
            console.log(e)
            return Response.error()
        }
    }
}

/*

      let establishment = await sql`
    SELECT row_to_json(establishment_table) FROM establishment_table WHERE establishment_name = ${body.establishment};
    `
      if (establishment.rows.length == 0) {
        establishment = await sql`
      INSERT INTO establishment_table (establishment_name) VALUES (${body.establishment}) RETURNING row_to_json(establishment_table);
      `
      }



const lineItemValues = jsonToSql(request.body.lineItems,expense.rows[0].row_to_json.expense_id)
  const test = `('Beer','1','1','1')`
  console.log(test)
  console.log(lineItemValues)
  console.log(`
  INSERT INTO expense_line_item_table (line_item_name,number_purchased,cost_per_item, expense_id) VALUES ${lineItemValues};
  `)
  console.log(`
  INSERT INTO expense_line_item_table (line_item_name,number_purchased,cost_per_item, expense_id) VALUES (${test})`)
  console.log(`
  INSERT INTO expense_line_item_table (line_item_name,number_purchased,cost_per_item, expense_id) VALUES ('Beer',1,1,1), ('Coca Cola',1,1,1),('Sandwich', 2, 3, 4)
  `)
  let expenseLineItems = await sql`
  INSERT INTO expense_line_item_table (line_item_name,number_purchased,cost_per_item, expense_id) VALUES ${test}
  RETURNING row_to_json(expense_line_item_table)
  ;
  `
  
  console.log(expens
    eLineItems)
    */
/*    const expense = await sql`
    INSERT INTO expense_table (establishment_id)
    VALUES (${establishment.rows[0]?.row_to_json?.establishment_id})
    RETURNING row_to_json(expense_table)    
    ;
  `
  /*
  console.log(expense)
 
/*
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
     */