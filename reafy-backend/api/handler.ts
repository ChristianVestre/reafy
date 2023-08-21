export const config = {
  runtime: 'edge',
};

export default async function handler(
  request: Request,
) {
  let body;
  try {
    body = await request.json();
  } catch (e) {
    body = null;
  }
  console.log(request.body)
  return new Response(JSON.stringify(body));
}