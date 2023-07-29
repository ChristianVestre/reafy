import type { VercelRequest, VercelResponse } from '@vercel/node';
import { jsonToSql } from '../../utils/jsonToSQL';
import { sql } from '@vercel/postgres';
import { JSONArray } from '../../types/json-types';

export default async function expense(
    request: VercelRequest,
    response: VercelResponse,
  ) {

    const query = "SELECT participant_id, participant_name, company_name  FROM participant_table WHERE (participant_name,company_name) IN (SELECT * FROM UNNEST ($1::text[],$2::text[]))"
    
    const participantValues = jsonToSql(request.body)
    const result = await sql.query(query, participantValues)

    let participantIds = result.rows.map((item) => {
      console.log(item)
      return item.participant_id
    })
    
    if(request.body.length != result.rowCount){
    const findNewParticipants = () => {
        let newParticipants:JSONArray = []
        request.body.forEach((requestItem) => {
          let filteredArray = result.rows.filter(item => item.participant_name === requestItem.participant_name && item.company_name == requestItem.company_name)
          if(filteredArray.length == 0){
            newParticipants.push(requestItem)
          }
        })
        return newParticipants
    }
    const newParticipants = findNewParticipants()
    const insertParticipantQuery = "INSERT INTO participant_table (participant_name,company_name) SELECT * FROM UNNEST ($1::text[],$2::text[]) RETURNING row_to_json(participant_table)"
    const participantValues = jsonToSql(newParticipants)
    const insertParticipantsResult = await sql.query(insertParticipantQuery, participantValues)
    insertParticipantsResult.rows.forEach((item) => {
      participantIds.push(item.row_to_json.participant_id)
    })
    }

    const createWhitelistIds = () => {
    let whitelistIds = participantValues[1].map((item,index) =>  {
      return participantIds[index]+"_"+item
      })
      return whitelistIds
    }
    const whitelistIds = createWhitelistIds()
    const whitelistValues = [whitelistIds,participantValues[1],participantIds]

    const peopleWhitelistQuery = `INSERT INTO people_whitelist_table (people_whitelist_id,company_name,participant_id) 
    SELECT * FROM UNNEST ($1::text[],$2::text[],$3::int[]) 
    ON CONFLICT (people_whitelist_id) DO UPDATE SET people_whitelist_id = EXCLUDED.people_whitelist_id
    RETURNING row_to_json(people_whitelist_table);`
    const peopleWhitelistResult = await sql.query(
      peopleWhitelistQuery,
      whitelistValues)


    response.status(200).json({
        body: peopleWhitelistResult,
        query: request.query,
        cookies: request.cookies,
    });
}