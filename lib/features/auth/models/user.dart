// class User {
//   User({
//     required this.email,
//     required this.name,
//   });
//   late final String email;

//   late final String name;

//   User.fromJson(Map<String, dynamic> json) {
//     print(json);
//     email = json['email'];

//     name = json['name'];
//   }
// }

class User {
  User({
    required this.id,
    required this.token,
    required this.email,
    required this.name,
    required this.type,
    required this.username,
    required this.isActive,
    required this.isSuperuser,
    required this.mobile,
    required this.createdAt,
    required this.updatedAt,
    required this.about,
    required this.isVerified,
    required this.image,
  });
  late final int id;
  late final Token token;
  late final String email;
  late final String name;
  late final String type;
  late final String username;
  late final bool isActive;
  late final bool isSuperuser;
  late final String mobile;
  late final String createdAt;
  late final String updatedAt;
  late final String about;
  late final bool isVerified;
  late final String image;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    token = Token.fromJson(json['token']);
    email = json['email'];
    name = json['name'];
    type = json['type'];
    username = json['username'];
    isActive = json['is_active'];
    isSuperuser = json['is_superuser'];
    mobile = json['mobile'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    about = json['about'];
    isVerified = json['is_verified'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['token'] = token.toJson();
    _data['email'] = email;
    _data['name'] = name;
    _data['type'] = type;
    _data['username'] = username;
    _data['is_active'] = isActive;
    _data['is_superuser'] = isSuperuser;
    _data['mobile'] = mobile;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['about'] = about;
    _data['is_verified'] = isVerified;
    _data['image'] = image;
    return _data;
  }
}

class Token {
  Token({
    required this.refresh,
    required this.access,
  });
  late final String refresh;
  late final String access;

  Token.fromJson(Map<String, dynamic> json) {
    refresh = json['refresh'];
    access = json['access'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['refresh'] = refresh;
    _data['access'] = access;
    return _data;
  }
}
