class JobPost {
  int? id;
  String? title;
  String? place;
  String? companyName;
  String? image;
  String? description;
  String? jobType;
  String? jobLocationType;
  String? url;
  DateTime? createdAt;
  DateTime? updatedAt;

  JobPost({
    this.id,
    this.title,
    this.place,
    this.companyName,
    this.image,
    this.description,
    this.jobType,
    this.jobLocationType,
    this.url,
    this.createdAt,
    this.updatedAt,
  });

  factory JobPost.fromJson(Map<String, dynamic> json) => JobPost(
        id: json['id'] as int?,
        title: json['title'] as String?,
        place: json['place'] as String?,
        companyName: json['companyName'] as String?,
        image: json['image'] as String?,
        description: json['description'] as String?,
        jobType: json['jobType'] as String?,
        jobLocationType: json['jobLocationType'] as String?,
        url: json['url'] as String?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'place': place,
        'companyName': companyName,
        'image': image,
        'description': description,
        'jobType': jobType,
        'jobLocationType': jobLocationType,
        'url': url,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}

class JOB_TYPE {
  static const FULL_TIME = 'fulltime';
  static const PART_TIME = 'parttime';
  static const CONTRACT = 'contract';
  static const INTERNSHIP = 'internship';
  static const TEMPORARY = 'temporary';
}

class JOB_LOCATION_TYPE {
  static const ONSITE = 'onsite';
  static const REMOTE = 'remote';
  static const HYBRID = 'hybrid';
}
