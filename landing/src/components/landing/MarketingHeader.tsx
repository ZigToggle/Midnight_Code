"use client";

const appUrl =
  process.env.NEXT_PUBLIC_APP_URL || "https://app.midnighttalk.com";

export function MarketingHeader() {
  return (
    <header className="customer-header">
      <div className="customer-logo">
        <img
          className="customer-logo-image"
          src="/images/midnight-logo.png"
          alt="Midnight"
        />
        <span className="customer-logo-text">Midnight</span>
      </div>
      <div className="customer-header-actions">
        <a className="customer-header-link" href={`${appUrl}/join`}>
          Become a creator
        </a>
        <a className="customer-header-signin" href={`${appUrl}/login`}>
          Sign in
        </a>
      </div>
    </header>
  );
}
