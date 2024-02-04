class Post {
  Post({
    required this.id,
    required this.title,
    required this.place,
    required this.companyName,
  });
  late final int id;
  late final String title;
  late final String place;
  late final String companyName;

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    place = json['place'];
    companyName = json['companyName'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['place'] = place;
    _data['companyName'] = companyName;
    return _data;
  }
}
