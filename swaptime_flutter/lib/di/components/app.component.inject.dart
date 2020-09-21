import 'app.component.dart' as _i1;
import '../../utils/logger/logger.dart' as _i2;
import '../../utils/auth_guard/auth_gard.dart' as _i3;
import 'dart:async' as _i4;
import '../../main.dart' as _i5;
import '../../module_home/home.module.dart' as _i6;
import '../../module_home/ui/screens/home_screen.dart' as _i7;
import '../../module_auth/service/auth_service/auth_service.dart' as _i8;
import '../../module_auth/presistance/auth_prefs_helper.dart' as _i9;
import '../../module_profile/service/my_profile/my_profile.dart' as _i10;
import '../../module_profile/manager/my_profile_manager/my_profile_manager.dart'
    as _i11;
import '../../module_profile/repository/my_profile/my_profile.dart' as _i12;
import '../../module_network/http_client/http_client.dart' as _i13;
import '../../module_profile/presistance/profile_shared_preferences.dart'
    as _i14;
import '../../module_profile/service/general_profile/general_profile.dart'
    as _i15;
import '../../games_module/ui/widget/game_card_list/game_card_list.dart'
    as _i16;
import '../../games_module/state_manager/games_list_state_manager/games_list_state_manager.dart'
    as _i17;
import '../../games_module/service/games_list_service/games_list_service.dart'
    as _i18;
import '../../games_module/manager/games_manager/games_manager.dart' as _i19;
import '../../games_module/repository/games_repository/games_repository.dart'
    as _i20;
import '../../liked_module/service/liked_service/liked_service.dart' as _i21;
import '../../liked_module/ui/liked_screen/liked_screen.dart' as _i22;
import '../../liked_module/state_manager/liked_manager/liked_state_manager.dart'
    as _i23;
import '../../module_settings/ui/ui/settings_page/settings_page.dart' as _i24;
import '../../module_notifications/ui/screens/notification_screen/notification_screen.dart'
    as _i25;
import '../../module_notifications/state_manager/notifications_state_manager/notifcations_list_state_manager.dart'
    as _i26;
import '../../module_notifications/service/notification_service/notification_service.dart'
    as _i27;
import '../../module_swap/service/swap_service/swap_service.dart' as _i28;
import '../../module_profile/ui/profile_screen/profile_screen.dart' as _i29;
import '../../module_forms/forms_module.dart' as _i30;
import '../../module_forms/ui/screen/add_by_image/add_by_image.dart' as _i31;
import '../../module_forms/state_manager/add_by_image_manager/add_by_image_manager.dart'
    as _i32;
import '../../module_forms/service/by_image_service/by_image_service.dart'
    as _i33;
import '../../module_upload/service/image_upload/image_upload_service.dart'
    as _i34;
import '../../module_upload/manager/upload_manager/upload_manager.dart' as _i35;
import '../../module_upload/repository/upload_repository/upload_repository.dart'
    as _i36;
import '../../module_forms/manager/swap_item_repository/swap_item_repository.dart'
    as _i37;
import '../../module_forms/repository/swap_item_respository/swap_item_repository.dart'
    as _i38;
import '../../games_module/games_module.dart' as _i39;
import '../../games_module/ui/widget/game_details/game_details.dart' as _i40;
import '../../games_module/state_manager/game_details_state_manager/game_details_list_manager.dart'
    as _i41;
import '../../module_comment/ui/widget/comments_list_widget/comment_list_widget.dart'
    as _i42;
import '../../module_comment/state_manager/comment_state_manager/comment_state_manager.dart'
    as _i43;
import '../../module_comment/service/comment_service/comment_service.dart'
    as _i44;
import '../../module_auth/auth_module.dart' as _i45;
import '../../module_auth/ui/screen/auth_screen/auth_screen.dart' as _i46;
import '../../module_auth/state_manager/auth_state_manager/auth_state_manager.dart'
    as _i47;
import '../../module_chat/chat_module.dart' as _i48;
import '../../module_chat/ui/screens/chat_page/chat_page.dart' as _i49;
import '../../module_chat/bloc/chat_page/chat_page.bloc.dart' as _i50;
import '../../module_chat/service/chat/char_service.dart' as _i51;
import '../../module_chat/manager/chat/chat_manager.dart' as _i52;
import '../../module_chat/repository/chat/chat_repository.dart' as _i53;
import '../../module_persistence/sharedpref/shared_preferences_helper.dart'
    as _i54;
import '../../camera/camera_module.dart' as _i55;
import '../../camera/ui/screen/camera_screen/camera_screen.dart' as _i56;
import '../../module_profile/profile_module.dart' as _i57;
import '../../module_profile/ui/my_profile/my_profile.dart' as _i58;
import '../../module_profile/state_manager/my_profile/my_profile_state_manager.dart'
    as _i59;

class AppComponent$Injector implements _i1.AppComponent {
  AppComponent$Injector._();

  _i2.Logger _singletonLogger;

  _i3.AuthGuard _singletonAuthGuard;

  static _i4.Future<_i1.AppComponent> create() async {
    final injector = AppComponent$Injector._();

    return injector;
  }

  _i5.MyApp _createMyApp() => _i5.MyApp(
      _createHomeModule(),
      _createFormsModule(),
      _createGamesModule(),
      _createAuthModule(),
      _createChatModule(),
      _createCameraModule(),
      _createProfileModule());
  _i6.HomeModule _createHomeModule() => _i6.HomeModule(_createHomeScreen());
  _i7.HomeScreen _createHomeScreen() => _i7.HomeScreen(
      _createAuthService(),
      _createMyProfileService(),
      _createGameCardList(),
      _createLikedScreen(),
      _createSettingsPage(),
      _createNotificationScreen(),
      _createProfileScreen());
  _i8.AuthService _createAuthService() =>
      _i8.AuthService(_createAuthPrefsHelper());
  _i9.AuthPrefsHelper _createAuthPrefsHelper() => _i9.AuthPrefsHelper();
  _i10.MyProfileService _createMyProfileService() => _i10.MyProfileService(
      _createMyProfileManager(),
      _createProfileSharedPreferencesHelper(),
      _createAuthService(),
      _createGeneralProfileService());
  _i11.MyProfileManager _createMyProfileManager() =>
      _i11.MyProfileManager(_createMyProfileRepository());
  _i12.MyProfileRepository _createMyProfileRepository() =>
      _i12.MyProfileRepository(_createApiClient());
  _i13.ApiClient _createApiClient() => _i13.ApiClient(_createLogger());
  _i2.Logger _createLogger() => _singletonLogger ??= _i2.Logger();
  _i14.ProfileSharedPreferencesHelper _createProfileSharedPreferencesHelper() =>
      _i14.ProfileSharedPreferencesHelper();
  _i15.GeneralProfileService _createGeneralProfileService() =>
      _i15.GeneralProfileService();
  _i16.GameCardList _createGameCardList() =>
      _i16.GameCardList(_createGamesListStateManager());
  _i17.GamesListStateManager _createGamesListStateManager() =>
      _i17.GamesListStateManager(
          _createGamesListService(), _createLikedService());
  _i18.GamesListService _createGamesListService() =>
      _i18.GamesListService(_createGamesManager(), _createAuthService());
  _i19.GamesManager _createGamesManager() =>
      _i19.GamesManager(_createGamesRepository());
  _i20.GamesRepository _createGamesRepository() =>
      _i20.GamesRepository(_createApiClient());
  _i21.LikedService _createLikedService() =>
      _i21.LikedService(_createAuthService(), _createGamesListService());
  _i22.LikedScreen _createLikedScreen() => _i22.LikedScreen(
      _createLikedStateManager(), _createGeneralProfileService());
  _i23.LikedStateManager _createLikedStateManager() =>
      _i23.LikedStateManager(_createLikedService());
  _i24.SettingsPage _createSettingsPage() =>
      _i24.SettingsPage(_createAuthService());
  _i25.NotificationScreen _createNotificationScreen() =>
      _i25.NotificationScreen(_createNotificationsStateManager());
  _i26.NotificationsStateManager _createNotificationsStateManager() =>
      _i26.NotificationsStateManager(_createNotificationService());
  _i27.NotificationService _createNotificationService() =>
      _i27.NotificationService(
          _createAuthService(),
          _createGeneralProfileService(),
          _createGamesListService(),
          _createSwapService());
  _i28.SwapService _createSwapService() =>
      _i28.SwapService(_createAuthService());
  _i29.ProfileScreen _createProfileScreen() => _i29.ProfileScreen(
      _createGameCardList(),
      _createAuthService(),
      _createMyProfileService(),
      _createProfileSharedPreferencesHelper());
  _i30.FormsModule _createFormsModule() =>
      _i30.FormsModule(_createAddByImageScreen());
  _i31.AddByImageScreen _createAddByImageScreen() =>
      _i31.AddByImageScreen(_createAddByImageStateManager());
  _i32.AddByImageStateManager _createAddByImageStateManager() =>
      _i32.AddByImageStateManager(_createByImageService());
  _i33.ByImageService _createByImageService() => _i33.ByImageService(
      _createImageUploadService(),
      _createLogger(),
      _createSwapItemManager(),
      _createAuthService());
  _i34.ImageUploadService _createImageUploadService() =>
      _i34.ImageUploadService(_createUploadManager());
  _i35.UploadManager _createUploadManager() =>
      _i35.UploadManager(_createUploadRepository());
  _i36.UploadRepository _createUploadRepository() => _i36.UploadRepository();
  _i37.SwapItemManager _createSwapItemManager() =>
      _i37.SwapItemManager(_createSwapItemRepository());
  _i38.SwapItemRepository _createSwapItemRepository() =>
      _i38.SwapItemRepository(_createApiClient());
  _i39.GamesModule _createGamesModule() =>
      _i39.GamesModule(_createGameDetailsScreen());
  _i40.GameDetailsScreen _createGameDetailsScreen() => _i40.GameDetailsScreen(
      _createGameDetailsManager(), _createCommentListWidget());
  _i41.GameDetailsManager _createGameDetailsManager() =>
      _i41.GameDetailsManager(_createGamesListService());
  _i42.CommentListWidget _createCommentListWidget() =>
      _i42.CommentListWidget(_createCommentStateManager());
  _i43.CommentStateManager _createCommentStateManager() =>
      _i43.CommentStateManager(_createCommentService());
  _i44.CommentService _createCommentService() =>
      _i44.CommentService(_createAuthService());
  _i45.AuthModule _createAuthModule() => _i45.AuthModule(_createAuthScreen());
  _i46.AuthScreen _createAuthScreen() =>
      _i46.AuthScreen(_createAuthStateManager());
  _i47.AuthStateManager _createAuthStateManager() =>
      _i47.AuthStateManager(_createAuthService());
  _i48.ChatModule _createChatModule() =>
      _i48.ChatModule(_createChatPage(), _createAuthGuard());
  _i49.ChatPage _createChatPage() => _i49.ChatPage(_createChatPageBloc());
  _i50.ChatPageBloc _createChatPageBloc() =>
      _i50.ChatPageBloc(_createChatService());
  _i51.ChatService _createChatService() =>
      _i51.ChatService(_createChatManager());
  _i52.ChatManager _createChatManager() =>
      _i52.ChatManager(_createChatRepository());
  _i53.ChatRepository _createChatRepository() => _i53.ChatRepository();
  _i3.AuthGuard _createAuthGuard() =>
      _singletonAuthGuard ??= _i3.AuthGuard(_createSharedPreferencesHelper());
  _i54.SharedPreferencesHelper _createSharedPreferencesHelper() =>
      _i54.SharedPreferencesHelper();
  _i55.CameraModule _createCameraModule() =>
      _i55.CameraModule(_createCameraScreen());
  _i56.CameraScreen _createCameraScreen() => _i56.CameraScreen();
  _i57.ProfileModule _createProfileModule() =>
      _i57.ProfileModule(_createMyProfileScreen());
  _i58.MyProfileScreen _createMyProfileScreen() =>
      _i58.MyProfileScreen(_createMyProfileStateManager());
  _i59.MyProfileStateManager _createMyProfileStateManager() =>
      _i59.MyProfileStateManager(
          _createImageUploadService(), _createMyProfileService());
  @override
  _i5.MyApp get app => _createMyApp();
}
