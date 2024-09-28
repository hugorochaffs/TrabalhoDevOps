import { cookies } from 'next/headers'
import { NextRequest, NextResponse } from 'next/server'

export async function GET(request: NextRequest) {
  const redirectUrl = request.nextUrl.clone()
  redirectUrl.pathname = '/auth/sign-in'
  redirectUrl.hostname = request.headers.get('host') ?? 'localhost'
  const currentPort = redirectUrl.port
  const isHttps = request.headers.get('x-forwarded-proto') === 'https'
  if (currentPort) {
    redirectUrl.port = isHttps ? '443' : '80'
  }

  cookies().set({
    name: 'token',
    value: '',
    path: '/',
    maxAge: 0,
  })

  return NextResponse.redirect(redirectUrl)
}
