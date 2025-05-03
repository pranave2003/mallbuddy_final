class OrderModel {
  String? useremail;
  // String? Dateandtime;
  String? userid;
  String? invoiceid;
  String? orderid;
  String? riderid;
  String? Ownername;
  String? userphone;
  String? status;
  String? time;
  String? shopid;
  String? Selectfloor;
  String? vehicle_name;
  String? vehicle_color;
  String? vehicle_number;
  String? Ridername;
  String? username;
  String? shopname;
  String? conatctrider;
  String? rideremail;
  String? payment;
  String? deliverd;
  String? complaint;
  String? complaintstatus;
  String? complainttype;
  String? Review;
  String? Ratingstatus;
  String? sendReply;
  String? sendReplystatus;


  OrderModel(
      {this.useremail,
      this.Ownername,
      this.userid,
      // this.Dateandtime,
      this.riderid,
      this.invoiceid,
      this.userphone,
      this.time,
      this.status,
      this.shopid,
      this.deliverd,
      this.Selectfloor,
      this.vehicle_name,
      this.vehicle_color,
      this.vehicle_number,
      this.Ridername,
      this.conatctrider,
      this.payment,
      this.rideremail,
      this.complaint,
      this.complaintstatus,
        this.complainttype,
        this.Review,
        this.Ratingstatus,
      this.orderid,
        this.sendReply,
        this.sendReplystatus,
        this.shopname,
        this.username,
      });

  factory OrderModel.fromMap(Map<String, dynamic> data) {
    return OrderModel(
      useremail: data['useremail'],
      orderid: data['orderid'],
      userid: data['uid'],
      riderid: data["riderid"],
      invoiceid: data['invoiceid'],
      shopid: data['shopname'],
      deliverd: data["Deliverd"],
      Ownername: data['ownername'],
      userphone: data['userphone'],
      status: data['status'],
      Selectfloor: data['selectfloor'],
      vehicle_name: data['vehicle_name'],
      vehicle_color: data['vehicle_color'],
      vehicle_number: data['vehicle_number'],
      Ridername: data['ridername'],
      conatctrider: data['contact_rider'],
      rideremail: data['rideremail'],
      payment: data['payment'],
      // Dateandtime: data['Timestamp'],
      time: data['time'],
      complaintstatus: data['complaintstatus'],
      complainttype: data['complainttype'],
      complaint: data['complaint'],
      Review: data['Review'],
      Ratingstatus: data['Ratingstatus'],
      sendReply: data['sendReply'],
      sendReplystatus: data['sendReplystatus'],
      shopname: data['shopname'],
      username: data['username'],


    );
  }
}
