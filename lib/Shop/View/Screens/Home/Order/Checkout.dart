// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mall_bud/Controller/Bloc/Order_Authbloc/Orderauthmodel/order_model.dart';
// import 'package:mall_bud/Controller/Bloc/Order_Authbloc/Orderauthmodel/order_bloc.dart';
// import 'package:mall_bud/Shop/View/Screens/Home/Order/shop_payment_successfull.dart';
// import 'package:mall_bud/Widgets/Constants/Loading.dart';
//
// class ShopCheckoutPage extends StatefulWidget {
//   final String riderName;
//   final String riderContact;
//   final String deliveryTime;
//   final String ownerName;
//   final String ownerMobile;
//   final String vehicleNumber;
//   final String vehicleName;
//   final String vehicleColor;
//   final String parkingFloor;
//   final String parkingPillar;
//   final String Userid;
//   final String Riderid;
//   final String useremail;
//   final String ownerContact;
//   final String invoiceId;
//
//   const ShopCheckoutPage({
//     super.key,
//     required this.riderName,
//     required this.riderContact,
//     required this.deliveryTime,
//     required this.ownerName,
//     required this.ownerMobile,
//     required this.vehicleNumber,
//     required this.vehicleName,
//     required this.vehicleColor,
//     required this.parkingFloor,
//     required this.parkingPillar,
//     required this.useremail,
//     required this.ownerContact,
//     required this.invoiceId,
//     required this.Userid,
//     required this.Riderid,
//   });
//
//   @override
//   _ShopCheckoutPageState createState() => _ShopCheckoutPageState();
// }
//
// class _ShopCheckoutPageState extends State<ShopCheckoutPage> {
//   final _formKey = GlobalKey<FormState>();
//
//   void _registerUser() {
//     if (_formKey.currentState?.validate() ?? false) {
//       OrderModel order = OrderModel(
//         conatctrider: widget.riderContact,
//         Ridername: widget.riderName,
//         useremail: widget.useremail,
//         invoiceid: widget.invoiceId,
//         Ownername: widget.ownerName,
//         userphone: widget.ownerMobile,
//         Shopname: widget.ownerName,
//         Selectfloor: widget.parkingFloor,
//         vehicle_name: widget.vehicleName,
//         vehicle_color: widget.vehicleColor,
//         vehicle_number: widget.vehicleNumber,
//       );
//       // Trigger the sign-up event
//       context.read<OrderBloc>().add(PlaceorderEvent(order: order));
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Checkout (3/4)"),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey, // Assign form key
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildSectionTitle("Rider Details"),
//               _buildTextField("Rider Name", widget.riderName),
//               _buildTextField("Contact", widget.riderContact),
//               const SizedBox(height: 8),
//               _buildDeliveryTimeBox(widget.deliveryTime),
//               const Divider(height: 30),
//               _buildSectionTitle("Customer Details"),
//               _buildTextField("Owner Name", widget.ownerName),
//               _buildTextField("Mobile Number", widget.ownerMobile),
//               _buildTextField("Vehicle Number", widget.vehicleNumber),
//               _buildTextField("Vehicle Name", widget.vehicleName),
//               _buildTextField("Vehicle Color", widget.vehicleColor),
//               const Divider(height: 30),
//               _buildSectionTitle("Payment Details"),
//               _buildTextField("Delivery Charges", "₹ 200", isEditable: false),
//               const Spacer(),
//               SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: BlocConsumer<OrderBloc, OrderState>(
//                   listener: (context, state) {
//                     if (state is OrderSuccess) {
//                       Navigator.push(context, MaterialPageRoute(
//                         builder: (context) {
//                           return ShopPaymentSuccessfulScreen();
//                         },
//                       ));
//                     }
//                   },
//                   builder: (context, state) {
//                     return ElevatedButton(
//                       onPressed: _registerUser,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.green,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       child: state is OrderLoading
//                           ? Loading_Widget()
//                           : Text(
//                               "Place Order",
//                               style:
//                                   TextStyle(fontSize: 18, color: Colors.white),
//                             ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTextField(String label, String value, {bool isEditable = true}) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 10),
//       child: TextFormField(
//         initialValue: value,
//         enabled: isEditable,
//         validator: (text) {
//           if (text == null || text.trim().isEmpty) {
//             return "$label is required";
//           }
//           return null;
//         },
//         decoration: InputDecoration(
//           labelText: label,
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//           filled: true,
//           fillColor: isEditable ? Colors.white : Colors.grey[200],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSectionTitle(String title) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 6),
//       child: Text(
//         title,
//         style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//       ),
//     );
//   }
//
//   Widget _buildDeliveryTimeBox(String time) {
//     return Row(
//       children: [
//         const Text("Delivery Time:",
//             style: TextStyle(fontSize: 14, color: Colors.black87)),
//         const SizedBox(width: 8),
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//           decoration: BoxDecoration(
//             color: Colors.white38,
//             border: Border.all(width: 0.7, color: Colors.grey),
//             borderRadius: BorderRadius.circular(6),
//           ),
//           child: Text(time,
//               style:
//                   const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mallbuddyproject/Shop/View/Screens/Home/Order/shop_payment_successfull.dart';

import '../../../../../Controller/Bloc/Order_Authbloc/Orderauthmodel/order_model.dart';
import '../../../../../Controller/Bloc/Order_Authbloc/order_bloc.dart';
import '../../../../../Controller/Bloc/Shop_Authbloc/shopbloc_bloc.dart';
import '../../../../../Widgets/Constants/Loading.dart';


class ShopCheckoutPage extends StatefulWidget {
  final String riderName;
  final String riderContact;
  final String deliveryTime;
  final String ownerName;
  final String ownerMobile;
  final String vehicleNumber;
  final String vehicleName;
  final String vehicleColor;
  final String parkingFloor;
  final String parkingPillar;
  final String Userid;
  final String Riderid;
  final String useremail;
  final String ownerContact;
  final String invoiceId;

  const ShopCheckoutPage({
    super.key,
    required this.riderName,
    required this.riderContact,
    required this.deliveryTime,
    required this.ownerName,
    required this.ownerMobile,
    required this.vehicleNumber,
    required this.vehicleName,
    required this.vehicleColor,
    required this.parkingFloor,
    required this.parkingPillar,
    required this.useremail,
    required this.ownerContact,
    required this.invoiceId,
    required this.Userid,
    required this.Riderid,
  });

  @override
  _ShopCheckoutPageState createState() => _ShopCheckoutPageState();
}

class _ShopCheckoutPageState extends State<ShopCheckoutPage> {
  void _registerUser() {
    OrderModel order = OrderModel(
        conatctrider: widget.riderContact,
        Ridername: widget.riderName,
        useremail: widget.useremail,
        invoiceid: widget.invoiceId,
        Ownername: widget.ownerName,
        userphone: widget.ownerMobile,
        shopid: shopid_global.toString(),
        Selectfloor: widget.parkingFloor,
        vehicle_name: widget.vehicleName,
        vehicle_color: widget.vehicleColor,
        vehicle_number: widget.vehicleNumber,
        userid: widget.Userid,
        riderid: widget.Riderid);
    context.read<OrderBloc>().add(PlaceorderEvent(order: order));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout (3/4)"),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection("Rider Details", [
              _buildDetail("Rider Name", widget.riderName),
              _buildDetail("Contact", widget.riderContact),
              _buildDetail("Delivery Time", widget.deliveryTime),
            ]),
            const Divider(height: 30),
            _buildSection("Customer Details", [
              _buildDetail("Owner Name", widget.ownerName),
              _buildDetail("Mobile Number", widget.ownerMobile),
              _buildDetail("Vehicle Number", widget.vehicleNumber),
              _buildDetail("Vehicle Name", widget.vehicleName),
              _buildDetail("Vehicle Color", widget.vehicleColor),
              _buildDetail("Parking Floor", widget.parkingFloor),
              _buildDetail("Parking Pillar", widget.parkingPillar),
            ]),
            const Divider(height: 30),
            _buildSection("Payment Details", [
              _buildDetail("Delivery Charges", "₹ 200"),
            ]),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: BlocConsumer<OrderBloc, OrderState>(
                listener: (context, state) {
                  if (state is OrderSuccess) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShopPaymentSuccessfulScreen(),
                        ));
                  }
                },
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: _registerUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: state is OrderLoading
                        ? Loading_Widget()
                        : const Text("Place Order",
                            style:
                                TextStyle(fontSize: 18, color: Colors.white)),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(title,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        ...children,
      ],
    );
  }

  Widget _buildDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          Text(value,
              style: const TextStyle(fontSize: 14, color: Colors.black87)),
        ],
      ),
    );
  }
}
