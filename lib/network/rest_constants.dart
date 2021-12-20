class RestConstants {
  static const String kApiHost = 'www.astrotak.com';

  static const String kLiveBaseUrl = 'https://$kApiHost/astroapi/api/';
  static const String kStagingBaseUrl = 'https://$kApiHost/astroapi/api/';

  static const String kGetAstrologer = 'agent/all';
  static const String kGetLocation = 'location/place';
  static const String kPostDailyPanchang = 'horoscope/daily/panchang';
}
