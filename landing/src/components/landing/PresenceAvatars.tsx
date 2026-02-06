const creators = [
  { src: "/images/creators/creator1.jpg", alt: "Creator 1" },
  { src: "/images/creators/creator2.jpg", alt: "Creator 2" },
  { src: "/images/creators/creator3.jpg", alt: "Creator 3" },
  { src: "/images/creators/creator4.jpg", alt: "Creator 4" },
  { src: "/images/creators/creator5.jpg", alt: "Creator 5" },
];

export function PresenceAvatars() {
  return (
    <div className="customer-presence">
      <div className="customer-presence-avatars" aria-label="Available creators">
        {creators.map((creator, index) => (
          <img
            key={index}
            className="customer-presence-avatar"
            src={creator.src}
            alt={creator.alt}
            loading="lazy"
          />
        ))}
      </div>
      <div className="customer-presence-status">
        <span className="customer-presence-dot" aria-hidden="true" />
        Online now
      </div>
    </div>
  );
}
