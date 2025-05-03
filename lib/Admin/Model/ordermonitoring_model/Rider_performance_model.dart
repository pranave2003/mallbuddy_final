class Rider {
  final String Rider_ID;
  final String Rider_Name;
  final String Order_ID;
  final String Invoice_ID;
  final String Total_Delivery;
  final String Total_Amount;
  final String Id;
  final String Rating;

  Rider({
    required this.Rider_ID,
    required this.Rider_Name,
    required this.Order_ID,
    required this.Invoice_ID,
    required this.Total_Delivery,
    required this.Total_Amount,
    required this.Id,
    required this.Rating,
  });
}


List<Rider> riders = [
  Rider(
      Rider_ID:"d85",
      Rider_Name: "Kavya",
      Order_ID: "dfg",
      Invoice_ID: "sdfg",
      Total_Delivery: "10",
      Total_Amount: "1000",
      Id: "dfg",
      Rating: "4"),];