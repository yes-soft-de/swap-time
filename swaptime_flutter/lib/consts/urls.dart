class Urls {
  static const String BASE_API = 'http://104.154.241.113/html/public/index.php';

  static const API_PROFILE = BASE_API + '/userprofile';
  static const API_GAMES = BASE_API + '/swapitem';
  static const API_USER_GAMES = BASE_API + '/swapitembyuserid';
  static const API_GAME_BY_ID = BASE_API + '/swapitembyid';

  static const RAWG = 'https://api.rawg.io/api/';
  static const IMGBB = 'https://api.imgbb.com/1/upload';
  static const SEARCH_GAMES_API = RAWG + 'games/';
}
