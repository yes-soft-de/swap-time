class ProfileModel {
  String _name;
  String _lang;
  String _arrivalCity;
  DateTime _arrivalDate;
  String _stayingTime;
  int _age;

  ProfileModel(this._name, this._age, this._lang, this._arrivalCity, this._arrivalDate,
      this._stayingTime);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> object = new Map();
    object['name'] = _name;
    object['lang'] = _lang;
    object['age'] = _age;
    object['arrival_city'] = _arrivalCity;
    object['arrival_date'] = _arrivalDate;
    object['staying_time'] = _stayingTime;

    return object;
  }

  String get stayingTime => _stayingTime;

  set stayingTime(String value) {
    _stayingTime = value;
  }

  DateTime get arrivalDate => _arrivalDate;

  set arrivalDate(DateTime value) {
    _arrivalDate = value;
  }

  String get arrivalCity => _arrivalCity;

  set arrivalCity(String value) {
    _arrivalCity = value;
  }

  String get lang => _lang;

  set lang(String value) {
    _lang = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }
}