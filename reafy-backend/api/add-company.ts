import type { VercelRequest, VercelResponse } from '@vercel/node';
import { sql } from '@vercel/postgres';



export default async function expense(
    request: VercelRequest,
    response: VercelResponse,
  ) {

    const company = await sql`
      INSERT INTO company_table
      (company_name, contact_email, org_number)
      SELECT ${request.body.company_name},${request.body.contact_email},${request.body.org_number} 
      WHERE
          NOT EXISTS (
              SELECT company_name FROM company_table WHERE company_name = ${request.body.company_name}
          )
      RETURNING row_to_json(company_table)    
      ;
    `  

    response.status(200).json({
      body: company.rows[0]?.row_to_json,
      query: request.query,
      cookies: request.cookies,
    });
  }