import { jwtVerify } from 'jose'

export const config = {
    //matcher: ['/api/:path*'],
    matcher: ['/api/:path*']
}

export default async function middleware(req: Request,) {
    // validate the user is authenticated

    const jswToken = req.headers.get("authorization")
    const verifiedToken = await jwtVerify(jswToken.substring(jswToken.indexOf(" ") + 1), new TextEncoder().encode(process.env.USER_TOKEN)).catch((err) => {
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