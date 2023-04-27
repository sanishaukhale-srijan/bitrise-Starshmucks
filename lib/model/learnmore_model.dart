class LearnMoreModel {
  late String image;
  late String title;
  late String tag;
  late String desc;

  LearnMoreModel({
    required this.title,
    required this.tag,
    required this.image,
    required this.desc,
  });

  factory LearnMoreModel.fromJson(Map<String, dynamic> json) => LearnMoreModel(
      title: json['title'],
      image: json['image'],
      desc: json['desc'],
      tag: json['tag']);
}
