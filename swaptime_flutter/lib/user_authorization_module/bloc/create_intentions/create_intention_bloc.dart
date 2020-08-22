import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:swaptime_flutter/user_authorization_module/request/create_profile/create_profile_body.dart';
import 'package:swaptime_flutter/user_authorization_module/service/intentions/intentions_service.dart';

@provide
class CreateIntentionBloc {
  IntentionService _intentionService;
  final _intentionsCreationSubject = PublishSubject<bool>();

  CreateIntentionBloc(this._intentionService);

  Stream<bool> get intentionsCreateStream => _intentionsCreationSubject.stream;

  createIntention(String arrivalCity, String arrivalDate, String stayingTime,
      List<String> interests) async {
    bool response = await _intentionService.createIntentions(CreateProfileBody(
        arrivalCity: arrivalCity,
        arrivalDate: arrivalDate,
        stayDays: stayingTime,
        interests: interests));

    _intentionsCreationSubject.add(response);
  }

  dispose() {
    _intentionsCreationSubject.close();
  }
}
