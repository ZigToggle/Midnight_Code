import { NextRequest, NextResponse } from "next/server";

export function middleware(request: NextRequest) {
  const hostname = request.headers.get("host") || "";
  const { pathname } = request.nextUrl;

  // Local development: use NEXT_PUBLIC_SITE_MODE env var or hostname detection
  const isProfileDomain =
    hostname.includes("midnight.me") ||
    process.env.NEXT_PUBLIC_SITE_MODE === "profiles";

  if (isProfileDomain) {
    // midnight.me root → redirect to midnighttalk.com
    if (pathname === "/") {
      const marketingUrl =
        process.env.NEXT_PUBLIC_DOMAIN_URL || "https://midnighttalk.com";
      return NextResponse.redirect(marketingUrl);
    }

    // midnight.me/{username} → rewrite to /_profiles/[username]
    // Only rewrite if it looks like a username (not a static file or API route)
    if (
      !pathname.startsWith("/_") &&
      !pathname.startsWith("/api") &&
      !pathname.includes(".")
    ) {
      const url = request.nextUrl.clone();
      url.pathname = `/_profiles${pathname}`;
      return NextResponse.rewrite(url);
    }
  }

  // midnighttalk.com → serves (marketing) route group by default
  return NextResponse.next();
}

export const config = {
  matcher: [
    // Match all paths except static files and Next.js internals
    "/((?!_next/static|_next/image|favicon|.*\\.(?:svg|png|jpg|jpeg|gif|webp|ico|mp4|webm|woff2)$).*)",
  ],
};
