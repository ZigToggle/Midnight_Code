import { MarketingHeader } from "@/components/landing/MarketingHeader";
import { HeroSection } from "@/components/landing/HeroSection";
import { HeroVideo } from "@/components/landing/HeroVideo";
import { HowItWorks } from "@/components/landing/HowItWorks";
import { MarketingFooter } from "@/components/landing/MarketingFooter";
import "@/styles/landing.css";

export default function LandingPage() {
  return (
    <div className="customer-landing">
      <HeroVideo />
      <MarketingHeader />
      <HeroSection />
      <HowItWorks />
      <MarketingFooter />
    </div>
  );
}
