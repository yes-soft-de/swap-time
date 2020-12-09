import 'app.component.dart' as _i1;
import '../../utils/logger/logger.dart' as _i2;
import '../../module_localization/service/localization_service/localization_service.dart'
    as _i3;
import '../../utils/auth_guard/auth_gard.dart' as _i4;
import 'dart:async' as _i5;
import '../../main.dart' as _i6;
import '../../module_home/home.module.dart' as _i7;
import '../../module_home/ui/screens/home_screen.dart' as _i8;
import '../../module_auth/service/auth_service/auth_service.dart' as _i9;
import '../../module_auth/presistance/auth_prefs_helper.dart' as _i10;
import '../../module_auth/manager/auth/auth_manager.dart' as _i11;
import '../../module_auth/repository/auth/auth_repository.dart' as _i12;
import '../../module_network/http_client/http_client.dart' as _i13;
import '../../module_profile/service/profile/profile.dart' as _i14;
import '../../module_profile/manager/my_profile_manager/my_profile_manager.dart'
    as _i15;
import '../../module_profile/repository/my_profile/my_profile.dart' as _i16;
import '../../module_profile/presistance/profile_shared_preferences.dart'
    as _i17;
import '../../interaction_module/service/liked_service/liked_service.dart'
    as _i18;
import '../../games_module/service/games_list_service/games_list_service.dart'
    as _i19;
import '../../games_module/manager/games_manager/games_manager.dart' as _i20;
import '../../games_module/repository/games_repository/games_repository.dart'
    as _i21;
import '../../module_report/service/report_service/report_service.dart' as _i22;
import '../../module_report/manager/report_manager/report_manager.dart' as _i23;
import '../../interaction_module/manager/interaction/interaction_manger.dart'
    as _i24;
import '../../interaction_module/repository/interaction/interaction_repository.dart'
    as _i25;
import '../../games_module/ui/widget/game_card_list/game_card_list.dart'
    as _i26;
import '../../games_module/state_manager/games_list_state_manager/games_list_state_manager.dart'
    as _i27;
import '../../module_forms/ui/screen/add_by_api/add_by_api.dart' as _i28;
import '../../module_forms/state_manager/add_by_api_manager/add_by_api_manager.dart'
    as _i29;
import '../../module_forms/service/rawg_service/rawg_service.dart' as _i30;
import '../../module_forms/manager/rawg_manager/rawg_manager.dart' as _i31;
import '../../module_forms/repository/rawg_repository/rawg_repository.dart'
    as _i32;
import '../../interaction_module/ui/liked_screen/liked_screen.dart' as _i33;
import '../../interaction_module/state_manager/liked_manager/liked_state_manager.dart'
    as _i34;
import '../../module_settings/ui/ui/settings_page/settings_page.dart' as _i35;
import '../../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i36;
import '../../module_theme/service/theme_service/theme_service.dart' as _i37;
import '../../module_theme/pressistance/theme_preferences_helper.dart' as _i38;
import '../../module_notifications/ui/screens/notification_screen/notification_screen.dart'
    as _i39;
import '../../module_notifications/state_manager/notifications_state_manager/notifcations_list_state_manager.dart'
    as _i40;
import '../../module_notifications/service/notification_service/notification_service.dart'
    as _i41;
import '../../module_swap/service/swap_service/swap_service.dart' as _i42;
import '../../module_swap/manager/swap/swap_manager.dart' as _i43;
import '../../module_swap/repository/swap_repository/swap_repository.dart'
    as _i44;
import '../../module_profile/ui/profile_screen/profile_screen.dart' as _i45;
import '../../games_module/ui/widget/my_game_card_list/my_game_card_list.dart'
    as _i46;
import '../../module_forms/forms_module.dart' as _i47;
import '../../module_forms/ui/screen/add_by_image/add_by_image.dart' as _i48;
import '../../module_forms/state_manager/add_by_image_manager/add_by_image_manager.dart'
    as _i49;
import '../../module_forms/service/by_image_service/by_image_service.dart'
    as _i50;
import '../../module_upload/service/image_upload/image_upload_service.dart'
    as _i51;
import '../../module_upload/manager/upload_manager/upload_manager.dart' as _i52;
import '../../module_upload/repository/upload_repository/upload_repository.dart'
    as _i53;
import '../../module_forms/manager/swap_item_repository/swap_item_repository.dart'
    as _i54;
import '../../module_forms/repository/swap_item_respository/swap_item_repository.dart'
    as _i55;
import '../../games_module/games_module.dart' as _i56;
import '../../games_module/ui/widget/game_details/game_details.dart' as _i57;
import '../../games_module/state_manager/game_details_state_manager/game_details_list_manager.dart'
    as _i58;
import '../../module_comment/service/comment_service/comment_service.dart'
    as _i59;
import '../../module_comment/manager/comment_manager/comment_manager.dart'
    as _i60;
import '../../module_comment/repository/comment/comment_repository.dart'
    as _i61;
import '../../module_auth/auth_module.dart' as _i62;
import '../../module_auth/ui/screen/auth_screen/auth_screen.dart' as _i63;
import '../../module_auth/state_manager/auth_state_manager/auth_state_manager.dart'
    as _i64;
import '../../module_chat/chat_module.dart' as _i65;
import '../../module_chat/ui/screens/chat_page/chat_page.dart' as _i66;
import '../../module_chat/bloc/chat_page/chat_page.bloc.dart' as _i67;
import '../../module_chat/service/chat/char_service.dart' as _i68;
import '../../module_chat/manager/chat/chat_manager.dart' as _i69;
import '../../module_chat/repository/chat/chat_repository.dart' as _i70;
import '../../module_persistence/sharedpref/shared_preferences_helper.dart'
    as _i71;
import '../../camera/camera_module.dart' as _i72;
import '../../camera/ui/screen/camera_screen/camera_screen.dart' as _i73;
import '../../module_profile/profile_module.dart' as _i74;
import '../../module_profile/ui/my_profile/my_profile.dart' as _i75;
import '../../module_profile/state_manager/my_profile/my_profile_state_manager.dart'
    as _i76;
import '../../module_search/search_module.dart' as _i77;
import '../../module_search/ui/search_screen/search_screen.dart' as _i78;

class AppComponent$Injector implements _i1.AppComponent {
  AppComponent$Injector._();

  _i2.Logger _singletonLogger;

  _i3.LocalizationService _singletonLocalizationService;

  _i4.AuthGuard _singletonAuthGuard;

  static _i5.Future<_i1.AppComponent> create() async {
    final injector = AppComponent$Injector._();

    return injector;
  }

  _i6.MyApp _createMyApp() => _i6.MyApp(
      _createHomeModule(),
      _createFormsModule(),
      _createGamesModule(),
      _createAuthModule(),
      _createChatModule(),
      _createCameraModule(),
      _createProfileModule(),
      _createLocalizationService(),
      _createSwapThemeDataService(),
      _createSearchModule());
  _i7.HomeModule _createHomeModule() => _i7.HomeModule(_createHomeScreen());
  _i8.HomeScreen _createHomeScreen() => _i8.HomeScreen(
      _createAuthService(),
      _createProfileService(),
      _createGameCardList(),
      _createAddByApiScreen(),
      _createLikedScreen(),
      _createSettingsPage(),
      _createNotificationScreen(),
      _createProfileScreen());
  _i9.AuthService _createAuthService() =>
      _i9.AuthService(_createAuthPrefsHelper(), _createAuthManager());
  _i10.AuthPrefsHelper _createAuthPrefsHelper() => _i10.AuthPrefsHelper();
  _i11.AuthManager _createAuthManager() =>
      _i11.AuthManager(_createAuthRepository());
  _i12.AuthRepository _createAuthRepository() =>
      _i12.AuthRepository(_createApiClient());
  _i13.ApiClient _createApiClient() => _i13.ApiClient(_createLogger());
  _i2.Logger _createLogger() => _singletonLogger ??= _i2.Logger();
  _i14.ProfileService _createProfileService() => _i14.ProfileService(
      _createMyProfileManager(),
      _createProfileSharedPreferencesHelper(),
      _createAuthService(),
      _createLikedService(),
      _createGamesListService());
  _i15.MyProfileManager _createMyProfileManager() =>
      _i15.MyProfileManager(_createMyProfileRepository());
  _i16.MyProfileRepository _createMyProfileRepository() =>
      _i16.MyProfileRepository(_createApiClient());
  _i17.ProfileSharedPreferencesHelper _createProfileSharedPreferencesHelper() =>
      _i17.ProfileSharedPreferencesHelper();
  _i18.LikedService _createLikedService() => _i18.LikedService(
      _createAuthService(),
      _createGamesListService(),
      _createInteractionManager());
  _i19.GamesListService _createGamesListService() => _i19.GamesListService(
      _createGamesManager(),
      _createAuthService(),
      _createMyProfileManager(),
      _createReportService());
  _i20.GamesManager _createGamesManager() =>
      _i20.GamesManager(_createGamesRepository());
  _i21.GamesRepository _createGamesRepository() =>
      _i21.GamesRepository(_createApiClient(), _createAuthService());
  _i22.ReportService _createReportService() =>
      _i22.ReportService(_createAuthService(), _createReportManager());
  _i23.ReportManager _createReportManager() => _i23.ReportManager();
  _i24.InteractionManager _createInteractionManager() =>
      _i24.InteractionManager(_createInteractionRepository());
  _i25.InteractionRepository _createInteractionRepository() =>
      _i25.InteractionRepository(_createApiClient(), _createAuthService());
  _i26.GameCardList _createGameCardList() => _i26.GameCardList(
      _createGamesListStateManager(),
      _createAuthService(),
      _createReportService());
  _i27.GamesListStateManager _createGamesListStateManager() =>
      _i27.GamesListStateManager(_createGamesListService(),
          _createLikedService(), _createProfileService());
  _i28.AddByApiScreen _createAddByApiScreen() =>
      _i28.AddByApiScreen(_createAddByApiStateManager());
  _i29.AddByApiStateManager _createAddByApiStateManager() =>
      _i29.AddByApiStateManager(_createRawGService());
  _i30.RawGService _createRawGService() =>
      _i30.RawGService(_createRawGManager());
  _i31.RawGManager _createRawGManager() =>
      _i31.RawGManager(_createRawGRepository());
  _i32.RawGRepository _createRawGRepository() =>
      _i32.RawGRepository(_createApiClient());
  _i33.LikedScreen _createLikedScreen() => _i33.LikedScreen(
      _createLikedStateManager(),
      _createAuthService(),
      _createProfileService());
  _i34.LikedStateManager _createLikedStateManager() =>
      _i34.LikedStateManager(_createLikedService());
  _i35.SettingsPage _createSettingsPage() => _i35.SettingsPage(
      _createAuthService(),
      _createLocalizationService(),
      _createSwapThemeDataService());
  _i3.LocalizationService _createLocalizationService() =>
      _singletonLocalizationService ??=
          _i3.LocalizationService(_createLocalizationPreferencesHelper());
  _i36.LocalizationPreferencesHelper _createLocalizationPreferencesHelper() =>
      _i36.LocalizationPreferencesHelper();
  _i37.SwapThemeDataService _createSwapThemeDataService() =>
      _i37.SwapThemeDataService(_createThemePreferencesHelper());
  _i38.ThemePreferencesHelper _createThemePreferencesHelper() =>
      _i38.ThemePreferencesHelper();
  _i39.NotificationScreen _createNotificationScreen() =>
      _i39.NotificationScreen(
          _createNotificationsStateManager(),
          _createProfileService(),
          _createAuthService(),
          _createGamesListService());
  _i40.NotificationsStateManager _createNotificationsStateManager() =>
      _i40.NotificationsStateManager(
          _createNotificationService(), _createSwapService());
  _i41.NotificationService _createNotificationService() =>
      _i41.NotificationService(_createSwapService(), _createAuthService());
  _i42.SwapService _createSwapService() =>
      _i42.SwapService(_createAuthService(), _createSwapManager());
  _i43.SwapManager _createSwapManager() =>
      _i43.SwapManager(_createSwapRepository());
  _i44.SwapRepository _createSwapRepository() =>
      _i44.SwapRepository(_createApiClient());
  _i45.ProfileScreen _createProfileScreen() => _i45.ProfileScreen(
      _createMyGameCardList(),
      _createAuthService(),
      _createProfileService(),
      _createProfileSharedPreferencesHelper());
  _i46.MyGameCardList _createMyGameCardList() =>
      _i46.MyGameCardList(_createGamesListStateManager(), _createAuthService());
  _i47.FormsModule _createFormsModule() =>
      _i47.FormsModule(_createAddByImageScreen());
  _i48.AddByImageScreen _createAddByImageScreen() =>
      _i48.AddByImageScreen(_createAddByImageStateManager());
  _i49.AddByImageStateManager _createAddByImageStateManager() =>
      _i49.AddByImageStateManager(_createByImageService());
  _i50.ByImageService _createByImageService() => _i50.ByImageService(
      _createImageUploadService(),
      _createLogger(),
      _createSwapItemManager(),
      _createAuthService());
  _i51.ImageUploadService _createImageUploadService() =>
      _i51.ImageUploadService(_createUploadManager());
  _i52.UploadManager _createUploadManager() =>
      _i52.UploadManager(_createUploadRepository());
  _i53.UploadRepository _createUploadRepository() => _i53.UploadRepository();
  _i54.SwapItemManager _createSwapItemManager() =>
      _i54.SwapItemManager(_createSwapItemRepository());
  _i55.SwapItemRepository _createSwapItemRepository() =>
      _i55.SwapItemRepository(_createApiClient());
  _i56.GamesModule _createGamesModule() =>
      _i56.GamesModule(_createGameDetailsScreen());
  _i57.GameDetailsScreen _createGameDetailsScreen() => _i57.GameDetailsScreen(
      _createGameDetailsManager(),
      _createSwapService(),
      _createCommentService(),
      _createAuthService(),
      _createGameCardList(),
      _createProfileService());
  _i58.GameDetailsManager _createGameDetailsManager() =>
      _i58.GameDetailsManager(
          _createGamesListService(), _createReportService());
  _i59.CommentService _createCommentService() =>
      _i59.CommentService(_createAuthService(), _createCommentManager());
  _i60.CommentManager _createCommentManager() =>
      _i60.CommentManager(_createCommentRepository());
  _i61.CommentRepository _createCommentRepository() =>
      _i61.CommentRepository(_createApiClient());
  _i62.AuthModule _createAuthModule() => _i62.AuthModule(_createAuthScreen());
  _i63.AuthScreen _createAuthScreen() =>
      _i63.AuthScreen(_createAuthStateManager());
  _i64.AuthStateManager _createAuthStateManager() =>
      _i64.AuthStateManager(_createAuthService());
  _i65.ChatModule _createChatModule() =>
      _i65.ChatModule(_createChatPage(), _createAuthGuard());
  _i66.ChatPage _createChatPage() => _i66.ChatPage(
      _createChatPageBloc(),
      _createAuthService(),
      _createGamesListService(),
      _createSwapService(),
      _createImageUploadService());
  _i67.ChatPageBloc _createChatPageBloc() => _i67.ChatPageBloc(
      _createChatService(), _createSwapService(), _createNotificationService());
  _i68.ChatService _createChatService() =>
      _i68.ChatService(_createChatManager());
  _i69.ChatManager _createChatManager() =>
      _i69.ChatManager(_createChatRepository());
  _i70.ChatRepository _createChatRepository() => _i70.ChatRepository();
  _i4.AuthGuard _createAuthGuard() =>
      _singletonAuthGuard ??= _i4.AuthGuard(_createSharedPreferencesHelper());
  _i71.SharedPreferencesHelper _createSharedPreferencesHelper() =>
      _i71.SharedPreferencesHelper();
  _i72.CameraModule _createCameraModule() =>
      _i72.CameraModule(_createCameraScreen());
  _i73.CameraScreen _createCameraScreen() => _i73.CameraScreen();
  _i74.ProfileModule _createProfileModule() =>
      _i74.ProfileModule(_createMyProfileScreen());
  _i75.MyProfileScreen _createMyProfileScreen() =>
      _i75.MyProfileScreen(_createMyProfileStateManager());
  _i76.MyProfileStateManager _createMyProfileStateManager() =>
      _i76.MyProfileStateManager(
          _createImageUploadService(), _createProfileService());
  _i77.SearchModule _createSearchModule() =>
      _i77.SearchModule(_createSearchScreen());
  _i78.SearchScreen _createSearchScreen() =>
      _i78.SearchScreen(_createGamesListStateManager(), _createAuthService());
  @override
  _i6.MyApp get app => _createMyApp();
}
