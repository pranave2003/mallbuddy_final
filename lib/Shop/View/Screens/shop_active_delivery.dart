import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Controller/Bloc/Order_Authbloc/order_bloc.dart';
import '../../../Widgets/Constants/Loading.dart';

class ActiveDeliverywrapper extends StatelessWidget {
  const ActiveDeliverywrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderBloc>(
      create: (context) => OrderBloc()
        ..add(
          FetchPlaceorderEvent(
            searchQuery: null,
            status: '0',
          ),
        ),
      child: ActiveDeliveryPage(),
    );
  }
}

class ActiveDeliveryPage extends StatelessWidget {
  final List<Map<String, dynamic>> orders = List.generate(
      2,
      (index) => {
            "orderId": "#12345",
            "customerName": "Kavya Krishnan K K",
            "invoices": [
              "Zara Invoice 1 (ID#123)",
              "Zara Invoice 2 (ID#231)",
              "Max Invoice 1 (ID#215)",
            ],
            "rider": "Adhi",
            "riderId": "Adhi01",
            "deliveryTime": "10:00 am",
            "deliveryLocation": "First floor, H01",
            "status": "Pending",
          });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Active delivery", style: TextStyle(color: Colors.blue)),
        iconTheme: IconThemeData(color: Colors.blue),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocConsumer<OrderBloc, OrderState>(
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
                child: Container(
                    child: ListView.builder(
                        itemCount: state.Orders.length,
                        itemBuilder: (context, index) {
                          final Order = state.Orders[index];

                          return Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
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
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                            color:Order.status=="0"? Colors.red.shade100:Colors.blue,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Text(Order.status=="0"?"Pending":"Progress"
                                            ,
                                            style: TextStyle(
                                                color:Order.status=="0"? Colors.red:Colors.blue, fontSize: 12),
                                          ),
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
                                      ],
                                    ),
                                  ]),
                          ));
                        })
                ));
          }
          return SizedBox();
        },
      ),
    );
  }
}
