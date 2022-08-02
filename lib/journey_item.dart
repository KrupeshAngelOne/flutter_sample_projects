class JourneyItemData {
  late String title;
  late String url;
  late String modules;
  late String icon;

  JourneyItemData();

  JourneyItemData.createNew(
      String title, String url, String modules, String icon) {
    this.title = title;
    this.url = url;
    this.modules = modules;
    this.icon = icon;
  }
}
