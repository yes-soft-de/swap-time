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
import '../../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i14;
import '../../module_notifications/presistance/notification_prefs.dart' as _i15;
import '../../module_profile/service/profile/profile.dart' as _i16;
import '../../module_profile/manager/my_profile_manager/my_profile_manager.dart'
    as _i17;
import '../../module_profile/repository/my_profile/my_profile.dart' as _i18;
import '../../module_profile/presistance/profile_shared_preferences.dart'
    as _i19;
import '../../interaction_module/service/liked_service/liked_service.dart'
    as _i20;
import '../../games_module/service/games_list_service/games_list_service.dart'
    as _i21;
import '../../games_module/manager/games_manager/games_manager.dart' as _i22;
import '../../games_module/repository/games_repository/games_repository.dart'
    as _i23;
import '../../module_report/service/report_service/report_service.dart' as _i24;
import '../../module_report/manager/report_manager/report_manager.dart' as _i25;
import '../../module_report/repository/report_repository/report_repository.dart'
    as _i26;
import '../../interaction_module/manager/interaction/interaction_manger.dart'
    as _i27;
import '../../interaction_module/repository/interaction/interaction_repository.dart'
    as _i28;
import '../../games_module/ui/widget/game_card_list/game_card_list.dart'
    as _i29;
import '../../games_module/state_manager/games_list_state_manager/games_list_state_manager.dart'
    as _i30;
import '../../module_forms/ui/screen/add_by_api/add_by_api.dart' as _i31;
import '../../module_forms/state_manager/add_by_api_manager/add_by_api_manager.dart'
    as _i32;
import '../../module_forms/service/rawg_service/rawg_service.dart' as _i33;
import '../../module_forms/manager/rawg_manager/rawg_manager.dart' as _i34;
import '../../module_forms/repository/rawg_repository/rawg_repository.dart'
    as _i35;
import '../../interaction_module/ui/liked_screen/liked_screen.dart' as _i36;
import '../../interaction_module/state_manager/liked_manager/liked_state_manager.dart'
    as _i37;
import '../../module_settings/ui/ui/settings_page/settings_page.dart' as _i38;
import '../../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i39;
import '../../module_theme/service/theme_service/theme_service.dart' as _i40;
import '../../module_theme/pressistance/theme_preferences_helper.dart' as _i41;
import '../../module_notifications/ui/screens/notification_screen/notification_screen.dart'
    as _i42;
import '../../module_notifications/state_manager/notifications_state_manager/notifcations_list_state_manager.dart'
    as _i43;
import '../../module_notifications/service/notification_service/notification_service.dart'
    as _i44;
import '../../module_swap/service/swap_service/swap_service.dart' as _i45;
import '../../module_swap/manager/swap/swap_manager.dart' as _i46;
import '../../module_swap/repository/swap_repository/swap_repository.dart'
    as _i47;
import '../../module_profile/ui/profile_screen/profile_screen.dart' as _i48;
import '../../games_module/ui/widget/my_game_card_list/my_game_card_list.dart'
    as _i49;
import '../../module_forms/forms_module.dart' as _i50;
import '../../module_forms/ui/screen/add_by_image/add_by_image.dart' as _i51;
import '../../module_forms/state_manager/add_by_image_manager/add_by_image_manager.dart'
    as _i52;
import '../../module_forms/service/by_image_service/by_image_service.dart'
    as _i53;
import '../../module_upload/service/image_upload/image_upload_service.dart'
    as _i54;
import '../../module_upload/manager/upload_manager/upload_manager.dart' as _i55;
import '../../module_upload/repository/upload_repository/upload_repository.dart'
    as _i56;
import '../../module_forms/manager/swap_item_repository/swap_item_repository.dart'
    as _i57;
import '../../module_forms/repository/swap_item_respository/swap_item_repository.dart'
    as _i58;
import '../../games_module/games_module.dart' as _i59;
import '../../games_module/ui/widget/game_details/game_details.dart' as _i60;
import '../../games_module/state_manager/game_details_state_manager/game_details_list_manager.dart'
    as _i61;
import '../../module_comment/service/comment_service/comment_service.dart'
    as _i62;
import '../../module_comment/manager/comment_manager/comment_manager.dart'
    as _i63;
import '../../module_comment/repository/comment/comment_repository.dart'
    as _i64;
import '../../module_swap/ui/widget/restrict_acceess_dialog/restrict_acceess_dialog.dart'
    as _i65;
import '../../module_auth/auth_module.dart' as _i66;
import '../../module_auth/ui/screen/auth_screen/auth_screen.dart' as _i67;
import '../../module_auth/state_manager/auth_state_manager/auth_state_manager.dart'
    as _i68;
import '../../module_chat/chat_module.dart' as _i69;
import '../../module_chat/ui/screens/chat_page/chat_page.dart' as _i70;
import '../../module_chat/bloc/chat_page/chat_page.bloc.dart' as _i71;
import '../../module_chat/service/chat/char_service.dart' as _i72;
import '../../module_chat/manager/chat/chat_manager.dart' as _i73;
import '../../module_chat/repository/chat/chat_repository.dart' as _i74;
import '../../module_persistence/sharedpref/shared_preferences_helper.dart'
    as _i75;
import '../../camera/camera_module.dart' as _i76;
import '../../camera/ui/screen/camera_screen/camera_screen.dart' as _i77;
import '../../module_profile/profile_module.dart' as _i78;
import '../../module_profile/ui/my_profile/my_profile.dart' as _i79;
import '../../module_profile/state_manager/my_profile/my_profile_state_manager.dart'
    as _i80;
import '../../module_search/search_module.dart' as _i81;
import '../../module_search/ui/search_screen/search_screen.dart' as _i82;

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
      _createSearchModule(),
      _createFireNotificationService());
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
  _i9.AuthService _createAuthService() => _i9.AuthService(
      _createAuthPrefsHelper(),
      _createAuthManager(),
      _createFireNotificationService());
  _i10.AuthPrefsHelper _createAuthPrefsHelper() => _i10.AuthPrefsHelper();
  _i11.AuthManager _createAuthManager() =>
      _i11.AuthManager(_createAuthRepository());
  _i12.AuthRepository _createAuthRepository() =>
      _i12.AuthRepository(_createApiClient());
  _i13.ApiClient _createApiClient() => _i13.ApiClient(_createLogger());
  _i2.Logger _createLogger() => _singletonLogger ??= _i2.Logger();
  _i14.FireNotificationService _createFireNotificationService() =>
      _i14.FireNotificationService(
          _createNotificationPrefs(), _createApiClient());
  _i15.NotificationPrefs _createNotificationPrefs() => _i15.NotificationPrefs();
  _i16.ProfileService _createProfileService() => _i16.ProfileService(
      _createMyProfileManager(),
      _createProfileSharedPreferencesHelper(),
      _createAuthService(),
      _createLikedService(),
      _createGamesListService());
  _i17.MyProfileManager _createMyProfileManager() =>
      _i17.MyProfileManager(_createMyProfileRepository());
  _i18.MyProfileRepository _createMyProfileRepository() =>
      _i18.MyProfileRepository(_createApiClient());
  _i19.ProfileSharedPreferencesHelper _createProfileSharedPreferencesHelper() =>
      _i19.ProfileSharedPreferencesHelper();
  _i20.LikedService _createLikedService() => _i20.LikedService(
      _createAuthService(),
      _createGamesListService(),
      _createInteractionManager());
  _i21.GamesListService _createGamesListService() => _i21.GamesListService(
      _createGamesManager(),
      _createAuthService(),
      _createMyProfileManager(),
      _createReportService());
  _i22.GamesManager _createGamesManager() =>
      _i22.GamesManager(_createGamesRepository());
  _i23.GamesRepository _createGamesRepository() =>
      _i23.GamesRepository(_createApiClient(), _createAuthService());
  _i24.ReportService _createReportService() =>
      _i24.ReportService(_createAuthService(), _createReportManager());
  _i25.ReportManager _createReportManager() =>
      _i25.ReportManager(_createReportRepository());
  _i26.ReportRepository _createReportRepository() =>
      _i26.ReportRepository(_createApiClient());
  _i27.InteractionManager _createInteractionManager() =>
      _i27.InteractionManager(_createInteractionRepository());
  _i28.InteractionRepository _createInteractionRepository() =>
      _i28.InteractionRepository(_createApiClient(), _createAuthService());
  _i29.GameCardList _createGameCardList() => _i29.GameCardList(
      _createGamesListStateManager(),
      _createAuthService(),
      _createReportService());
  _i30.GamesListStateManager _createGamesListStateManager() =>
      _i30.GamesListStateManager(_createGamesListService(),
          _createLikedService(), _createProfileService());
  _i31.AddByApiScreen _createAddByApiScreen() =>
      _i31.AddByApiScreen(_createAddByApiStateManager());
  _i32.AddByApiStateManager _createAddByApiStateManager() =>
      _i32.AddByApiStateManager(_createRawGService());
  _i33.RawGService _createRawGService() =>
      _i33.RawGService(_createRawGManager());
  _i34.RawGManager _createRawGManager() =>
      _i34.RawGManager(_createRawGRepository());
  _i35.RawGRepository _createRawGRepository() =>
      _i35.RawGRepository(_createApiClient());
  _i36.LikedScreen _createLikedScreen() => _i36.LikedScreen(
      _createLikedStateManager(),
      _createAuthService(),
      _createProfileService());
  _i37.LikedStateManager _createLikedStateManager() =>
      _i37.LikedStateManager(_createLikedService());
  _i38.SettingsPage _createSettingsPage() => _i38.SettingsPage(
      _createAuthService(),
      _createLocalizationService(),
      _createSwapThemeDataService());
  _i3.LocalizationService _createLocalizationService() =>
      _singletonLocalizationService ??=
          _i3.LocalizationService(_createLocalizationPreferencesHelper());
  _i39.LocalizationPreferencesHelper _createLocalizationPreferencesHelper() =>
      _i39.LocalizationPreferencesHelper();
  _i40.SwapThemeDataService _createSwapThemeDataService() =>
      _i40.SwapThemeDataService(_createThemePreferencesHelper());
  _i41.ThemePreferencesHelper _createThemePreferencesHelper() =>
      _i41.ThemePreferencesHelper();
  _i42.NotificationScreen _createNotificationScreen() =>
      _i42.NotificationScreen(
          _createNotificationsStateManager(),
          _createProfileService(),
          _createAuthService(),
          _createGamesListService());
  _i43.NotificationsStateManager _createNotificationsStateManager() =>
      _i43.NotificationsStateManager(
          _createNotificationService(), _createSwapService());
  _i44.NotificationService _createNotificationService() =>
      _i44.NotificationService(_createSwapService(), _createAuthService());
  _i45.SwapService _createSwapService() =>
      _i45.SwapService(_createAuthService(), _createSwapManager());
  _i46.SwapManager _createSwapManager() =>
      _i46.SwapManager(_createSwapRepository());
  _i47.SwapRepository _createSwapRepository() =>
      _i47.SwapRepository(_createApiClient());
  _i48.ProfileScreen _createProfileScreen() => _i48.ProfileScreen(
      _createMyGameCardList(),
      _createAuthService(),
      _createProfileService(),
      _createProfileSharedPreferencesHelper());
  _i49.MyGameCardList _createMyGameCardList() =>
      _i49.MyGameCardList(_createGamesListStateManager(), _createAuthService());
  _i50.FormsModule _createFormsModule() =>
      _i50.FormsModule(_createAddByImageScreen());
  _i51.AddByImageScreen _createAddByImageScreen() =>
      _i51.AddByImageScreen(_createAddByImageStateManager());
  _i52.AddByImageStateManager _createAddByImageStateManager() =>
      _i52.AddByImageStateManager(_createByImageService());
  _i53.ByImageService _createByImageService() => _i53.ByImageService(
      _createImageUploadService(),
      _createLogger(),
      _createSwapItemManager(),
      _createAuthService());
  _i54.ImageUploadService _createImageUploadService() =>
      _i54.ImageUploadService(_createUploadManager());
  _i55.UploadManager _createUploadManager() =>
      _i55.UploadManager(_createUploadRepository());
  _i56.UploadRepository _createUploadRepository() => _i56.UploadRepository();
  _i57.SwapItemManager _createSwapItemManager() =>
      _i57.SwapItemManager(_createSwapItemRepository());
  _i58.SwapItemRepository _createSwapItemRepository() =>
      _i58.SwapItemRepository(_createApiClient());
  _i59.GamesModule _createGamesModule() =>
      _i59.GamesModule(_createGameDetailsScreen());
  _i60.GameDetailsScreen _createGameDetailsScreen() => _i60.GameDetailsScreen(
      _createGameDetailsManager(),
      _createSwapService(),
      _createCommentService(),
      _createAuthService(),
      _createGameCardList(),
      _createProfileService(),
      _createRestrictAccessDialog());
  _i61.GameDetailsManager _createGameDetailsManager() =>
      _i61.GameDetailsManager(
          _createGamesListService(), _createReportService());
  _i62.CommentService _createCommentService() =>
      _i62.CommentService(_createAuthService(), _createCommentManager());
  _i63.CommentManager _createCommentManager() =>
      _i63.CommentManager(_createCommentRepository());
  _i64.CommentRepository _createCommentRepository() =>
      _i64.CommentRepository(_createApiClient());
  _i65.RestrictAccessDialog _createRestrictAccessDialog() =>
      _i65.RestrictAccessDialog(_createGamesListService());
  _i66.AuthModule _createAuthModule() => _i66.AuthModule(_createAuthScreen());
  _i67.AuthScreen _createAuthScreen() =>
      _i67.AuthScreen(_createAuthStateManager());
  _i68.AuthStateManager _createAuthStateManager() =>
      _i68.AuthStateManager(_createAuthService());
  _i69.ChatModule _createChatModule() =>
      _i69.ChatModule(_createChatPage(), _createAuthGuard());
  _i70.ChatPage _createChatPage() => _i70.ChatPage(
      _createChatPageBloc(),
      _createAuthService(),
      _createGamesListService(),
      _createSwapService(),
      _createImageUploadService());
  _i71.ChatPageBloc _createChatPageBloc() => _i71.ChatPageBloc(
      _createChatService(), _createSwapService(), _createNotificationService());
  _i72.ChatService _createChatService() =>
      _i72.ChatService(_createChatManager());
  _i73.ChatManager _createChatManager() =>
      _i73.ChatManager(_createChatRepository());
  _i74.ChatRepository _createChatRepository() => _i74.ChatRepository();
  _i4.AuthGuard _createAuthGuard() =>
      _singletonAuthGuard ??= _i4.AuthGuard(_createSharedPreferencesHelper());
  _i75.SharedPreferencesHelper _createSharedPreferencesHelper() =>
      _i75.SharedPreferencesHelper();
  _i76.CameraModule _createCameraModule() =>
      _i76.CameraModule(_createCameraScreen());
  _i77.CameraScreen _createCameraScreen() => _i77.CameraScreen();
  _i78.ProfileModule _createProfileModule() =>
      _i78.ProfileModule(_createMyProfileScreen());
  _i79.MyProfileScreen _createMyProfileScreen() =>
      _i79.MyProfileScreen(_createMyProfileStateManager());
  _i80.MyProfileStateManager _createMyProfileStateManager() =>
      _i80.MyProfileStateManager(
          _createImageUploadService(), _createProfileService());
  _i81.SearchModule _createSearchModule() =>
      _i81.SearchModule(_createSearchScreen());
  _i82.SearchScreen _createSearchScreen() =>
      _i82.SearchScreen(_createGamesListStateManager(), _createAuthService());
  @override
  _i6.MyApp get app => _createMyApp();
}
