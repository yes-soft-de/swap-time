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
import '../../module_profile/service/my_profile/my_profile.dart' as _i11;
import '../../module_profile/manager/my_profile_manager/my_profile_manager.dart'
    as _i12;
import '../../module_profile/repository/my_profile/my_profile.dart' as _i13;
import '../../module_network/http_client/http_client.dart' as _i14;
import '../../module_profile/presistance/profile_shared_preferences.dart'
    as _i15;
import '../../module_profile/service/general_profile/general_profile.dart'
    as _i16;
import '../../games_module/ui/widget/game_card_list/game_card_list.dart'
    as _i17;
import '../../games_module/state_manager/games_list_state_manager/games_list_state_manager.dart'
    as _i18;
import '../../games_module/service/games_list_service/games_list_service.dart'
    as _i19;
import '../../games_module/manager/games_manager/games_manager.dart' as _i20;
import '../../games_module/repository/games_repository/games_repository.dart'
    as _i21;
import '../../liked_module/service/liked_service/liked_service.dart' as _i22;
import '../../module_forms/ui/screen/add_by_api/add_by_api.dart' as _i23;
import '../../module_forms/state_manager/add_by_api_manager/add_by_api_manager.dart'
    as _i24;
import '../../module_forms/service/rawg_service/rawg_service.dart' as _i25;
import '../../module_forms/manager/rawg_manager/rawg_manager.dart' as _i26;
import '../../module_forms/repository/rawg_repository/rawg_repository.dart'
    as _i27;
import '../../liked_module/ui/liked_screen/liked_screen.dart' as _i28;
import '../../liked_module/state_manager/liked_manager/liked_state_manager.dart'
    as _i29;
import '../../module_settings/ui/ui/settings_page/settings_page.dart' as _i30;
import '../../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i31;
import '../../module_theme/service/theme_service/theme_service.dart' as _i32;
import '../../module_theme/pressistance/theme_preferences_helper.dart' as _i33;
import '../../module_notifications/ui/screens/notification_screen/notification_screen.dart'
    as _i34;
import '../../module_notifications/state_manager/notifications_state_manager/notifcations_list_state_manager.dart'
    as _i35;
import '../../module_notifications/service/notification_service/notification_service.dart'
    as _i36;
import '../../module_swap/service/swap_service/swap_service.dart' as _i37;
import '../../module_profile/ui/profile_screen/profile_screen.dart' as _i38;
import '../../module_forms/forms_module.dart' as _i39;
import '../../module_forms/ui/screen/add_by_image/add_by_image.dart' as _i40;
import '../../module_forms/state_manager/add_by_image_manager/add_by_image_manager.dart'
    as _i41;
import '../../module_forms/service/by_image_service/by_image_service.dart'
    as _i42;
import '../../module_upload/service/image_upload/image_upload_service.dart'
    as _i43;
import '../../module_upload/manager/upload_manager/upload_manager.dart' as _i44;
import '../../module_upload/repository/upload_repository/upload_repository.dart'
    as _i45;
import '../../module_forms/manager/swap_item_repository/swap_item_repository.dart'
    as _i46;
import '../../module_forms/repository/swap_item_respository/swap_item_repository.dart'
    as _i47;
import '../../games_module/games_module.dart' as _i48;
import '../../games_module/ui/widget/game_details/game_details.dart' as _i49;
import '../../games_module/state_manager/game_details_state_manager/game_details_list_manager.dart'
    as _i50;
import '../../module_comment/ui/widget/comments_list_widget/comment_list_widget.dart'
    as _i51;
import '../../module_comment/state_manager/comment_state_manager/comment_state_manager.dart'
    as _i52;
import '../../module_comment/service/comment_service/comment_service.dart'
    as _i53;
import '../../module_auth/auth_module.dart' as _i54;
import '../../module_auth/ui/screen/auth_screen/auth_screen.dart' as _i55;
import '../../module_auth/state_manager/auth_state_manager/auth_state_manager.dart'
    as _i56;
import '../../module_chat/chat_module.dart' as _i57;
import '../../module_chat/ui/screens/chat_page/chat_page.dart' as _i58;
import '../../module_chat/bloc/chat_page/chat_page.bloc.dart' as _i59;
import '../../module_chat/service/chat/char_service.dart' as _i60;
import '../../module_chat/manager/chat/chat_manager.dart' as _i61;
import '../../module_chat/repository/chat/chat_repository.dart' as _i62;
import '../../module_persistence/sharedpref/shared_preferences_helper.dart'
    as _i63;
import '../../camera/camera_module.dart' as _i64;
import '../../camera/ui/screen/camera_screen/camera_screen.dart' as _i65;
import '../../module_profile/profile_module.dart' as _i66;
import '../../module_profile/ui/my_profile/my_profile.dart' as _i67;
import '../../module_profile/state_manager/my_profile/my_profile_state_manager.dart'
    as _i68;

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
      _createMyProfileService(),
      _createGameCardList(),
      _createAddByApiScreen(),
      _createLikedScreen(),
      _createSettingsPage(),
      _createNotificationScreen(),
      _createProfileScreen());
  _i9.AuthService _createAuthService() =>
      _i9.AuthService(_createAuthPrefsHelper());
  _i10.AuthPrefsHelper _createAuthPrefsHelper() => _i10.AuthPrefsHelper();
  _i11.MyProfileService _createMyProfileService() => _i11.MyProfileService(
      _createMyProfileManager(),
      _createProfileSharedPreferencesHelper(),
      _createAuthService(),
      _createGeneralProfileService());
  _i12.MyProfileManager _createMyProfileManager() =>
      _i12.MyProfileManager(_createMyProfileRepository());
  _i13.MyProfileRepository _createMyProfileRepository() =>
      _i13.MyProfileRepository(_createApiClient());
  _i14.ApiClient _createApiClient() => _i14.ApiClient(_createLogger());
  _i2.Logger _createLogger() => _singletonLogger ??= _i2.Logger();
  _i15.ProfileSharedPreferencesHelper _createProfileSharedPreferencesHelper() =>
      _i15.ProfileSharedPreferencesHelper();
  _i16.GeneralProfileService _createGeneralProfileService() =>
      _i16.GeneralProfileService();
  _i17.GameCardList _createGameCardList() =>
      _i17.GameCardList(_createGamesListStateManager());
  _i18.GamesListStateManager _createGamesListStateManager() =>
      _i18.GamesListStateManager(_createGamesListService(),
          _createLikedService(), _createGeneralProfileService());
  _i19.GamesListService _createGamesListService() =>
      _i19.GamesListService(_createGamesManager(), _createAuthService());
  _i20.GamesManager _createGamesManager() =>
      _i20.GamesManager(_createGamesRepository());
  _i21.GamesRepository _createGamesRepository() =>
      _i21.GamesRepository(_createApiClient());
  _i22.LikedService _createLikedService() =>
      _i22.LikedService(_createAuthService(), _createGamesListService());
  _i23.AddByApiScreen _createAddByApiScreen() =>
      _i23.AddByApiScreen(_createAddByApiStateManager());
  _i24.AddByApiStateManager _createAddByApiStateManager() =>
      _i24.AddByApiStateManager(_createRawGService());
  _i25.RawGService _createRawGService() =>
      _i25.RawGService(_createRawGManager());
  _i26.RawGManager _createRawGManager() =>
      _i26.RawGManager(_createRawGRepository());
  _i27.RawGRepository _createRawGRepository() =>
      _i27.RawGRepository(_createApiClient());
  _i28.LikedScreen _createLikedScreen() => _i28.LikedScreen(
      _createLikedStateManager(),
      _createGeneralProfileService(),
      _createAuthService(),
      _createMyProfileService());
  _i29.LikedStateManager _createLikedStateManager() =>
      _i29.LikedStateManager(_createLikedService());
  _i30.SettingsPage _createSettingsPage() => _i30.SettingsPage(
      _createAuthService(),
      _createLocalizationService(),
      _createSwapThemeDataService());
  _i3.LocalizationService _createLocalizationService() =>
      _singletonLocalizationService ??=
          _i3.LocalizationService(_createLocalizationPreferencesHelper());
  _i31.LocalizationPreferencesHelper _createLocalizationPreferencesHelper() =>
      _i31.LocalizationPreferencesHelper();
  _i32.SwapThemeDataService _createSwapThemeDataService() =>
      _i32.SwapThemeDataService(_createThemePreferencesHelper());
  _i33.ThemePreferencesHelper _createThemePreferencesHelper() =>
      _i33.ThemePreferencesHelper();
  _i34.NotificationScreen _createNotificationScreen() =>
      _i34.NotificationScreen(_createNotificationsStateManager(),
          _createMyProfileService(), _createAuthService());
  _i35.NotificationsStateManager _createNotificationsStateManager() =>
      _i35.NotificationsStateManager(
          _createNotificationService(), _createSwapService());
  _i36.NotificationService _createNotificationService() =>
      _i36.NotificationService(
          _createAuthService(),
          _createGeneralProfileService(),
          _createGamesListService(),
          _createSwapService());
  _i37.SwapService _createSwapService() =>
      _i37.SwapService(_createAuthService());
  _i38.ProfileScreen _createProfileScreen() => _i38.ProfileScreen(
      _createGameCardList(),
      _createAuthService(),
      _createMyProfileService(),
      _createProfileSharedPreferencesHelper());
  _i39.FormsModule _createFormsModule() =>
      _i39.FormsModule(_createAddByImageScreen());
  _i40.AddByImageScreen _createAddByImageScreen() =>
      _i40.AddByImageScreen(_createAddByImageStateManager());
  _i41.AddByImageStateManager _createAddByImageStateManager() =>
      _i41.AddByImageStateManager(_createByImageService());
  _i42.ByImageService _createByImageService() => _i42.ByImageService(
      _createImageUploadService(),
      _createLogger(),
      _createSwapItemManager(),
      _createAuthService());
  _i43.ImageUploadService _createImageUploadService() =>
      _i43.ImageUploadService(_createUploadManager());
  _i44.UploadManager _createUploadManager() =>
      _i44.UploadManager(_createUploadRepository());
  _i45.UploadRepository _createUploadRepository() => _i45.UploadRepository();
  _i46.SwapItemManager _createSwapItemManager() =>
      _i46.SwapItemManager(_createSwapItemRepository());
  _i47.SwapItemRepository _createSwapItemRepository() =>
      _i47.SwapItemRepository(_createApiClient());
  _i48.GamesModule _createGamesModule() =>
      _i48.GamesModule(_createGameDetailsScreen());
  _i49.GameDetailsScreen _createGameDetailsScreen() => _i49.GameDetailsScreen(
      _createGameDetailsManager(),
      _createCommentListWidget(),
      _createSwapService());
  _i50.GameDetailsManager _createGameDetailsManager() =>
      _i50.GameDetailsManager(_createGamesListService());
  _i51.CommentListWidget _createCommentListWidget() =>
      _i51.CommentListWidget(_createCommentStateManager());
  _i52.CommentStateManager _createCommentStateManager() =>
      _i52.CommentStateManager(_createCommentService());
  _i53.CommentService _createCommentService() =>
      _i53.CommentService(_createAuthService());
  _i54.AuthModule _createAuthModule() => _i54.AuthModule(_createAuthScreen());
  _i55.AuthScreen _createAuthScreen() =>
      _i55.AuthScreen(_createAuthStateManager());
  _i56.AuthStateManager _createAuthStateManager() =>
      _i56.AuthStateManager(_createAuthService());
  _i57.ChatModule _createChatModule() =>
      _i57.ChatModule(_createChatPage(), _createAuthGuard());
  _i58.ChatPage _createChatPage() => _i58.ChatPage(_createChatPageBloc());
  _i59.ChatPageBloc _createChatPageBloc() =>
      _i59.ChatPageBloc(_createChatService());
  _i60.ChatService _createChatService() =>
      _i60.ChatService(_createChatManager());
  _i61.ChatManager _createChatManager() =>
      _i61.ChatManager(_createChatRepository());
  _i62.ChatRepository _createChatRepository() => _i62.ChatRepository();
  _i4.AuthGuard _createAuthGuard() =>
      _singletonAuthGuard ??= _i4.AuthGuard(_createSharedPreferencesHelper());
  _i63.SharedPreferencesHelper _createSharedPreferencesHelper() =>
      _i63.SharedPreferencesHelper();
  _i64.CameraModule _createCameraModule() =>
      _i64.CameraModule(_createCameraScreen());
  _i65.CameraScreen _createCameraScreen() => _i65.CameraScreen();
  _i66.ProfileModule _createProfileModule() =>
      _i66.ProfileModule(_createMyProfileScreen());
  _i67.MyProfileScreen _createMyProfileScreen() =>
      _i67.MyProfileScreen(_createMyProfileStateManager());
  _i68.MyProfileStateManager _createMyProfileStateManager() =>
      _i68.MyProfileStateManager(
          _createImageUploadService(), _createMyProfileService());
  @override
  _i6.MyApp get app => _createMyApp();
}
