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
import '../../games_module/ui/widget/game_card_list/game_card_list.dart'
    as _i18;
import '../../games_module/state_manager/games_list_state_manager/games_list_state_manager.dart'
    as _i19;
import '../../games_module/service/games_list_service/games_list_service.dart'
    as _i20;
import '../../games_module/manager/games_manager/games_manager.dart' as _i21;
import '../../games_module/repository/games_repository/games_repository.dart'
    as _i22;
import '../../interaction_module/service/liked_service/liked_service.dart'
    as _i23;
import '../../interaction_module/manager/interaction/interaction_manger.dart'
    as _i24;
import '../../interaction_module/repository/interaction/interaction_repository.dart'
    as _i25;
import '../../module_forms/ui/screen/add_by_api/add_by_api.dart' as _i26;
import '../../module_forms/state_manager/add_by_api_manager/add_by_api_manager.dart'
    as _i27;
import '../../module_forms/service/rawg_service/rawg_service.dart' as _i28;
import '../../module_forms/manager/rawg_manager/rawg_manager.dart' as _i29;
import '../../module_forms/repository/rawg_repository/rawg_repository.dart'
    as _i30;
import '../../interaction_module/ui/liked_screen/liked_screen.dart' as _i31;
import '../../interaction_module/state_manager/liked_manager/liked_state_manager.dart'
    as _i32;
import '../../module_settings/ui/ui/settings_page/settings_page.dart' as _i33;
import '../../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i34;
import '../../module_theme/service/theme_service/theme_service.dart' as _i35;
import '../../module_theme/pressistance/theme_preferences_helper.dart' as _i36;
import '../../module_notifications/ui/screens/notification_screen/notification_screen.dart'
    as _i37;
import '../../module_notifications/state_manager/notifications_state_manager/notifcations_list_state_manager.dart'
    as _i38;
import '../../module_notifications/service/notification_service/notification_service.dart'
    as _i39;
import '../../module_swap/service/swap_service/swap_service.dart' as _i40;
import '../../module_swap/manager/swap/swap_manager.dart' as _i41;
import '../../module_swap/repository/swap_repository/swap_repository.dart'
    as _i42;
import '../../module_profile/ui/profile_screen/profile_screen.dart' as _i43;
import '../../module_forms/forms_module.dart' as _i44;
import '../../module_forms/ui/screen/add_by_image/add_by_image.dart' as _i45;
import '../../module_forms/state_manager/add_by_image_manager/add_by_image_manager.dart'
    as _i46;
import '../../module_forms/service/by_image_service/by_image_service.dart'
    as _i47;
import '../../module_upload/service/image_upload/image_upload_service.dart'
    as _i48;
import '../../module_upload/manager/upload_manager/upload_manager.dart' as _i49;
import '../../module_upload/repository/upload_repository/upload_repository.dart'
    as _i50;
import '../../module_forms/manager/swap_item_repository/swap_item_repository.dart'
    as _i51;
import '../../module_forms/repository/swap_item_respository/swap_item_repository.dart'
    as _i52;
import '../../games_module/games_module.dart' as _i53;
import '../../games_module/ui/widget/game_details/game_details.dart' as _i54;
import '../../games_module/state_manager/game_details_state_manager/game_details_list_manager.dart'
    as _i55;
import '../../module_comment/service/comment_service/comment_service.dart'
    as _i56;
import '../../module_comment/manager/comment_manager/comment_manager.dart'
    as _i57;
import '../../module_comment/repository/comment/comment_repository.dart'
    as _i58;
import '../../module_auth/auth_module.dart' as _i59;
import '../../module_auth/ui/screen/auth_screen/auth_screen.dart' as _i60;
import '../../module_auth/state_manager/auth_state_manager/auth_state_manager.dart'
    as _i61;
import '../../module_chat/chat_module.dart' as _i62;
import '../../module_chat/ui/screens/chat_page/chat_page.dart' as _i63;
import '../../module_chat/bloc/chat_page/chat_page.bloc.dart' as _i64;
import '../../module_chat/service/chat/char_service.dart' as _i65;
import '../../module_chat/manager/chat/chat_manager.dart' as _i66;
import '../../module_chat/repository/chat/chat_repository.dart' as _i67;
import '../../module_persistence/sharedpref/shared_preferences_helper.dart'
    as _i68;
import '../../camera/camera_module.dart' as _i69;
import '../../camera/ui/screen/camera_screen/camera_screen.dart' as _i70;
import '../../module_profile/profile_module.dart' as _i71;
import '../../module_profile/ui/my_profile/my_profile.dart' as _i72;
import '../../module_profile/state_manager/my_profile/my_profile_state_manager.dart'
    as _i73;

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
      _createSwapThemeDataService());
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
      _createAuthService());
  _i15.MyProfileManager _createMyProfileManager() =>
      _i15.MyProfileManager(_createMyProfileRepository());
  _i16.MyProfileRepository _createMyProfileRepository() =>
      _i16.MyProfileRepository(_createApiClient());
  _i17.ProfileSharedPreferencesHelper _createProfileSharedPreferencesHelper() =>
      _i17.ProfileSharedPreferencesHelper();
  _i18.GameCardList _createGameCardList() =>
      _i18.GameCardList(_createGamesListStateManager(), _createAuthService());
  _i19.GamesListStateManager _createGamesListStateManager() =>
      _i19.GamesListStateManager(_createGamesListService(),
          _createLikedService(), _createProfileService());
  _i20.GamesListService _createGamesListService() => _i20.GamesListService(
      _createGamesManager(), _createAuthService(), _createMyProfileManager());
  _i21.GamesManager _createGamesManager() =>
      _i21.GamesManager(_createGamesRepository());
  _i22.GamesRepository _createGamesRepository() =>
      _i22.GamesRepository(_createApiClient(), _createAuthService());
  _i23.LikedService _createLikedService() => _i23.LikedService(
      _createAuthService(),
      _createGamesListService(),
      _createInteractionManager());
  _i24.InteractionManager _createInteractionManager() =>
      _i24.InteractionManager(_createInteractionRepository());
  _i25.InteractionRepository _createInteractionRepository() =>
      _i25.InteractionRepository(_createApiClient());
  _i26.AddByApiScreen _createAddByApiScreen() =>
      _i26.AddByApiScreen(_createAddByApiStateManager());
  _i27.AddByApiStateManager _createAddByApiStateManager() =>
      _i27.AddByApiStateManager(_createRawGService());
  _i28.RawGService _createRawGService() =>
      _i28.RawGService(_createRawGManager());
  _i29.RawGManager _createRawGManager() =>
      _i29.RawGManager(_createRawGRepository());
  _i30.RawGRepository _createRawGRepository() =>
      _i30.RawGRepository(_createApiClient());
  _i31.LikedScreen _createLikedScreen() => _i31.LikedScreen(
      _createLikedStateManager(),
      _createAuthService(),
      _createProfileService());
  _i32.LikedStateManager _createLikedStateManager() =>
      _i32.LikedStateManager(_createLikedService());
  _i33.SettingsPage _createSettingsPage() => _i33.SettingsPage(
      _createAuthService(),
      _createLocalizationService(),
      _createSwapThemeDataService());
  _i3.LocalizationService _createLocalizationService() =>
      _singletonLocalizationService ??=
          _i3.LocalizationService(_createLocalizationPreferencesHelper());
  _i34.LocalizationPreferencesHelper _createLocalizationPreferencesHelper() =>
      _i34.LocalizationPreferencesHelper();
  _i35.SwapThemeDataService _createSwapThemeDataService() =>
      _i35.SwapThemeDataService(_createThemePreferencesHelper());
  _i36.ThemePreferencesHelper _createThemePreferencesHelper() =>
      _i36.ThemePreferencesHelper();
  _i37.NotificationScreen _createNotificationScreen() =>
      _i37.NotificationScreen(
          _createNotificationsStateManager(),
          _createProfileService(),
          _createAuthService(),
          _createGamesListService(),
          _createSwapService());
  _i38.NotificationsStateManager _createNotificationsStateManager() =>
      _i38.NotificationsStateManager(
          _createNotificationService(), _createSwapService());
  _i39.NotificationService _createNotificationService() =>
      _i39.NotificationService(_createAuthService(), _createGamesListService(),
          _createSwapService());
  _i40.SwapService _createSwapService() => _i40.SwapService(
      _createAuthService(), _createSwapManager(), _createGamesListService());
  _i41.SwapManager _createSwapManager() =>
      _i41.SwapManager(_createSwapRepository());
  _i42.SwapRepository _createSwapRepository() =>
      _i42.SwapRepository(_createApiClient());
  _i43.ProfileScreen _createProfileScreen() => _i43.ProfileScreen(
      _createGameCardList(),
      _createAuthService(),
      _createProfileService(),
      _createProfileSharedPreferencesHelper());
  _i44.FormsModule _createFormsModule() =>
      _i44.FormsModule(_createAddByImageScreen());
  _i45.AddByImageScreen _createAddByImageScreen() =>
      _i45.AddByImageScreen(_createAddByImageStateManager());
  _i46.AddByImageStateManager _createAddByImageStateManager() =>
      _i46.AddByImageStateManager(_createByImageService());
  _i47.ByImageService _createByImageService() => _i47.ByImageService(
      _createImageUploadService(),
      _createLogger(),
      _createSwapItemManager(),
      _createAuthService());
  _i48.ImageUploadService _createImageUploadService() =>
      _i48.ImageUploadService(_createUploadManager());
  _i49.UploadManager _createUploadManager() =>
      _i49.UploadManager(_createUploadRepository());
  _i50.UploadRepository _createUploadRepository() => _i50.UploadRepository();
  _i51.SwapItemManager _createSwapItemManager() =>
      _i51.SwapItemManager(_createSwapItemRepository());
  _i52.SwapItemRepository _createSwapItemRepository() =>
      _i52.SwapItemRepository(_createApiClient());
  _i53.GamesModule _createGamesModule() =>
      _i53.GamesModule(_createGameDetailsScreen());
  _i54.GameDetailsScreen _createGameDetailsScreen() => _i54.GameDetailsScreen(
      _createGameDetailsManager(),
      _createSwapService(),
      _createCommentService(),
      _createAuthService(),
      _createGameCardList());
  _i55.GameDetailsManager _createGameDetailsManager() =>
      _i55.GameDetailsManager(_createGamesListService());
  _i56.CommentService _createCommentService() =>
      _i56.CommentService(_createAuthService(), _createCommentManager());
  _i57.CommentManager _createCommentManager() =>
      _i57.CommentManager(_createCommentRepository());
  _i58.CommentRepository _createCommentRepository() =>
      _i58.CommentRepository(_createApiClient());
  _i59.AuthModule _createAuthModule() => _i59.AuthModule(_createAuthScreen());
  _i60.AuthScreen _createAuthScreen() =>
      _i60.AuthScreen(_createAuthStateManager());
  _i61.AuthStateManager _createAuthStateManager() =>
      _i61.AuthStateManager(_createAuthService());
  _i62.ChatModule _createChatModule() =>
      _i62.ChatModule(_createChatPage(), _createAuthGuard());
  _i63.ChatPage _createChatPage() => _i63.ChatPage(_createChatPageBloc());
  _i64.ChatPageBloc _createChatPageBloc() =>
      _i64.ChatPageBloc(_createChatService());
  _i65.ChatService _createChatService() =>
      _i65.ChatService(_createChatManager());
  _i66.ChatManager _createChatManager() =>
      _i66.ChatManager(_createChatRepository());
  _i67.ChatRepository _createChatRepository() => _i67.ChatRepository();
  _i4.AuthGuard _createAuthGuard() =>
      _singletonAuthGuard ??= _i4.AuthGuard(_createSharedPreferencesHelper());
  _i68.SharedPreferencesHelper _createSharedPreferencesHelper() =>
      _i68.SharedPreferencesHelper();
  _i69.CameraModule _createCameraModule() =>
      _i69.CameraModule(_createCameraScreen());
  _i70.CameraScreen _createCameraScreen() => _i70.CameraScreen();
  _i71.ProfileModule _createProfileModule() =>
      _i71.ProfileModule(_createMyProfileScreen());
  _i72.MyProfileScreen _createMyProfileScreen() =>
      _i72.MyProfileScreen(_createMyProfileStateManager());
  _i73.MyProfileStateManager _createMyProfileStateManager() =>
      _i73.MyProfileStateManager(
          _createImageUploadService(), _createProfileService());
  @override
  _i6.MyApp get app => _createMyApp();
}
