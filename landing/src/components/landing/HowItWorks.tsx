"use client";

import { useEffect, useRef, useState } from "react";

const steps = [
  {
    number: "01",
    title: "Find your creator",
    desc: "Browse profiles. See who's live right now.",
  },
  {
    number: "02",
    title: "Book & pay",
    desc: "Pick your duration, pay securely. Missed call? Full refund.",
  },
  {
    number: "03",
    title: "Connect face-to-face",
    desc: "Private HD video. No recordings, no screenshots. Ever.",
  },
];

export function HowItWorks() {
  const sectionRef = useRef<HTMLElement>(null);
  const [isVisible, setIsVisible] = useState(false);

  useEffect(() => {
    const observer = new IntersectionObserver(
      ([entry]) => {
        if (entry.isIntersecting) {
          setIsVisible(true);
        }
      },
      { threshold: 0.2 }
    );

    if (sectionRef.current) {
      observer.observe(sectionRef.current);
    }

    return () => observer.disconnect();
  }, []);

  return (
    <section className="hiw-cards-section" ref={sectionRef}>
      <div className="hiw-cards-container">
        <div className="hiw-cards-header">
          <h2 className="hiw-cards-title">How it works</h2>
        </div>

        <div className="hiw-cards-grid">
          {steps.map((step, i) => (
            <div
              key={step.number}
              className={`hiw-card ${isVisible ? "hiw-card--visible" : ""}`}
              style={{ transitionDelay: `${i * 120}ms` }}
            >
              <span className="hiw-card-number">{step.number}</span>
              <div className="hiw-card-accent" />
              <h3 className="hiw-card-title">{step.title}</h3>
              <p className="hiw-card-desc">{step.desc}</p>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
}
