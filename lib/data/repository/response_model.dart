class ResponseModel {
  String _message;
  bool _isSuccess;

  ResponseModel(this._isSuccess, this._message);

  bool get isSuccess => _isSuccess;
  String get message => _message;
}
