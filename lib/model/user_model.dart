class UserModel {
  String name;
  String email;
  String phone;
  String dob;
  String password;
  String tnc;
  double rewards;
  String tier;
  String image;

  UserModel(
      {required this.tier,
      required this.name,
      required this.email,
      required this.phone,
      required this.dob,
      required this.password,
      required this.tnc,
      required this.rewards,
      required this.image});

  Map<String, dynamic> toMap() => {
        "tier": tier,
        "name": name,
        "email": email,
        "phone": phone,
        "dob": dob,
        "password": password,
        "tnc": tnc,
        "rewards": rewards,
        "image": image,
      };
}
