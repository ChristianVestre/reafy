import { sql } from '@vercel/postgres';
import { AddCompanyRequest } from '../types/crudTypes';

export const config = {
  runtime: 'edge',
};

export default async function addCompany(
  request: Request,
) {
  let body: AddCompanyRequest;
  try {
    body = await request.json();
  } catch (e) {
    body = null;
  }

  const company = await sql`
      INSERT INTO company_table
      (company_name, contact_email, org_number)
      SELECT ${body.companyName},${body.contactEmail},${body.orgNumber} 
      WHERE
          NOT EXISTS (
              SELECT company_name FROM company_table WHERE company_name = ${body.companyName}
          )
      RETURNING row_to_json(company_table)    
      ;
    `

  return new Response(
    JSON.stringify(company.rows[0].row_to_json)
  )
}