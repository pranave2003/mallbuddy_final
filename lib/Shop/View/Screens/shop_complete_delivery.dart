import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../Controller/Bloc/Buddy_Authbloc/buddy_auth_bloc.dart';
import '../../../Controller/Bloc/Order_Authbloc/order_bloc.dart';
import '../../../Controller/Bloc/Shop_Authbloc/shopbloc_bloc.dart';
import '../../../Widgets/Constants/Loading.dart';
import '../../../Widgets/Constants/colors.dart';
import 'ShopCompleteviewdetails.dart';

class CompleteDeliverywrapper extends StatelessWidget {
  const CompleteDeliverywrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderBloc>(
      create: (context) => OrderBloc()
        ..add(
          FetchPlaceorderEvent(
            searchQuery: null,
            status: "1",
              shopid: shopid_global,
              Deliverd: "1"
          ),
        ),
      child: Builder(
        builder: (context) {
          return CompleteDeliveryPage(); // now has the right context
        },
      ),    );
  }
}

class CompleteDeliveryPage extends StatelessWidget {
  final List<Map<String, dynamic>> orders = List.generate(2, (index) => {
    "orderId": "#12345",
    "riderId": "#12345",
    "customerName": "Kavya Krishnan K K",
    "status": "Delivered",
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Complete Delivery",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body:  BlocConsumer<OrderBloc, OrderState>(
        listener: (context, state) {
      // TODO: implement listener
    },
    builder: (context, state) {
    if (state is OrderLoading) {
    return Center(child: Loading_Widget());
    } else if (state is Orderfailerror) {
    return Text(state.error.toString());
    } else if (state is Ordersloaded) {
      if (state.Orders.isEmpty) {
        // Return "No data found" if txhe list is empty
        return Center(
          child: Text(
            "No data found",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        );
      }
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: state.Orders.length,
          itemBuilder: (context, index) {
            final Order = state.Orders[index];

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// **Order ID & Status**
              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  Text("Order_ID"),
                  Text(
                    Order.orderid.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold),
                  ),

                ],
              ),
              SizedBox(height: 10),

              /// **Customer Name & Image**
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage:
                    AssetImage("assets/profile/girl.png"),
                  ),
                  SizedBox(width: 8),
                  Text(
                    Order.Ownername.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold),
                  ),SizedBox(width: 95,),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ShopCompleteDeliverydetails(),));
                    },
                    child: Text(
                      "see details >",
                      style: TextStyle(color: defaultBlue, fontSize: 14),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),

              /// **Invoices**
              Column(
                children: [
                  Row(
                    children: [
                      Text("Invoice_ID"),
                      Text(Order.invoiceid.toString()),
                    ],
                  ),
                  SizedBox(height: 10),

                  /// **Rider Information**
                  Row(
                    children: [
                      Text("Rider_ID"),
                      Text(Order.riderid.toString()),
                    ],
                  ),
                  SizedBox(height: 10),

                  /// **Delivery Time & Location**
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Delivery Time"),
                      Text(
                        Order.time.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Delivery Location"),
                      Text(
                        Order.Selectfloor.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color:Order.deliverd=="0"? Colors.blue: Colors.green.shade50,border: Border.all(color: Colors.green,width: 2),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child:   Text(Order.deliverd=="0"? "progress":"Delivered",
                        style: TextStyle(
                            color: Order.deliverd=="0"? Colors.blue:Colors.green, fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ]),

        // child: Row(
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [
        //     /// **Profile Image (Left Side)**
        //     const CircleAvatar(
        //       radius: 38,
        //       backgroundImage: AssetImage("assets/profile/girl.png"),
        //     ),
        //     const SizedBox(width: 10),
        //
        //     /// **Order Details (Right Side)**
        //     Expanded(
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           /// **Order ID & "See Details" Button**
        //           Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //             children: [
        //               Text("Order_ID"),
        //               Text(
        //                 Order.orderid.toString(),
        //                 style: TextStyle(
        //                     fontWeight: FontWeight.bold),
        //               ),
        //               TextButton(
        //                 onPressed: () {
        //                   Navigator.push(context, MaterialPageRoute(builder: (context) => ShopCompleteDeliverydetails(),));
        //                 },
        //                 child: Text(
        //                   "see details >",
        //                   style: TextStyle(color: defaultBlue, fontSize: 14),
        //                 ),
        //               ),
        //             ],
        //           ),
        //           // const SizedBox(height: 5),
        //
        //           /// **Rider ID**
        //           Text(
        //             "${Order.riderid.toString()}",
        //             style:
        //             TextStyle(fontWeight: FontWeight.bold),
        //           ),
        //           const SizedBox(height: 5),
        //
        //           /// **Customer Name**
        //         Text(
        //           "${Order.Ownername.toString()}",
        //           style:
        //           TextStyle(fontWeight: FontWeight.bold),
        //         ), SizedBox(height: 20),
        //
        //           /// **Delivery Status (Right Aligned)**
        //           Align(
        //             alignment: Alignment.centerRight,
        //             child: Container(
        //               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        //               decoration: BoxDecoration(
        //                 color:Order.deliverd=="0"? Colors.blue: Colors.green.shade50,border: Border.all(color: Colors.green,width: 2),
        //                 borderRadius: BorderRadius.circular(5),
        //               ),
        //               child:   Text(Order.deliverd=="0"? "progress":"Delivered",
        //                 style: TextStyle(
        //                     color: Order.deliverd=="0"? Colors.blue:Colors.green, fontSize: 12),
        //               ),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
          },
        ),
      );
    }
    return SizedBox();
    },
      ),
    );
  }
}
