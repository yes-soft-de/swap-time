class Urls {
  static String baseAPI = 'http://35.228.120.165/';

  static final loginAPI = baseAPI + 'login';
  static final loginGuideAPI = baseAPI + 'guid';
  static final createProfileAPI = baseAPI + 'tourist';
  static final getProfileAPI = baseAPI + 'tourist';
  static final locationList = baseAPI + 'regions';
  static final locationDetails = baseAPI + 'region/';
  static final guideList = baseAPI + 'guides';
  static final guidesByRegion = baseAPI + 'guid';
  static final orderGuide = baseAPI + 'order';
  static final orderLookup = baseAPI + 'orderlookup';
  static final acceptOrder = baseAPI + 'acceptorder';
  static final updateOrder = baseAPI + 'order';
  static final guideOrders = baseAPI + 'guidorder';
  static final comment = baseAPI + 'comment';
  static final event = baseAPI + 'event';
  static final rate = baseAPI + 'rating';
}
