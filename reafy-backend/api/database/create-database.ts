import { VercelRequest, VercelResponse } from '@vercel/node';
import { sql } from '@vercel/postgres';
 
export default async function handler(
  request: VercelRequest,
  response: VercelResponse,
) {
  try {
    const result =
      await sql`
        create table company_table (
            company_id INT GENERATED ALWAYS AS IDENTITY,
            company_name VARCHAR(255),
            contact_email VARCHAR(255),
            org_number INT,
            PRIMARY KEY (company_id)
        );
        create table user_table (
            user_id INT GENERATED ALWAYS AS IDENTITY,
            user_name VARCHAR(255),
            company_id INT references company_table(company_id),
            company_role VARCHAR(255),
            participant_id INT,
            PRIMARY KEY (user_id)
        );
        create table expense_object_table (
            expense_object_id INT GENERATED ALWAYS AS IDENTITY,
            expense_intent VARCHAR(255),
            expense_type VARCHAR(255),
            created_by INT references user_table(user_id),
            active bool,
            require_permission bool,
            PRIMARY KEY (expense_object_id)
        );
        create table participant_table (
            participant_id INT GENERATED ALWAYS AS IDENTITY,
            participant_name VARCHAR(255),
            company_id INT references company_table(company_id),
            PRIMARY KEY (participant_id)
        );
        create table company_whitelist_table (
            company_whitelist_id  INT GENERATED ALWAYS AS IDENTITY,
            company_id INT references company_table(company_id),
            participant_id INT references participant_table(participant_id),
            PRIMARY KEY (company_whitelist_id)
        );
        create table people_whitelist_table (
            people_whitelist_id  INT GENERATED ALWAYS AS IDENTITY,
            company_id INT references company_table(company_id),
            participant_id INT references participant_table(participant_id),
            PRIMARY KEY (people_whitelist_id)
        );
        create table expense_table (
            expense_id INT GENERATED ALWAYS AS IDENTITY,
            establishment_id INT references establishment_table(establishment_id),
            expense_intent VARCHAR(255),
            expense_type VARCHAR(255),
            settled_by INT references user_table(user_id),
            expense_timestamp timestamp,
            total_expense INT,
            gross_expense INT,
            net_expense INT,
            active bool,
            tip INT,
            currency VARCHAR(255),
            PRIMARY KEY (expense_id)
        );
        create table establishment_table (
            establishment_id INT GENERATED ALWAYS AS IDENTITY,
            establishment_name VARCHAR(255),
            org_number INT,
            address VARCHAR(255),
            contact_name VARCHAR(255),
            PRIMARY KEY (establishment_id)
        );
        create table expense_line_item_table (
            line_item_id INT GENERATED ALWAYS AS IDENTITY,
            line_item_name VARCHAR(255),
            number_purchased INT,
            cost_per_item INT,
            expense_id INT references expense_table(expense_id),
            PRIMARY KEY (line_item_id)
        );
        `;
    return response.status(200).json({ result });
  } catch (error) {
    return response.status(500).json({ error });
  }
}