class User {
  User({
    required this.email,
    required this.name,
  });
  late final String email;

  late final String name;

  User.fromJson(Map<String, dynamic> json) {
    print(json);
    email = json['email'];

    name = json['name'];
  }
}
