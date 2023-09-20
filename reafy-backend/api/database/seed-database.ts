import { sql } from '@vercel/postgres';

export const config = {
    runtime: 'edge',
};


export default async function createDatabase(
    request: Request
) {
    try {
        let result;
        result = await sql`
                INSERT INTO company_table (company_name, company_identifier, contact_email, org_number)
                VALUES ('Tyve', 'tyve', 'christian.vestre@gmail.com', 1112345 ),
                ('Code11', 'code11', 'jørn.vestre@gmail.com', 2111421 ); `

        result = await sql`
                INSERT INTO participant_table (participant_name, participant_identifier, company_id, owner_company_id)
                VALUES ('Christian Vestre', 'christianvestre', 1,1),
                ('Frederik Vestre', 'frederikvestre', 1,1),
                ('Jørn Haukøy', 'jørnhaukøy', 2,1 ),
                ('Filip Kolber', 'filipkolber', 2,1); `

        result = await sql`
                INSERT INTO user_table (user_name, user_identifier, user_email, company_id, company_role, participant_id)
                VALUES ('Christian Vestre', 'christianvestre', 'christian.vestre@gmail.com', 1,'employee',1 ),
                ('Frederik Vestre', 'frederikvestre', 'frederik.vestre@gmail.com', 1,'employee',2 ),
                ('Jørn Haukøy', 'jørnhaukøy', 'jørn@code11.com', 2,'management',3 ),
                ('Filip Kolber', 'filipkolber', 'filip@code11.com', 2,'employee',4 ); `



        result = await sql`
                INSERT INTO participant_relation_table (company_id, participant_id, relation)
                VALUES (1, 1,'colleague'),
                (1, 2,'colleague'),
                (2, 3,'colleague'),
                (2, 4,'colleague'); `

        result = await sql`
                INSERT INTO expense_template_table (expense_intent, expense_type, created_by, active)
                VALUES ('Møteservering', 'Velferd',1,true);
        `

        result = await sql`
                INSERT INTO participant_log_table (participant_id, expense_template_id)
                VALUES (1, 1),
                (1, 1),
                (2, 1),
                (2, 1); `

        result = await sql`
                INSERT INTO people_whitelist_table (people_whitelist_id,company_id, participant_id, owner_company_id)
                VALUES ('1_1',1, 1, 1),
                ('1_2', 1, 2, 1),
                ('2_3', 2, 3, 1),
                ('2_4',2, 4, 1); `

        result = await sql`
                INSERT INTO establishment_table ( establishment_name, org_number, address,contact_email)
                VALUES ('Mesh', '201230', 'Møllergata 6','hei@mesh.com'); `

        result = await sql`
                INSERT INTO establishment_user_table ( establishment_id, establishment_user_name, establishment_user_email, establishment_user_role)
                VALUES (1, 'Johan Vorgaarden', 'johan@mesh.com', 'management'),
                 (1, 'Christian Vestre', 'christian.vestre@gmail.com','employee'); `

        result = await sql`
                INSERT INTO establishment_client_table ( establishment_id, company_id)
                VALUES (1, 1),
                 (1, 2); `

        result = await sql`
                INSERT INTO expense_table ( establishment_id, total_expense, mva, active, currency)
                VALUES (1 , 60000, 12000, true, 'NOK'),
                 (1 , 50000, 10000, true, 'NOK'); `

        result = await sql`
                INSERT INTO expense_line_item_table ( line_item_name, number_purchased, cost_per_item, expense_id)
                VALUES ('Beer' , 2, 7000, 1),
                 ('Sandwich' , 3, 6000, 1),
                 ('Coca cola' , 2, 5000, 1),
                 ('Beer' , 4, 7000, 2),
                 ('Pasta' , 4, 8000, 2),
                 ('Chips' , 5, 3000, 2); 
        `
        return new Response(JSON.stringify({ result }));
    } catch (error) {
        console.log(error)
        return new Response(JSON.stringify({ error }));
    }
}
