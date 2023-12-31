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
        create table company_table (
            company_id INT GENERATED ALWAYS AS IDENTITY,
            company_name VARCHAR(255),
            company_identifier VARCHAR(255) UNIQUE,
            contact_email VARCHAR(255),
            org_number INT,
            PRIMARY KEY (company_id)
        );`
        result = await sql`
        create table participant_table (
            participant_id INT GENERATED ALWAYS AS IDENTITY,
            participant_name VARCHAR(255),
            participant_identifier VARCHAR(255) UNIQUE,
            company_id INT references company_table(company_id),
            owner_company_id INT references company_table(company_id),
            PRIMARY KEY (participant_id)
        );`
        result = await sql`create table user_table (
            user_id INT GENERATED ALWAYS AS IDENTITY,
            user_name VARCHAR(255),
            user_identifier VARCHAR(255) UNIQUE,
            user_email VARCHAR(255),
            user_device_id VARCHAR(255),
            user_sub VARCHAR(60),
            company_id INT references company_table(company_id),
            role VARCHAR(255),
            participant_id INT references participant_table(participant_id),
            PRIMARY KEY (user_id)
        );
      `
        result = await sql`
        create table participant_relation_table (
            participant_relation_id VARCHAR(60),
            relation_owner_company_id INT references company_table(company_id),
            participant_id INT references participant_table(participant_id),
            relation VARCHAR(255)
        );
        `
        result = await sql`create table expense_template_table (
            expense_template_id INT GENERATED ALWAYS AS IDENTITY,
            expense_intent VARCHAR(255),
            created_by INT references user_table(user_id),
            active bool,
            PRIMARY KEY (expense_template_id)
        );`
        result = await sql`
        create table participant_log_table (
            participant_log_id INT GENERATED ALWAYS AS IDENTITY,
            participant_id INT references participant_table(participant_id),
            expense_template_id INT references expense_template_table(expense_template_id),
            people_whitelist_id INT,
            company_whitelist_id INT
        );
        `
        result = await sql`
        create table company_whitelist_table (
            company_whitelist_id  INT GENERATED ALWAYS AS IDENTITY,
            company_id INT references company_table(company_id),
            participant_id INT references participant_table(participant_id),
            owner_company_id INT references company_table(company_id),
            PRIMARY KEY (company_whitelist_id)
        );`
        result = await sql`
        create table people_whitelist_table (
            people_whitelist_id VARCHAR(255) UNIQUE,
            company_id INT references company_table(company_id),
            participant_id INT references participant_table(participant_id),
            owner_company_id INT references company_table(company_id),
            PRIMARY KEY (people_whitelist_id)
        );`
        result = await sql`
        create table establishment_table (
            establishment_id INT GENERATED ALWAYS AS IDENTITY,
            establishment_name VARCHAR(255),
            org_number INT,
            address VARCHAR(255),
            contact_email VARCHAR(255),
            PRIMARY KEY (establishment_id)
        );`
        result = await sql`
        create table establishment_user_table (
            establishment_user_id INT GENERATED ALWAYS AS IDENTITY,
            establishment_id INT references establishment_table(establishment_id),
            user_name VARCHAR(255),
            email VARCHAR(255),
            device_id VARCHAR(255),
            sub VARCHAR(30),
            role VARCHAR(255),
            PRIMARY KEY (establishment_user_id)
        );`
        result = await sql`
        create table establishment_client_table (
            establishment_client_id INT GENERATED ALWAYS AS IDENTITY,
            establishment_id INT references establishment_table(establishment_id),
            company_id  INT references company_table(company_id),
            PRIMARY KEY (establishment_client_id)
        );`
        await sql`
            create table expense_rule_table (
            expense_rule_id INT GENERATED ALWAYS AS IDENTITY,
            rule_name VARCHAR(255),
            role VARCHAR(255),
            company_id INT references company_table(company_id),
            rule_data JSONB,
            explaination TEXT,
            created_by INT references user_table(user_id),
            active bool,
            PRIMARY KEY (expense_rule_id)
        );
        `
        result = await sql`
        create table expense_table (
            expense_id INT GENERATED ALWAYS AS IDENTITY,
            establishment_id INT references establishment_table(establishment_id),
            settled_by INT references user_table(user_id),
            expense_timestamp timestamp,
            total_expense BIGINT,
            vat BIGINT,
            gross_expense BIGINT,
            net_expense BIGINT,
            active bool,
            liquor bool,
            tip BIGINT,
            currency VARCHAR(255),
            PRIMARY KEY (expense_id)
        );`
        result = await sql`
        create table expense_line_item_table (
            line_item_id INT GENERATED ALWAYS AS IDENTITY,
            line_item_name VARCHAR(255),
            number_purchased INT,
            cost_per_item BIGINT,
            expense_id INT references expense_table(expense_id),
            PRIMARY KEY (line_item_id)
        );
        `
        result = await sql`
        create table expense_transaction_table (
            expense_transaction_id INT GENERATED ALWAYS AS IDENTITY,
            settled_by_id INT,
            settled_timestamp timestamp,
            expense_id INT references expense_table(expense_id),
            expense_template_id INT references expense_template_table(expense_template_id),
            establishment_id INT references establishment_table(establishment_id),
            company_id INT references company_table(company_id),
            expense_type VARCHAR(100),
            PRIMARY KEY (expense_transaction_id)
        );
        `
        result = await sql`
        create table expense_queue_table (
            expense_queue_id INT GENERATED ALWAYS AS IDENTITY,
            user_id INT references user_table(user_id),
            company_id INT references company_table(company_id),
            expense_id INT references expense_table(expense_id),
            establishment_user_id INT references establishment_user_table,
            establishment_id INT references establishment_table(establishment_id),
            queued bool,
            PRIMARY KEY (expense_queue_id)
        );
        `
        return new Response(JSON.stringify({}), { status: 200 });
    } catch (error) {
        console.log(error)
        return new Response(JSON.stringify({ error }));
    }
}
