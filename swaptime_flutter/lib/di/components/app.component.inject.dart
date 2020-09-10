import 'app.component.dart' as _i1;
import '../../utils/auth_guard/auth_gard.dart' as _i2;
import 'dart:async' as _i3;
import '../../main.dart' as _i4;
import '../../module_home/home.module.dart' as _i5;
import '../../module_forms/forms_module.dart' as _i6;
import '../../module_forms/ui/screen/add_by_image/add_by_image.dart' as _i7;
import '../../module_forms/state_manager/add_by_image_manager/add_by_image_manager.dart'
    as _i8;
import '../../module_forms/service/by_image_service/by_image_service.dart'
    as _i9;
import '../../module_upload/service/image_upload/image_upload_service.dart'
    as _i10;
import '../../module_upload/manager/upload_manager/upload_manager.dart' as _i11;
import '../../module_upload/repository/upload_repository/upload_repository.dart'
    as _i12;
import '../../module_chat/chat_module.dart' as _i13;
import '../../module_chat/ui/screens/chat_page/chat_page.dart' as _i14;
import '../../module_chat/bloc/chat_page/chat_page.bloc.dart' as _i15;
import '../../module_chat/service/chat/char_service.dart' as _i16;
import '../../module_chat/manager/chat/chat_manager.dart' as _i17;
import '../../module_chat/repository/chat/chat_repository.dart' as _i18;
import '../../module_persistence/sharedpref/shared_preferences_helper.dart'
    as _i19;
import '../../camera/camera_module.dart' as _i20;
import '../../camera/ui/screen/camera_screen/camera_screen.dart' as _i21;

class AppComponent$Injector implements _i1.AppComponent {
  AppComponent$Injector._();

  _i2.AuthGuard _singletonAuthGuard;

  static _i3.Future<_i1.AppComponent> create() async {
    final injector = AppComponent$Injector._();

    return injector;
  }

  _i4.MyApp _createMyApp() => _i4.MyApp(_createHomeModule(),
      _createFormsModule(), _createChatModule(), _createCameraModule());
  _i5.HomeModule _createHomeModule() => _i5.HomeModule();
  _i6.FormsModule _createFormsModule() =>
      _i6.FormsModule(_createAddByImageScreen());
  _i7.AddByImageScreen _createAddByImageScreen() =>
      _i7.AddByImageScreen(_createAddByImageStateManager());
  _i8.AddByImageStateManager _createAddByImageStateManager() =>
      _i8.AddByImageStateManager(_createByImageService());
  _i9.ByImageService _createByImageService() =>
      _i9.ByImageService(_createImageUploadService());
  _i10.ImageUploadService _createImageUploadService() =>
      _i10.ImageUploadService(_createUploadManager());
  _i11.UploadManager _createUploadManager() =>
      _i11.UploadManager(_createUploadRepository());
  _i12.UploadRepository _createUploadRepository() => _i12.UploadRepository();
  _i13.ChatModule _createChatModule() =>
      _i13.ChatModule(_createChatPage(), _createAuthGuard());
  _i14.ChatPage _createChatPage() =>
      _i14.ChatPage(_createChatPageBloc(), _createSharedPreferencesHelper());
  _i15.ChatPageBloc _createChatPageBloc() =>
      _i15.ChatPageBloc(_createChatService());
  _i16.ChatService _createChatService() =>
      _i16.ChatService(_createChatManager(), _createSharedPreferencesHelper());
  _i17.ChatManager _createChatManager() =>
      _i17.ChatManager(_createChatRepository());
  _i18.ChatRepository _createChatRepository() => _i18.ChatRepository();
  _i19.SharedPreferencesHelper _createSharedPreferencesHelper() =>
      _i19.SharedPreferencesHelper();
  _i2.AuthGuard _createAuthGuard() =>
      _singletonAuthGuard ??= _i2.AuthGuard(_createSharedPreferencesHelper());
  _i20.CameraModule _createCameraModule() =>
      _i20.CameraModule(_createCameraScreen());
  _i21.CameraScreen _createCameraScreen() => _i21.CameraScreen();
  @override
  _i4.MyApp get app => _createMyApp();
}
