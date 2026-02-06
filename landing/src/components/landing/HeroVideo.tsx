"use client";

export function HeroVideo() {
  return (
    <div className="customer-video">
      <video
        autoPlay
        loop
        muted
        playsInline
        className="customer-video-element"
      >
        <source src="/video/hero-video.webm" type="video/webm" />
        <source src="/video/hero-video.mp4" type="video/mp4" />
      </video>
      <div className="customer-video-overlay" />
    </div>
  );
}
