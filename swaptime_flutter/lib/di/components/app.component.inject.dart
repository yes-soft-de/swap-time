import 'app.component.dart' as _i1;
import '../../utils/auth_guard/auth_gard.dart' as _i2;
import 'dart:async' as _i3;
import '../../main.dart' as _i4;
import '../../module_home/home.module.dart' as _i5;
import '../../module_forms/forms_module.dart' as _i6;
import '../../module_forms/ui/screen/add_by_image/add_by_image.dart' as _i7;
import '../../module_chat/chat_module.dart' as _i8;
import '../../module_chat/ui/screens/chat_page/chat_page.dart' as _i9;
import '../../module_chat/bloc/chat_page/chat_page.bloc.dart' as _i10;
import '../../module_chat/service/chat/char_service.dart' as _i11;
import '../../module_chat/manager/chat/chat_manager.dart' as _i12;
import '../../module_chat/repository/chat/chat_repository.dart' as _i13;
import '../../module_persistence/sharedpref/shared_preferences_helper.dart'
    as _i14;

class AppComponent$Injector implements _i1.AppComponent {
  AppComponent$Injector._();

  _i2.AuthGuard _singletonAuthGuard;

  static _i3.Future<_i1.AppComponent> create() async {
    final injector = AppComponent$Injector._();

    return injector;
  }

  _i4.MyApp _createMyApp() =>
      _i4.MyApp(_createHomeModule(), _createFormsModule(), _createChatModule());
  _i5.HomeModule _createHomeModule() => _i5.HomeModule();
  _i6.FormsModule _createFormsModule() =>
      _i6.FormsModule(_createAddByImageScreen());
  _i7.AddByImageScreen _createAddByImageScreen() => _i7.AddByImageScreen();
  _i8.ChatModule _createChatModule() =>
      _i8.ChatModule(_createChatPage(), _createAuthGuard());
  _i9.ChatPage _createChatPage() =>
      _i9.ChatPage(_createChatPageBloc(), _createSharedPreferencesHelper());
  _i10.ChatPageBloc _createChatPageBloc() =>
      _i10.ChatPageBloc(_createChatService());
  _i11.ChatService _createChatService() =>
      _i11.ChatService(_createChatManager(), _createSharedPreferencesHelper());
  _i12.ChatManager _createChatManager() =>
      _i12.ChatManager(_createChatRepository());
  _i13.ChatRepository _createChatRepository() => _i13.ChatRepository();
  _i14.SharedPreferencesHelper _createSharedPreferencesHelper() =>
      _i14.SharedPreferencesHelper();
  _i2.AuthGuard _createAuthGuard() =>
      _singletonAuthGuard ??= _i2.AuthGuard(_createSharedPreferencesHelper());
  @override
  _i4.MyApp get app => _createMyApp();
}
