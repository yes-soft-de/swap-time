import 'app.component.dart' as _i1;
import '../../utils/logger/logger.dart' as _i2;
import '../../utils/auth_guard/auth_gard.dart' as _i3;
import 'dart:async' as _i4;
import '../../main.dart' as _i5;
import '../../module_home/home.module.dart' as _i6;
import '../../module_forms/forms_module.dart' as _i7;
import '../../module_forms/ui/screen/add_by_image/add_by_image.dart' as _i8;
import '../../module_forms/state_manager/add_by_image_manager/add_by_image_manager.dart'
    as _i9;
import '../../module_forms/service/by_image_service/by_image_service.dart'
    as _i10;
import '../../module_upload/service/image_upload/image_upload_service.dart'
    as _i11;
import '../../module_upload/manager/upload_manager/upload_manager.dart' as _i12;
import '../../module_upload/repository/upload_repository/upload_repository.dart'
    as _i13;
import '../../module_auth/auth_module.dart' as _i14;
import '../../module_auth/ui/screen/auth_screen/auth_screen.dart' as _i15;
import '../../module_auth/state_manager/auth_state_manager/auth_state_manager.dart'
    as _i16;
import '../../module_chat/chat_module.dart' as _i17;
import '../../module_chat/ui/screens/chat_page/chat_page.dart' as _i18;
import '../../module_chat/bloc/chat_page/chat_page.bloc.dart' as _i19;
import '../../module_chat/service/chat/char_service.dart' as _i20;
import '../../module_chat/manager/chat/chat_manager.dart' as _i21;
import '../../module_chat/repository/chat/chat_repository.dart' as _i22;
import '../../module_persistence/sharedpref/shared_preferences_helper.dart'
    as _i23;
import '../../camera/camera_module.dart' as _i24;
import '../../camera/ui/screen/camera_screen/camera_screen.dart' as _i25;

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
      _createCameraModule());
  _i6.HomeModule _createHomeModule() => _i6.HomeModule();
  _i7.FormsModule _createFormsModule() =>
      _i7.FormsModule(_createAddByImageScreen());
  _i8.AddByImageScreen _createAddByImageScreen() =>
      _i8.AddByImageScreen(_createAddByImageStateManager());
  _i9.AddByImageStateManager _createAddByImageStateManager() =>
      _i9.AddByImageStateManager(_createByImageService());
  _i10.ByImageService _createByImageService() =>
      _i10.ByImageService(_createImageUploadService(), _createLogger());
  _i11.ImageUploadService _createImageUploadService() =>
      _i11.ImageUploadService(_createUploadManager());
  _i12.UploadManager _createUploadManager() =>
      _i12.UploadManager(_createUploadRepository());
  _i13.UploadRepository _createUploadRepository() => _i13.UploadRepository();
  _i2.Logger _createLogger() => _singletonLogger ??= _i2.Logger();
  _i14.AuthModule _createAuthModule() => _i14.AuthModule(_createAuthScreen());
  _i15.AuthScreen _createAuthScreen() =>
      _i15.AuthScreen(_createAuthStateManager());
  _i16.AuthStateManager _createAuthStateManager() => _i16.AuthStateManager();
  _i17.ChatModule _createChatModule() =>
      _i17.ChatModule(_createChatPage(), _createAuthGuard());
  _i18.ChatPage _createChatPage() =>
      _i18.ChatPage(_createChatPageBloc(), _createSharedPreferencesHelper());
  _i19.ChatPageBloc _createChatPageBloc() =>
      _i19.ChatPageBloc(_createChatService());
  _i20.ChatService _createChatService() =>
      _i20.ChatService(_createChatManager(), _createSharedPreferencesHelper());
  _i21.ChatManager _createChatManager() =>
      _i21.ChatManager(_createChatRepository());
  _i22.ChatRepository _createChatRepository() => _i22.ChatRepository();
  _i23.SharedPreferencesHelper _createSharedPreferencesHelper() =>
      _i23.SharedPreferencesHelper();
  _i3.AuthGuard _createAuthGuard() =>
      _singletonAuthGuard ??= _i3.AuthGuard(_createSharedPreferencesHelper());
  _i24.CameraModule _createCameraModule() =>
      _i24.CameraModule(_createCameraScreen());
  _i25.CameraScreen _createCameraScreen() => _i25.CameraScreen();
  @override
  _i5.MyApp get app => _createMyApp();
}
