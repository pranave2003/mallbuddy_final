import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Controller/Bloc/Order_Authbloc/order_bloc.dart';
import '../../../../Controller/Bloc/Shop_Authbloc/shopbloc_bloc.dart';
import '../../../../Controller/Bloc/User_Authbloc/auth_bloc.dart';
import '../../../../Shop/View/Screens/ordersstatus/shoporderhistory.dart';
import '../../../../Widgets/Constants/Loading.dart';
import '../../../../Widgets/Constants/colors.dart';
import '../orderhistory.dart';

class allordersScreenwrapper extends StatelessWidget {
  const allordersScreenwrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderBloc>(
      create: (context) => OrderBloc()
        ..add(
          FetchPlaceorderEvent(
              searchQuery: null, status: '0', userid: userid_global),
        ),
      child: allordersScreen(),
    );
  }
}

class allordersScreen extends StatefulWidget {
  @override
  _allordersScreenState createState() => _allordersScreenState();
}

class _allordersScreenState extends State<allordersScreen> {
  Map<int, TimeOfDay?> updatedTimes = {};
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderBloc, OrderState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is OrderLoading) {
          return Center(child: Loading_Widget());
        } else if (state is Orderfailerror) {
          return Center(child: Text(state.error.toString()));
        } else if (state is Ordersloaded) {
          if (state.Orders.isEmpty) {
            return Center(
              child: Text(
                "No data found",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            );
          }
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListView.builder(
              itemCount: state.Orders.length,
              itemBuilder: (context, index) {
                final order = state.Orders[index];
                final currentTime = updatedTimes[index] ?? TimeOfDay.now();
// Fixed variable name
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    // Removed the unnecessary comma
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Order_ID:"),
                          Text(
                            order.orderid.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.yellow.shade50,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              order.status == "0" ? "Pending" : "",
                              style:
                                  TextStyle(color: Colors.yellow, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Rider_ID"),
                              Text(order.riderid.toString()),
                            ],
                          ),
                          SizedBox(height: 10),

                          /// **Delivery Time & Location**
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Delivery Time"),
                              Row(
                                children: [
                                  Text(
                                    order.time.toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 8),
                                  GestureDetector(
                                    onTap: () async {
                                      TimeOfDay? picked = await showTimePicker(
                                        context: context,
                                        initialTime: currentTime,
                                      );
                                      if (picked != null) {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title:
                                                Text("Confirm Delivery Time"),
                                            content: Text(
                                                "Set delivery time to ${picked.format(context)}?"),
                                            actions: [
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: Text("Cancel"),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  setState(() {
                                                    context.read<OrderBloc>().add(
                                                        Extenddeliverytimeevent(
                                                            orderid:
                                                                order.orderid,
                                                            updatedtime:
                                                                picked.format(
                                                                    context)));
                                                    updatedTimes[index] =
                                                        picked;
                                                  });
                                                  Navigator.pop(context);
                                                },
                                                child: Text("Update"),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                    },
                                    child: Icon(
                                      Icons.edit,
                                      size: 20,
                                      color: defaultBlue,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Delivery Location"),
                              Text(
                                order.Selectfloor.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),

                          /// **Total Items & Payment**
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Total_Items"),
                              Text("orderitems"), // Fixed concatenation
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Total_Amount"),
                              Text(
                                order.payment.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: defaultBlue),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Orderhistory(
                                    orderId: order.orderid.toString()),
                              ),
                            );
                          },
                          child: Text("Order QR",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }
        return SizedBox();
      },
    );
  }
}
