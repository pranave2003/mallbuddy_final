class UserModel {
  String? email;
  String? password;
  String? uid;
  String? name;
  String? phone;
  String? status;

  String? Subtitle;
  String? Ban;
  String? Image;

  UserModel({
    this.email,
    this.password,
    this.name,
    this.uid,
    this.phone,
    this.status,
    this.Ban,
    this.Image,
    this.Subtitle,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      email: data['email'],
      uid: data['userId'],
      name: data['name'],
      phone: data['phone_number'],
      status: data['status'],
      Ban: data['ban'],
      Image: data['imagepath'],
      Subtitle: data['subtitle'],
    );
  }
}
