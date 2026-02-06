import { PresenceAvatars } from "./PresenceAvatars";

const appUrl =
  process.env.NEXT_PUBLIC_APP_URL || "https://app.midnighttalk.com";

export function HeroSection() {
  return (
    <main className="customer-hero">
      <div className="customer-hero-inner">
        <PresenceAvatars />

        <div className="customer-eyebrow">Private video calls</div>
        <h1 className="customer-title">
          The best conversations happen{" "}
          <span className="customer-title-accent">at midnight...</span>
        </h1>
        <p className="customer-lede">
          Book instantly. Pay securely. Meet face-to-face in minutes with the
          people who matter to you. No middlemen, no chatter, just direct talk.
        </p>

        <div className="customer-actions">
          <a className="customer-cta" href={`${appUrl}/login`}>
            Log in as customer
          </a>
          <a className="customer-cta-secondary" href={`${appUrl}/join`}>
            Become a creator
          </a>
        </div>

        <div className="customer-trust">
          <div className="customer-trust-item">
            Missed calls? You&apos;ll be refunded
          </div>
          <div className="customer-trust-divider" aria-hidden="true" />
          <div className="customer-trust-item">Secure payments</div>
          <div className="customer-trust-divider" aria-hidden="true" />
          <div className="customer-trust-item">Verified creators</div>
        </div>
      </div>

      {/* Scroll indicator */}
      <div className="customer-scroll-hint">
        <span>Scroll to explore</span>
        <div className="customer-scroll-arrow" />
      </div>
    </main>
  );
}
