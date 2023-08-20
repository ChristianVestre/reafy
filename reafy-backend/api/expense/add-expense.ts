import type { VercelRequest, VercelResponse } from '@vercel/node';
import { sql } from '@vercel/postgres';
import { jsonToSql } from '../../utils/jsonToSQL';


export default async function expense(
  request: VercelRequest,
  response: VercelResponse,
) {



  let establishment = await sql`
    SELECT row_to_json(establishment_table) FROM establishment_table WHERE establishment_name = ${request.body.establishment};
    `
  if (establishment.rows.length == 0) {
    establishment = await sql`
      INSERT INTO establishment_table (establishment_name) VALUES (${request.body.establishment}) RETURNING row_to_json(establishment_table);
      `
  }
  console.log(establishment.rows[0])

  console.log(request.body)
  const expense = await sql`
      INSERT INTO expense_table (establishment_id, expense_intent, expense_type, settled_by, expense_timestamp, total_expense, active, tip, currency)
      VALUES (${establishment.rows[0]?.row_to_json?.establishment_id},
        ${request.body.expense_intent}, 
        ${request.body.expense_type}, 
        ${request.body.settled_by}, 
        ${request.body.expense_timestamp}, 
        ${request.body.total_expense}, 
        ${request.body.active}, 
        ${request.body.tip}, 
        ${request.body.currency}
        )
      RETURNING row_to_json(expense_table)    
      ;
    `
  console.log(expense.rows[0].row_to_json)

  //const text = 'INSERT INTO expense_line_item_table (line_item_name,number_purchased,cost_per_item, expense_id) VALUES ($1::text[],$2::int,$3::int,$4::int) RETURNING row_to_json(expense_line_item_table)'


  const text = "INSERT INTO expense_line_item_table (line_item_name,number_purchased,cost_per_item, expense_id) SELECT * FROM UNNEST ($1::text[],$2::int[],$3::int[],$4::int[])"
  const values = [['Beer', 'Coca Cola', "Sandwich"], [1, 1, 1], [1, 1, 2], [1, 1, 3]]
  const lineItemValues = jsonToSql(request.body.lineItems, expense.rows[0].row_to_json.expense_id)
  const test1 = await sql.query(text, lineItemValues)


  console.log(test1)
  /*  const lineItemValues = jsonToSql(request.body.lineItems,expense.rows[0].row_to_json.expense_id)
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
  response.status(200).json({
    body: request.body,
    query: request.query,
    cookies: request.cookies,
  });

}