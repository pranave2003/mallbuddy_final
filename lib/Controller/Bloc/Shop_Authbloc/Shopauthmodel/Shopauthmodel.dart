class ShopModel {
  String? email;
  String? password;
  String? uid;
  String? Ownername;
  String? phone;
  String? status;
  String? Ban;
  String? Image;
  String? Shopname;
  String? Selectfloor;



  ShopModel(
      {this.email,
        this.password,
        this.Ownername,
        this.uid,
        this.phone,
        this.status,
        this.Ban,
        this.Image,
        this.Shopname,
        this.Selectfloor,
      });

  factory ShopModel.fromMap(Map<String, dynamic> data) {
    return ShopModel(
      email: data['email'],
      uid: data['userId'],
      Shopname: data['Shopname'],
      Ownername: data['Ownername'],
      phone: data['phone_number'],
      status: data['status'],
      Ban: data['ban'],
      Image: data['imagepath'],
      Selectfloor: data['selecfloor'],


    );
  }
}
















