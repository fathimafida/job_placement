class Post {
  Post({
    required this.id,
    required this.title,
    required this.place,
    required this.companyName,
    required this.image,
    required this.description,
  });
  late final int id;
  late final String title;
  late final String place;
  late final String companyName;
  late final String image;
  late final String description;

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    place = json['place'];
    companyName = json['companyName'];
    image = json['image'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['place'] = place;
    _data['companyName'] = companyName;
    _data['image'] = image;
    _data['description'] = description;
    return _data;
  }
}
