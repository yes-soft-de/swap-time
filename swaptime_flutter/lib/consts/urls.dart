class Urls {
  static const String BASE_API = 'http://34.70.151.188/html/public/index.php';

  static const API_SIGN_UP = BASE_API + '/user';
  static const API_CREATE_TOKEN = BASE_API + '/login_check';

  static const API_PROFILE = BASE_API + '/userprofile';
  static const API_GAMES = BASE_API + '/swapitem';
  static const API_USER_GAMES = BASE_API + '/swapitembyuserid';
  static const API_GAME_BY_ID = BASE_API + '/swapitembyid';
  static const API_INTERACTION = BASE_API + '/interaction';

  static const API_COMMENTS = BASE_API + '/comment';
  static const API_SWAP_BY_ME = BASE_API + '/swapbyuserid';
  static const API_CREATE_SWAP = BASE_API + '/swap';

  static const RAWG = 'https://api.rawg.io/api/';
  static const IMGBB = 'https://api.imgbb.com/1/upload';
  static const SEARCH_GAMES_API = RAWG + 'games';
}
