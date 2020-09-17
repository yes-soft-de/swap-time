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
import '../../games_module/ui/widget/game_card_list/game_card_list.dart'
    as _i15;
import '../../games_module/state_manager/games_list_state_manager/games_list_state_manager.dart'
    as _i16;
import '../../games_module/service/games_list_service/games_list_service.dart'
    as _i17;
import '../../games_module/manager/games_manager/games_manager.dart' as _i18;
import '../../games_module/repository/games_repository/games_repository.dart'
    as _i19;
import '../../module_profile/ui/profile_screen/profile_screen.dart' as _i20;
import '../../module_forms/forms_module.dart' as _i21;
import '../../module_forms/ui/screen/add_by_image/add_by_image.dart' as _i22;
import '../../module_forms/state_manager/add_by_image_manager/add_by_image_manager.dart'
    as _i23;
import '../../module_forms/service/by_image_service/by_image_service.dart'
    as _i24;
import '../../module_upload/service/image_upload/image_upload_service.dart'
    as _i25;
import '../../module_upload/manager/upload_manager/upload_manager.dart' as _i26;
import '../../module_upload/repository/upload_repository/upload_repository.dart'
    as _i27;
import '../../module_auth/auth_module.dart' as _i28;
import '../../module_auth/ui/screen/auth_screen/auth_screen.dart' as _i29;
import '../../module_auth/state_manager/auth_state_manager/auth_state_manager.dart'
    as _i30;
import '../../module_chat/chat_module.dart' as _i31;
import '../../module_chat/ui/screens/chat_page/chat_page.dart' as _i32;
import '../../module_chat/bloc/chat_page/chat_page.bloc.dart' as _i33;
import '../../module_chat/service/chat/char_service.dart' as _i34;
import '../../module_chat/manager/chat/chat_manager.dart' as _i35;
import '../../module_chat/repository/chat/chat_repository.dart' as _i36;
import '../../module_persistence/sharedpref/shared_preferences_helper.dart'
    as _i37;
import '../../camera/camera_module.dart' as _i38;
import '../../camera/ui/screen/camera_screen/camera_screen.dart' as _i39;
import '../../module_profile/profile_module.dart' as _i40;
import '../../module_profile/ui/my_profile/my_profile.dart' as _i41;

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
      _createAuthModule(),
      _createChatModule(),
      _createCameraModule(),
      _createProfileModule());
  _i6.HomeModule _createHomeModule() => _i6.HomeModule(_createHomeScreen());
  _i7.HomeScreen _createHomeScreen() => _i7.HomeScreen(_createAuthService(),
      _createMyProfileService(), _createGameCardList(), _createProfileScreen());
  _i8.AuthService _createAuthService() =>
      _i8.AuthService(_createAuthPrefsHelper());
  _i9.AuthPrefsHelper _createAuthPrefsHelper() => _i9.AuthPrefsHelper();
  _i10.MyProfileService _createMyProfileService() => _i10.MyProfileService(
      _createMyProfileManager(),
      _createProfileSharedPreferencesHelper(),
      _createAuthService());
  _i11.MyProfileManager _createMyProfileManager() =>
      _i11.MyProfileManager(_createMyProfileRepository());
  _i12.MyProfileRepository _createMyProfileRepository() =>
      _i12.MyProfileRepository(_createApiClient());
  _i13.ApiClient _createApiClient() => _i13.ApiClient(_createLogger());
  _i2.Logger _createLogger() => _singletonLogger ??= _i2.Logger();
  _i14.ProfileSharedPreferencesHelper _createProfileSharedPreferencesHelper() =>
      _i14.ProfileSharedPreferencesHelper();
  _i15.GameCardList _createGameCardList() =>
      _i15.GameCardList(_createGamesListStateManager());
  _i16.GamesListStateManager _createGamesListStateManager() =>
      _i16.GamesListStateManager(_createGamesListService());
  _i17.GamesListService _createGamesListService() =>
      _i17.GamesListService(_createGamesManager(), _createAuthService());
  _i18.GamesManager _createGamesManager() =>
      _i18.GamesManager(_createGamesRepository());
  _i19.GamesRepository _createGamesRepository() =>
      _i19.GamesRepository(_createApiClient());
  _i20.ProfileScreen _createProfileScreen() =>
      _i20.ProfileScreen(_createGameCardList());
  _i21.FormsModule _createFormsModule() =>
      _i21.FormsModule(_createAddByImageScreen());
  _i22.AddByImageScreen _createAddByImageScreen() =>
      _i22.AddByImageScreen(_createAddByImageStateManager());
  _i23.AddByImageStateManager _createAddByImageStateManager() =>
      _i23.AddByImageStateManager(_createByImageService());
  _i24.ByImageService _createByImageService() =>
      _i24.ByImageService(_createImageUploadService(), _createLogger());
  _i25.ImageUploadService _createImageUploadService() =>
      _i25.ImageUploadService(_createUploadManager());
  _i26.UploadManager _createUploadManager() =>
      _i26.UploadManager(_createUploadRepository());
  _i27.UploadRepository _createUploadRepository() => _i27.UploadRepository();
  _i28.AuthModule _createAuthModule() => _i28.AuthModule(_createAuthScreen());
  _i29.AuthScreen _createAuthScreen() =>
      _i29.AuthScreen(_createAuthStateManager());
  _i30.AuthStateManager _createAuthStateManager() =>
      _i30.AuthStateManager(_createAuthService());
  _i31.ChatModule _createChatModule() =>
      _i31.ChatModule(_createChatPage(), _createAuthGuard());
  _i32.ChatPage _createChatPage() =>
      _i32.ChatPage(_createChatPageBloc(), _createSharedPreferencesHelper());
  _i33.ChatPageBloc _createChatPageBloc() =>
      _i33.ChatPageBloc(_createChatService());
  _i34.ChatService _createChatService() =>
      _i34.ChatService(_createChatManager(), _createSharedPreferencesHelper());
  _i35.ChatManager _createChatManager() =>
      _i35.ChatManager(_createChatRepository());
  _i36.ChatRepository _createChatRepository() => _i36.ChatRepository();
  _i37.SharedPreferencesHelper _createSharedPreferencesHelper() =>
      _i37.SharedPreferencesHelper();
  _i3.AuthGuard _createAuthGuard() =>
      _singletonAuthGuard ??= _i3.AuthGuard(_createSharedPreferencesHelper());
  _i38.CameraModule _createCameraModule() =>
      _i38.CameraModule(_createCameraScreen());
  _i39.CameraScreen _createCameraScreen() => _i39.CameraScreen();
  _i40.ProfileModule _createProfileModule() =>
      _i40.ProfileModule(_createProfileScreen(), _createMyProfileScreen());
  _i41.MyProfileScreen _createMyProfileScreen() => _i41.MyProfileScreen();
  @override
  _i5.MyApp get app => _createMyApp();
}
