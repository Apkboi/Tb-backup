class OnboardingData {
  final String title;
  final String description;

  OnboardingData(this.title, this.description);

  static List<OnboardingData> data = [
    OnboardingData("The best community for diasporans", "Make friends, find roomies, travel buddies or romance."),
    OnboardingData("Connect, network, build relationships", "Find people near you who share your culture & lifestyle."),
    OnboardingData("Find African-inspired services", "The place to find R&B DJs, make-up artists, the best jollof rice caterers and more."),
  ];
}