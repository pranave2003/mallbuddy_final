class BuddyModel {
  String? email;
  String? password;
  String? uid;
  String? name;
  String? phone;
  String? status;
  String? Ban;
  String? Image;
  String? aadhaarimage;
  String? Aadhaarnumber;
  String? Dob;
  String? Gender;
  String? floor;
  String? amount;
  String? Availablestatus;

  BuddyModel(
      {this.email,
      this.password,
      this.name,
      this.uid,
      this.phone,
      this.status,
      this.Ban,
      this.Image,
      this.Dob,
        this.floor,
        this.amount,
        this.Availablestatus,
      this.Gender,
      this.Aadhaarnumber,
      this.aadhaarimage});

  factory BuddyModel.fromMap(Map<String, dynamic> data) {
    return BuddyModel(
      email: data['email'],
      password: data['password'],
      uid: data['userId'],
      name: data['Customername'],
      phone: data['phone_number'],
      status: data['status'],
      Ban: data['ban'],
      floor: data['floor'],
      amount: data['amount'],
      Image: data['imagepath'],
      Dob: data['Dateodbirth'],
      Gender: data['Gender'],
      Availablestatus: data['Availablestatus'],
      Aadhaarnumber: data['aadhaarnumber'],
      aadhaarimage: data['aadhaarimage'],
    );
  }
}
