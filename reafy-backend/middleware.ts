import { jwtVerify } from 'jose'

export const config = {
    //matcher: ['/api/:path*'],
    matcher: ['/api/:path*']
}


export default async function middleware(req: Request,) {
    // validate the user is authenticated
    try {
        if (req.method == "OPTIONS") {
            return new Response(
                JSON.stringify({ "status": "ok" }),
                {
                    status: 200, headers:
                    {
                        "Access-Control-Allow-Credentials": "true",
                        "Access-Control-Allow-Origin": "*",
                        "Access-Control-Allow-Methods":
                            "GET,OPTIONS,PATCH,DELETE,POST,PUT",
                        "Access-Control-Allow-Headers":
                            "X-CSRF-Token, X-Requested-With, Accept, Accept-Version, Content-Length, Content-MD5, Content-Type, Date, X-Api-Version, Authorization"
                    }

                });
        }
    } catch (e) { console.log(e) }

    const jswToken = req.headers.get("authorization")
    const verifiedToken = await jwtVerify(jswToken!.substring(jswToken!.indexOf(" ") + 1), new TextEncoder().encode(process.env.USER_TOKEN)).catch((err) => {
        console.error(err.message)
    })

    if (!verifiedToken) {
        // if this an API request, respond with JSON
        if (req.url.startsWith('/api/')) {
            return new Response(
                JSON.stringify({ 'error': { message: 'authentication required' } }),
                { status: 401 });
        }
        // otherwise, redirect to the set token page
        else {
            return new Response(
                JSON.stringify({ 'error': { message: 'authentication required' } }),
                { status: 401 })
        }
    }
}