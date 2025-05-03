class Shops {
  final String Owner_Name;
  final String Shop_Name;
  final String Floor;
  final String Phone_Number;
  final String Email_ID;


  Shops({
    required this.Owner_Name,
    required this.Shop_Name,
    required this.Floor,
    required this.Phone_Number,
    required this.Email_ID,

  });
}

List<Shops> shops = [
  Shops(
      Owner_Name: "Kavya",
      Shop_Name: "Zara",
      Floor: "3",
      Phone_Number: "8921669037",
      Email_ID: "kavya@gmail.com",
     ),
 ];