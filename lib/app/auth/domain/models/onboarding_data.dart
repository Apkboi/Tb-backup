class OnboardingData {
  final String title;
  final String description;

  OnboardingData(this.title, this.description);

  static List<OnboardingData> data = [
    OnboardingData("Find connections that last", "Triberly is designed to connect you with people across the globe that share your culture, values, and ethnicity."),
    OnboardingData("Discover & connect", "Find people near you and connect as travel buddies, business partners, romantic interests, language swappers, or friends."),
    OnboardingData("Connect with your African roots", "We speak your language, and chances are, so do millions of others"),
  ];
}