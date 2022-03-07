class ProfileModel {
  String _userName;
  String _userPic;

  ProfileModel(
    this._userName,
    this._userPic,
  );

  ProfileModel.map(dynamic obj) {
    this._userName = obj["userName"];

    this._userPic = obj["userPic"];
  }
  String get userName => _userName;

  String get userPic => _userPic;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["userName"] = _userName;
    map["userPic"] = _userPic;
    return map;
  }
}
