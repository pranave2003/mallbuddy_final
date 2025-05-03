class OneSignalService {
  static final OneSignalService _instance = OneSignalService._internal();
  factory OneSignalService() => _instance;
  OneSignalService._internal();

  String? _playerId;

  void setPlayerId(String id) {
    _playerId = id;
  }

  String? get playerId => _playerId;
}
