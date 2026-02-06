import type { Metadata } from "next";

const apiBaseUrl =
  process.env.API_BASE_URL || "https://minutlyapi-staging.up.railway.app/api/v1";

interface CreatorProfile {
  ID: string;
  Username: string;
  DisplayName: string;
  Bio: string;
  ProfileImageURL?: string;
  Status: "online" | "away" | "busy";
  CallPreferences: {
    Video: { RatePerMinuteCents: number; MinimumDurationMinutes: number };
    Audio: { RatePerMinuteCents: number; MinimumDurationMinutes: number };
  };
}

async function getCreator(username: string): Promise<CreatorProfile | null> {
  try {
    const res = await fetch(
      `${apiBaseUrl}/creators/profile/${username}/public`,
      { next: { revalidate: 30 } }
    );
    if (!res.ok) return null;
    const data = await res.json();
    if (!data.Status) return null;
    return data.Data;
  } catch {
    return null;
  }
}

export async function generateMetadata({
  params,
}: {
  params: Promise<{ username: string }>;
}): Promise<Metadata> {
  const { username } = await params;
  const creator = await getCreator(username);

  if (!creator) {
    return { title: "Creator Not Found" };
  }

  const profileDomain =
    process.env.NEXT_PUBLIC_PROFILE_DOMAIN_URL || "https://midnight.me";

  return {
    title: `${creator.DisplayName || creator.Username} - Midnight Talk`,
    description:
      creator.Bio || `Book a private video call with ${creator.DisplayName}`,
    openGraph: {
      title: `${creator.DisplayName || creator.Username} - Midnight Talk`,
      description:
        creator.Bio || `Book a private video call with ${creator.DisplayName}`,
      images: creator.ProfileImageURL ? [creator.ProfileImageURL] : [],
      url: `${profileDomain}/${creator.Username}`,
      type: "profile",
    },
    twitter: {
      card: "summary_large_image",
      title: `${creator.DisplayName || creator.Username} - Midnight Talk`,
      description:
        creator.Bio || `Book a private video call with ${creator.DisplayName}`,
      images: creator.ProfileImageURL ? [creator.ProfileImageURL] : [],
    },
  };
}

export default async function ProfilePage({
  params,
}: {
  params: Promise<{ username: string }>;
}) {
  const { username } = await params;
  const creator = await getCreator(username);

  if (!creator) {
    return (
      <div
        style={{
          minHeight: "100vh",
          display: "flex",
          alignItems: "center",
          justifyContent: "center",
          background: "#000",
          color: "#fff",
        }}
      >
        <div style={{ textAlign: "center" }}>
          <h1 style={{ fontSize: "2rem", marginBottom: "1rem" }}>
            Creator not found
          </h1>
          <p style={{ color: "rgba(255,255,255,0.6)" }}>
            @{username} doesn&apos;t exist or isn&apos;t available.
          </p>
        </div>
      </div>
    );
  }

  const appUrl =
    process.env.NEXT_PUBLIC_APP_URL || "https://app.midnighttalk.com";
  const pricePerMin = creator.CallPreferences?.Video?.RatePerMinuteCents
    ? (creator.CallPreferences.Video.RatePerMinuteCents / 100).toFixed(2)
    : null;

  return (
    <div
      style={{
        minHeight: "100vh",
        background: "#000",
        color: "#fff",
        display: "flex",
        flexDirection: "column",
        alignItems: "center",
        padding: "80px 24px",
      }}
    >
      {creator.ProfileImageURL && (
        <img
          src={creator.ProfileImageURL}
          alt={creator.DisplayName}
          style={{
            width: 120,
            height: 120,
            borderRadius: "50%",
            objectFit: "cover",
            marginBottom: 24,
          }}
        />
      )}
      <h1 style={{ fontSize: "2rem", marginBottom: 8 }}>
        {creator.DisplayName || creator.Username}
      </h1>
      <p style={{ color: "rgba(255,255,255,0.5)", marginBottom: 8 }}>
        @{creator.Username}
      </p>
      <div
        style={{
          display: "inline-flex",
          alignItems: "center",
          gap: 6,
          marginBottom: 24,
        }}
      >
        <span
          style={{
            width: 8,
            height: 8,
            borderRadius: "50%",
            background: creator.Status === "online" ? "#22c55e" : "#666",
          }}
        />
        <span
          style={{
            fontSize: 12,
            textTransform: "uppercase",
            letterSpacing: "0.1em",
            color:
              creator.Status === "online"
                ? "#22c55e"
                : "rgba(255,255,255,0.5)",
          }}
        >
          {creator.Status}
        </span>
      </div>
      {creator.Bio && (
        <p
          style={{
            maxWidth: 480,
            textAlign: "center",
            color: "rgba(255,255,255,0.7)",
            lineHeight: 1.6,
            marginBottom: 32,
          }}
        >
          {creator.Bio}
        </p>
      )}
      {pricePerMin && (
        <p style={{ fontSize: 24, fontWeight: 700, marginBottom: 32 }}>
          ${pricePerMin}/min
        </p>
      )}
      <a
        href={`${appUrl}/${creator.Username}`}
        style={{
          background: "#fff",
          color: "#000",
          padding: "14px 40px",
          borderRadius: 999,
          fontSize: 15,
          fontWeight: 600,
          textTransform: "uppercase",
          letterSpacing: "0.06em",
          textDecoration: "none",
        }}
      >
        Book a call
      </a>
    </div>
  );
}
