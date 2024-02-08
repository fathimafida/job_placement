class Post {
  Post({
    required this.id,
    required this.title,
    required this.place,
    required this.companyName,
    required this.image,
    required this.description,
    required this.jobType,
  });
  late final int id;
  late final String title;
  late final String place;
  late final String companyName;
  late final String image;
  late final String description;
  late final String jobType;
  late final String url;

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    place = json['place'];
    companyName = json['companyName'];
    image = json['image'];
    description = json['description'];
    jobType = json['jobType'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['place'] = place;
    _data['companyName'] = companyName;
    _data['image'] = image;
    _data['description'] = description;
    _data['jobType'] = jobType;
    return _data;
  }
}

final jobLists = [
  Post(
      id: 1,
      title: "Product engineer",
      place: "Chennai, Tamil Nadu, India",
      companyName: "KLA",
      image: "http://localhost:8000/media/images/kla.jpg",
      description:
          "Company Overview\r\nKLA is a global leader in diversified electronics for the semiconductor manufacturing ecosystem.  No laptop, smartphone, wearable device, voice-controlled gadget, flexible screen, VR device or smart car would have made it into your hands without us. KLA invents systems and solutions for the manufacturing of wafers and reticles, integrated circuits, packaging, printed circuit boards and flat panel displays.  The MACH team's mission is to collaborate with our customers to innovate technologies and solutions that detect and control highly complex process v Master's Level Degree and related work experience of 3 years; Bachelor's Level Degree and related work experience of 5 years",
      jobType: "Full-time  Associate")
];
