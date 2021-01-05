class Urls {
  static const String BASE_TEST_DOMAIN = 'http://192.168.1.12:8000';
  static const String BASE_LIVE_DOMAIN = 'http://swaptime.yes-apps.com';

  static const String BASE_DOMAIN = BASE_LIVE_DOMAIN;
  static const String IMAGES_ROOT = BASE_DOMAIN + '/upload/';
  static const String BASE_API = BASE_LIVE_DOMAIN + '/Backend/public';

  static const API_SIGN_UP = BASE_API + '/user';
  static const API_CREATE_TOKEN = BASE_API + '/login_check';

  static const API_PROFILE = BASE_API + '/userprofile';
  static const API_GAMES = BASE_API + '/swapitem';
  static const API_USER_GAMES = BASE_API + '/swapitembyuserid';
  static const API_GAME_BY_ID = BASE_API + '/swapitembyid';
  static const API_INTERACTION = BASE_API + '/interaction';
  static const API_USER_INTERACTION = BASE_API + '/userinteraction';
  static const API_REPORT = BASE_API + '/report';
  static const API_COMMENTS = BASE_API + '/comment';
  static const API_NOTIFICATION = BASE_API + '/notificationtoken';
  static const API_SWAP_BY_ME = BASE_API + '/swapbyuserid';
  static const API_CREATE_SWAP = BASE_API + '/swap';
  static const API_UPLOAD = BASE_API + '/uploadfile';

  static const API_DEBUG_REQUES =
      'https://6d1e6bd7404f63eb79a347bef494837d.m.pipedream.net';

  static const RAWG = 'https://api.rawg.io/api/';
  static const IMGBB = 'https://api.imgbb.com/1/upload';
  static const SEARCH_GAMES_API = RAWG + 'games';
}
