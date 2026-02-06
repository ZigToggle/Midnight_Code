import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: {
    default: "Midnight Talk - Private Video Calls with Creators",
    template: "%s | Midnight Talk",
  },
  description:
    "Book instant 1:1 video calls with your favorite creators. Secure payments, verified creators, private calls. Connect face-to-face in minutes.",
  keywords:
    "video calls, creators, 1:1 calls, private video chat, creator economy, fan calls",
  authors: [{ name: "Midnight Talk" }],
  metadataBase: new URL(
    process.env.NEXT_PUBLIC_DOMAIN_URL || "https://midnighttalk.com"
  ),
  openGraph: {
    type: "website",
    siteName: "Midnight Talk",
    title: "Midnight Talk - Private Video Calls with Creators",
    description:
      "Book instant 1:1 video calls with your favorite creators. Secure payments, verified creators, private calls.",
    images: ["/android-chrome-512x512.png"],
  },
  twitter: {
    card: "summary_large_image",
    title: "Midnight Talk - Private Video Calls with Creators",
    description:
      "Book instant 1:1 video calls with your favorite creators. Secure payments, verified creators, private calls.",
    images: ["/android-chrome-512x512.png"],
  },
  icons: {
    icon: [
      { url: "/favicon-32x32.png", sizes: "32x32", type: "image/png" },
      { url: "/favicon-16x16.png", sizes: "16x16", type: "image/png" },
    ],
    apple: "/apple-touch-icon.png",
  },
  manifest: "/manifest.json",
};

// Static GTM inline script — no user input, safe to inline
const GTM_SCRIPT = `(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','GTM-WSTRMHWB');`;

// Static JSON-LD structured data — no user input
const JSON_LD = JSON.stringify({
  "@context": "https://schema.org",
  "@type": "WebApplication",
  name: "Midnight Talk",
  url: "https://midnighttalk.com",
  description:
    "Book instant 1:1 video calls with your favorite creators. Secure payments, verified creators, private calls.",
  applicationCategory: "CommunicationApplication",
  operatingSystem: "Web, iOS",
  offers: { "@type": "Offer", price: "0", priceCurrency: "USD" },
  aggregateRating: {
    "@type": "AggregateRating",
    ratingValue: "4.8",
    ratingCount: "500",
  },
});

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <head>
        {/* DNS prefetch & preconnect */}
        <link rel="dns-prefetch" href="https://res.cloudinary.com" />
        <link
          rel="preconnect"
          href="https://res.cloudinary.com"
          crossOrigin="anonymous"
        />

        {/* Preload fonts */}
        <link
          rel="preload"
          href="/fonts/inter-400.woff2"
          as="font"
          type="font/woff2"
          crossOrigin="anonymous"
        />
        <link
          rel="preload"
          href="/fonts/inter-700.woff2"
          as="font"
          type="font/woff2"
          crossOrigin="anonymous"
        />

        {/* Google Tag Manager — static hardcoded script, no user input */}
        <script
          dangerouslySetInnerHTML={{ __html: GTM_SCRIPT }}
        />

        {/* Contentsquare Analytics */}
        <script
          async
          src="https://t.contentsquare.net/uxa/ea5fbadeeb480.js"
        />

        {/* Structured Data — static hardcoded JSON, no user input */}
        <script
          type="application/ld+json"
          dangerouslySetInnerHTML={{ __html: JSON_LD }}
        />
      </head>
      <body>
        {/* GTM noscript */}
        <noscript>
          <iframe
            src="https://www.googletagmanager.com/ns.html?id=GTM-WSTRMHWB"
            height="0"
            width="0"
            style={{ display: "none", visibility: "hidden" }}
          />
        </noscript>
        {children}
      </body>
    </html>
  );
}
