import 'app.component.dart' as _i1;
import '../../utils/auth_guard/auth_gard.dart' as _i2;
import '../../utils/logger/logger.dart' as _i3;
import 'dart:async' as _i4;
import '../../main.dart' as _i5;
import '../../module_home/home.module.dart' as _i6;
import '../../module_forms/forms_module.dart' as _i7;
import '../../module_forms/ui/screen/add_by_image/add_by_image.dart' as _i8;
import '../../module_chat/chat_module.dart' as _i9;
import '../../module_chat/ui/screens/chat_page/chat_page.dart' as _i10;
import '../../module_chat/bloc/chat_page/chat_page.bloc.dart' as _i11;
import '../../module_chat/service/chat/char_service.dart' as _i12;
import '../../module_chat/manager/chat/chat_manager.dart' as _i13;
import '../../module_chat/repository/chat/chat_repository.dart' as _i14;
import '../../module_persistence/sharedpref/shared_preferences_helper.dart'
    as _i15;
import '../../user_authorization_module/user_auth.dart' as _i16;
import '../../user_authorization_module/ui/screens/create_profile/create_profile.dart'
    as _i17;
import '../../user_authorization_module/bloc/create_profile/create_profile_bloc.dart'
    as _i18;
import '../../user_authorization_module/service/profile/profile.service.dart'
    as _i19;
import '../../user_authorization_module/manager/profile/profile.manager.dart'
    as _i20;
import '../../user_authorization_module/repository/profile/profile.repository.dart'
    as _i21;
import '../../module_network/http_client/http_client.dart' as _i22;
import '../../user_authorization_module/ui/screens/register/register.dart'
    as _i23;
import '../../user_authorization_module/bloc/register/register.bloc.dart'
    as _i24;
import '../../user_authorization_module/service/register/register.service.dart'
    as _i25;
import '../../user_authorization_module/ui/screens/login/login.dart' as _i26;
import '../../user_authorization_module/bloc/login/login.bloc.dart' as _i27;
import '../../user_authorization_module/service/login/login.service.dart'
    as _i28;
import '../../user_authorization_module/ui/screens/intention_profile/intention_profile.dart'
    as _i29;
import '../../user_authorization_module/bloc/create_intentions/create_intention_bloc.dart'
    as _i30;
import '../../user_authorization_module/service/intentions/intentions_service.dart'
    as _i31;
import '../../user_authorization_module/manager/intentions/intentions_manager.dart'
    as _i32;
import '../../user_authorization_module/repository/intentions/intentions_repository.dart'
    as _i33;

class AppComponent$Injector implements _i1.AppComponent {
  AppComponent$Injector._();

  _i2.AuthGuard _singletonAuthGuard;

  _i3.Logger _singletonLogger;

  static _i4.Future<_i1.AppComponent> create() async {
    final injector = AppComponent$Injector._();

    return injector;
  }

  _i5.MyApp _createMyApp() => _i5.MyApp(
      _createHomeModule(),
      _createFormsModule(),
      _createChatModule(),
      _createUserAuthorizationModule());
  _i6.HomeModule _createHomeModule() => _i6.HomeModule();
  _i7.FormsModule _createFormsModule() =>
      _i7.FormsModule(_createAddByImageScreen());
  _i8.AddByImageScreen _createAddByImageScreen() => _i8.AddByImageScreen();
  _i9.ChatModule _createChatModule() =>
      _i9.ChatModule(_createChatPage(), _createAuthGuard());
  _i10.ChatPage _createChatPage() =>
      _i10.ChatPage(_createChatPageBloc(), _createSharedPreferencesHelper());
  _i11.ChatPageBloc _createChatPageBloc() =>
      _i11.ChatPageBloc(_createChatService());
  _i12.ChatService _createChatService() =>
      _i12.ChatService(_createChatManager(), _createSharedPreferencesHelper());
  _i13.ChatManager _createChatManager() =>
      _i13.ChatManager(_createChatRepository());
  _i14.ChatRepository _createChatRepository() => _i14.ChatRepository();
  _i15.SharedPreferencesHelper _createSharedPreferencesHelper() =>
      _i15.SharedPreferencesHelper();
  _i2.AuthGuard _createAuthGuard() =>
      _singletonAuthGuard ??= _i2.AuthGuard(_createSharedPreferencesHelper());
  _i16.UserAuthorizationModule _createUserAuthorizationModule() =>
      _i16.UserAuthorizationModule(
          _createCreateProfileScreen(),
          _createRegisterScreen(),
          _createLoginScreen(),
          _createIntentionProfileScreen());
  _i17.CreateProfileScreen _createCreateProfileScreen() =>
      _i17.CreateProfileScreen(
          _createCreateProfileBloc(), _createSharedPreferencesHelper());
  _i18.CreateProfileBloc _createCreateProfileBloc() =>
      _i18.CreateProfileBloc(_createProfileService());
  _i19.ProfileService _createProfileService() => _i19.ProfileService(
      _createProfileManager(), _createSharedPreferencesHelper());
  _i20.ProfileManager _createProfileManager() =>
      _i20.ProfileManager(_createProfileRepository());
  _i21.ProfileRepository _createProfileRepository() =>
      _i21.ProfileRepository(_createHttpClient());
  _i22.HttpClient _createHttpClient() => _i22.HttpClient(_createLogger());
  _i3.Logger _createLogger() => _singletonLogger ??= _i3.Logger();
  _i23.RegisterScreen _createRegisterScreen() =>
      _i23.RegisterScreen(_createRegisterBloc());
  _i24.RegisterBloc _createRegisterBloc() =>
      _i24.RegisterBloc(_createRegisterService());
  _i25.RegisterService _createRegisterService() =>
      _i25.RegisterService(_createSharedPreferencesHelper());
  _i26.LoginScreen _createLoginScreen() =>
      _i26.LoginScreen(_createLoginBloc(), _createSharedPreferencesHelper());
  _i27.LoginBloc _createLoginBloc() => _i27.LoginBloc(_createLoginService());
  _i28.LoginService _createLoginService() =>
      _i28.LoginService(_createSharedPreferencesHelper());
  _i29.IntentionProfileScreen _createIntentionProfileScreen() =>
      _i29.IntentionProfileScreen(
          _createCreateIntentionBloc(), _createSharedPreferencesHelper());
  _i30.CreateIntentionBloc _createCreateIntentionBloc() =>
      _i30.CreateIntentionBloc(_createIntentionService());
  _i31.IntentionService _createIntentionService() =>
      _i31.IntentionService(_createIntentionsManager());
  _i32.IntentionsManager _createIntentionsManager() =>
      _i32.IntentionsManager(_createIntentionsRepository());
  _i33.IntentionsRepository _createIntentionsRepository() =>
      _i33.IntentionsRepository(_createHttpClient());
  @override
  _i5.MyApp get app => _createMyApp();
}
