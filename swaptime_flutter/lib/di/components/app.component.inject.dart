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
import '../../module_chat/chat_module.dart' as _i14;
import '../../module_chat/ui/screens/chat_page/chat_page.dart' as _i15;
import '../../module_chat/bloc/chat_page/chat_page.bloc.dart' as _i16;
import '../../module_chat/service/chat/char_service.dart' as _i17;
import '../../module_chat/manager/chat/chat_manager.dart' as _i18;
import '../../module_chat/repository/chat/chat_repository.dart' as _i19;
import '../../module_persistence/sharedpref/shared_preferences_helper.dart'
    as _i20;
import '../../camera/camera_module.dart' as _i21;
import '../../camera/ui/screen/camera_screen/camera_screen.dart' as _i22;

class AppComponent$Injector implements _i1.AppComponent {
  AppComponent$Injector._();

  _i2.Logger _singletonLogger;

  _i3.AuthGuard _singletonAuthGuard;

  static _i4.Future<_i1.AppComponent> create() async {
    final injector = AppComponent$Injector._();

    return injector;
  }

  _i5.MyApp _createMyApp() => _i5.MyApp(_createHomeModule(),
      _createFormsModule(), _createChatModule(), _createCameraModule());
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
  _i14.ChatModule _createChatModule() =>
      _i14.ChatModule(_createChatPage(), _createAuthGuard());
  _i15.ChatPage _createChatPage() =>
      _i15.ChatPage(_createChatPageBloc(), _createSharedPreferencesHelper());
  _i16.ChatPageBloc _createChatPageBloc() =>
      _i16.ChatPageBloc(_createChatService());
  _i17.ChatService _createChatService() =>
      _i17.ChatService(_createChatManager(), _createSharedPreferencesHelper());
  _i18.ChatManager _createChatManager() =>
      _i18.ChatManager(_createChatRepository());
  _i19.ChatRepository _createChatRepository() => _i19.ChatRepository();
  _i20.SharedPreferencesHelper _createSharedPreferencesHelper() =>
      _i20.SharedPreferencesHelper();
  _i3.AuthGuard _createAuthGuard() =>
      _singletonAuthGuard ??= _i3.AuthGuard(_createSharedPreferencesHelper());
  _i21.CameraModule _createCameraModule() =>
      _i21.CameraModule(_createCameraScreen());
  _i22.CameraScreen _createCameraScreen() => _i22.CameraScreen();
  @override
  _i5.MyApp get app => _createMyApp();
}
