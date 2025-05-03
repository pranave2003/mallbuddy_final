class Complete_Orders {
  final String Customer_Name;
  final String Order_ID;
  final String Invoice_ID;
  final String Rider_ID;
  final String Rider_Name;
  final String Total_Amount;
  final String Status;
  final String Id;

  Complete_Orders({
    required this.Customer_Name,
    required this.Order_ID,
    required this.Invoice_ID,
    required this.Rider_ID,
    required this.Rider_Name,
    required this.Total_Amount,
    required this.Id,
    required this.Status,
  });
}

List<Complete_Orders> completeorders = [
  Complete_Orders(
      Customer_Name: "Kavya",
      Order_ID: "dfg",
      Invoice_ID: "sdfg",
      Rider_ID: "dfgh",
      Rider_Name: "Adhi",
      Total_Amount: "1000",
      Id: "dfg",
      Status: "Delivered"),];