import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Controller/Bloc/Buddy_Authbloc/buddy_auth_bloc.dart';
import '../../../../Controller/Bloc/Order_Authbloc/order_bloc.dart';
import '../../../../Widgets/Constants/Loading.dart';
import '../../../../Widgets/Constants/colors.dart';
import 'Buddy_completedelivery.dart';


class BuddyCompleteDeliveryFirstScreenwrapper extends StatelessWidget {
  const BuddyCompleteDeliveryFirstScreenwrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderBloc>(
      create: (context) => OrderBloc()
        ..add(
          FetchPlaceorderEvent(
            searchQuery: null,
            status: '1',
              Riderid: buddyid_global,
              Deliverd: "1"
          ),
        ),
      child: Builder(
        builder: (context) {
          return BuddyCompleteDeliveryFirstScreen(); // now has the right context
        },
      ),
    );
  }
}

class BuddyCompleteDeliveryFirstScreen extends StatelessWidget {
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
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          /// **Profile Image (Left Side)**
                          const CircleAvatar(
                            radius: 38,
                            backgroundImage: AssetImage("assets/profile/girl.png"),
                          ),
                          const SizedBox(width: 10),

                          /// **Order Details (Right Side)**
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// **Order ID & "See Details" Button**
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${Order.orderid.toString()}",
                                      style:
                                      TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => BuddyCompleteDeliveryScreen(),));
                                      },
                                      child: Text(
                                        "see details >",
                                        style: TextStyle(color: defaultBlue, fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                                // const SizedBox(height: 5),

                                /// **Customer Name**
                                Text(
                                  "${Order.Ownername.toString()}",
                                  style:
                                  TextStyle(fontWeight: FontWeight.bold),
                                ), SizedBox(height: 20),

                                /// **Delivery Status (Right Aligned)**
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.green.shade50,border: Border.all(color: Colors.green,width: 2),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child:   Text(
                                      "Status : ${Order.status}",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 12),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
